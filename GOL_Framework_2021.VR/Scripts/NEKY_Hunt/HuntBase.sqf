

// Created by Oksman
/*
		Reminder this code needs to be precompiled and initiated using the same method all Neko-Scripts use, the following needs to be inside an init file (Create your own "init.sqf" in mission directory):
		[] execVM "Scripts\NEKY_Hunt\Init.sqf";

		[Base Object, SpawnObject, Trigger, Number Of Waves,Respawn Delay,Side,Number of Soldiers / Vehicle Classname,Refresh Rate] spawn NEKY_Hunt_HuntBase;

		Script Parameters:
    	Base Object - If this object is destroyed the camp will no longer spawn attacks, use something that can be destroyed such as trucks, tents, buildings etc.
		SpawnObject - Set down a small object (box of matches) and face the direction you want the vehicle/group to spawn in
		Trigger - Set up a trigger used to define the hunting space for these reinforcements, set it to Any Players and repeatable for best effect.
		Number of Waves - Select number of waves using a SCALAR value (0-999)
		Respawn Delay - Select in seconds how long between spawns and respawns of waves
		Side - The side of the faction you wanted spawned
		Soldiers or Classname - SCALAR or ARRAY - If you select numbers there will be X amount of soldiers in 1 group. If you input a string Example: "CUP_O_BTR40_MG_TKM" you will get this vehicle crewed by the faction the vehicle is      based on. If you want to have a randomly selected vehicle you can input an Array with strings, example: ["CUP_O_MTLB_pk_TK_MILITIA","CUP_O_BTR40_MG_TKM","CUP_O_Ural_ZU23_TKM","CUP_O_BTR90_RU"]
		Refresh Rate - Time in seconds you want the script to refresh their knowledge of Players inside the hunt zone, quickens the response with shorter refresh, but increases slightly in the performance cost.

		Examples on code:
		[Object_1, Spawn_1, HuntTrigger_1, 10,300,EAST,6,60] spawn NEKY_Hunt_HuntBase;
		[Object_1, Spawn_1, HuntTrigger_1, 10,450,EAST,"CUP_O_BTR40_MG_TKM",30] spawn NEKY_Hunt_HuntBase;
		[Object_1, Spawn_1, HuntTrigger_1, 10,450,EAST,["CUP_O_MTLB_pk_TK_MILITIA","CUP_O_BTR40_MG_TKM","CUP_O_Ural_ZU23_TKM","CUP_O_BTR90_RU"],30] spawn NEKY_Hunt_HuntBase;

		Step-by-Step Guide:
		You need two objects, you need a base object and a spawn object. Place down a destructible object and name it 'Object_1'
		(When this object is destroyed, the "base" is destroyed thus it will not spawn more units)

		Next create a spawn object and name it 'Spawn_1', this could be any object but I suggest using a tiny object such as 'Grass Cutter (Small)'. This is the object the units/vehicle will use to spawn on top of.
		(You can also use a invisible helipad but this will make AI helicopters land on these spawns in some occasions, so not recommended.)

		You now need a Trigger, create a trigger and name it HuntTrigger_1. Set the activation to "Any Players" and set it to "Repeatable". All this is chosen in the trigger properties (Double-click the trigger).
		(This is now the trigger area the enemy spawned units will hunt inside, this means if players are detected within this trigger, they will start spawning units and start hunting. When they leave the AI will cease hunting and cease spawning.)

		You now have all the necessary editor placed objects to use the code. You have a base object, spawn object and a trigger. Now open your spawnList.sqf and paste the following:
		[Object_1, Spawn_1, HuntTrigger_1, 10,300,EAST,6,30] spawn NEKY_Hunt_HuntBase;

		The final properties in the bracket above is:
		Number of Waves, Respawn Delay, Side, Soldiers and Refresh Rate.
		10				 300			EAST  6			   30

		These are the properties you have to change to match whatever you need. Now when you activate your spawnList case through the standard triggers, your base will initiate. To have them spawn in, you need to be detected by the enemy side and reach a knowsAbout value above 3.5. Get into CQB with the enemy and this should activate the hunting bases.

*/

if (!isServer) exitWith {false};	// Ensures only server


Params
[
	["_Base", ObjNull, [ObjNull]],
	["_SpawnPos", ObjNull, [ObjNull]],
	["_HuntZone", ObjNull, [ObjNull]],
	["_Waves", 0, [0]],
	["_RespawnDelay", 0, [0]],
	["_Side", East, [sideUnknown]],
	["_Soldiers", 0, ["",0,[]]],
	["_RefreshRate", 0, [0]],
	["_ShouldDeployFlare",true,[true]]
];

Private ["_Group","_Leaders","_Units","_Vehicle","_VehicleClass","_MaxCargoSeats","_Trigger","_MaxUnits","_KnowsAboutValue","_DetectDelay","_ShouldDeployFlare"];

sleep 5;
_IsNight = false;
_Settings = [] Call NEKY_Hunt_Settings;
_Settings Params ["_MinDistance","_UpdateFreqSettings","_SkillVariables","_Skill","_Leaders","_Units","_MaxCargoSeats"];

	_Trigger = createTrigger ["EmptyDetector", getPosWorld _SpawnPos, false];
	_Trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_Trigger setTriggerArea [300, 300, 0, false];

	_EyeCheck = createVehicle ["Land_ClutterCutter_small_F", [getPos _SpawnPos select 0,getPos _SpawnPos select 1,(getPos _SpawnPos select 2) + 3], [], 0, "CAN_COLLIDE"];
	_EyeCheck hideObject true;
	_EyeCheck enableSimulation false;


while {alive _Base && (_Waves * OKS_ForceMultiplier) > 0} do
{
	//SystemChat "Inside Base & Waves";
	//SystemChat Str [_Side,({isTouchingGround (vehicle _X) && (isPlayer _X)} count list _HuntZone > 0)];

	if ((dayTime > 04.30) and (dayTime < 19.30)) then {_KnowsAboutValue = 3.975} else {_KnowsAboutValue = 3.975; _IsNight = true;};
	SystemChat format["Looking for Players in %1..",_HuntZone];
	if( {(_Side knowsAbout _X > _KnowsAboutValue || _Side knowsAbout vehicle _X > _KnowsAboutValue) && isTouchingGround (vehicle _X) && (isPlayer _X)} count list _HuntZone > 0) then {
		_DetectDelay = round((_RefreshRate * OKS_ResponseMultiplier) + (Random _RefreshRate * OKS_ResponseMultiplier));
		SystemChat format["Players detected in %1 - Delay %2 seconds",_HuntZone,_DetectDelay];
		sleep _DetectDelay;

		SystemChat str [({isTouchingGround (vehicle _X) && (isPlayer _X) && [objNull, "VIEW"] checkVisibility [eyePos _X, getPosASL _EyeCheck] >= 0.6} count AllPlayers < 1),({isTouchingGround (vehicle _X) && (isPlayer _X)} count list _Trigger < 1)];

		if( {isTouchingGround (vehicle _X) && (isPlayer _X) && [objNull, "VIEW"] checkVisibility [eyePos _X, getPosASL _EyeCheck] >= 0.6} count AllPlayers > 0 || {isTouchingGround (vehicle _X) && (isPlayer _X)} count list _Trigger > 0 ) then {
			if({isTouchingGround (vehicle _X) && isPlayer _X} count list _Trigger > 0) exitWith {systemChat "Players Nearby - Exiting Script"};
		}
		else
		{
			if( {(_Side knowsAbout _X > _KnowsAboutValue || _Side knowsAbout vehicle _X > _KnowsAboutValue) && isTouchingGround (vehicle _X) && (isPlayer _X)} count list _HuntZone > 0) then {
				SystemChat format["Players confirmed in %1",_HuntZone];
				if(_ShouldDeployFlare && _IsNight) then {
					_flare = "F_20mm_Red" createvehicle ((_Base) ModelToWorld [0,0,500]); 
					_flare setVelocity [0,0,-10];
				};
				if(typeName _Soldiers == "SCALAR") then
				{
					_Soldiers = _Soldiers * OKS_ForceMultiplier;
					_Waves = _Waves - 1;
					_AliveCurrentCount = NEKY_Hunt_CurrentCount select {alive _X};
					_AliveNumber = count _AliveCurrentCount;
					if(NEKY_Hunt_MaxCount >= (_AliveNumber + _Soldiers)) then {

						_Group = CreateGroup _Side;
						for "_i" from 1 to _Soldiers do
						{
							Private "_Unit";
							if ( (count (units _Group)) == 0 ) then
							{
								_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SpawnPos, [], 0, "NONE"];
								_Unit setRank "SERGEANT";
								NEKY_Hunt_CurrentCount pushBackUnique _Unit;
							} else {
								_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SpawnPos, [], 0, "NONE"];
								_Unit setRank "PRIVATE";
								NEKY_Hunt_CurrentCount pushBackUnique _Unit;

							};
						};

						//SystemChat str [_Skill,_SkillVariables,_Group];
						[_Group, _SkillVariables, _Skill] Spawn NEKY_Hunt_SetSkill;
						_Group AllowFleeing 0;

						sleep 1;
						[_Group, nil, _HuntZone, 0, 30, 0, {}] Spawn NEKY_Hunt_Run;
						///SystemChat "Infantry Spawned...";
				};

				};

				if(typeName _Soldiers == "STRING" || typeName _Soldiers == "ARRAY") then {

					_AliveNumber  = count (NEKY_Hunt_CurrentCount select {alive _X});

					if((NEKY_Hunt_MaxCount * OKS_ForceMultiplier) >= _AliveNumber) then {
						_Waves = _Waves - 1;
						if(typeName _Soldiers == "ARRAY") then {
							_VehicleClass = _Soldiers call BIS_fnc_selectRandom;
							_Vehicle = CreateVehicle [_VehicleClass, _SpawnPos, [], 0, "CAN_COLLIDE"];
							if(GOL_Remove_HE_From_StaticAndVehicle) then {
								[_Vehicle] spawn OKS_RemoveVehicleHE;	
							};	
						}
						else
						{
							_Vehicle = CreateVehicle [_Soldiers, _SpawnPos, [], 0, "CAN_COLLIDE"];
							if(GOL_Remove_HE_From_StaticAndVehicle) then {
								[_Vehicle] spawn OKS_RemoveVehicleHE;	
							};	
						};

						_Vehicle setDir getDir _SpawnPos;

						// Count (TypeOf _Vehicle call BIS_fnc_AllTurrets) == 0
						if((_Vehicle emptyPositions "gunner" == 0)) then {

							SystemChat "Vehicle is a transport";
							_CargoSeats = ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - (["TypeOf _Vehicle",false] call BIS_fnc_crewCount);
							if(_CargoSeats > _MaxCargoSeats) then { _CargoSeats = _MaxCargoSeats };

							_AliveCurrentCount = NEKY_Hunt_CurrentCount select {alive _X};
							_AliveNumber = count _AliveCurrentCount;

							if((_AliveNumber + (_CargoSeats + 1)) <= NEKY_Hunt_MaxCount && _Vehicle emptyPositions "cargo" > 0) then {
									_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

									[_Vehicle] spawn OKS_ForceVehicleSpeed; 
									SystemChat "Creating Transport Cargo...";
									 ///Create Leader
									_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
									_Unit setRank "SERGEANT";
									_Unit MoveInCargo _Vehicle;
									_Group selectLeader _Unit;
									NEKY_Hunt_CurrentCount pushBackUnique _Unit;

								for "_i" from 1 to (_CargoSeats - 1) do
								{
									Private "_Unit";
									_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
									_Unit setRank "PRIVATE";
									NEKY_Hunt_CurrentCount pushBackUnique _Unit;
									_Unit MoveInCargo _Vehicle;
								};
								_Group setVariable ["GW_Performance_autoDelete", false, true];
								///SystemChat str [_Skill,_SkillVariables,_Group];
								[_Group, _SkillVariables, _Skill] Spawn NEKY_Hunt_SetSkill;
								_Group AllowFleeing 0;
							};
						}
						else
						{
							_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

							[_Vehicle] spawn OKS_ForceVehicleSpeed;  
						};

						{NEKY_Hunt_CurrentCount pushBackUnique _X} foreach crew _Vehicle;
					};
					sleep 5;
					if(!isNil "_Group") then {
						if(count units _Group > 1) then {
							[_Group, nil, _HuntZone, 0, 30, 0, {}] Spawn NEKY_Hunt_Run;
						} else {
							deleteVehicle driver _Vehicle;
							deleteVehicle _vehicle;
							systemChat "Only Driver Active - Removing Vehicle..";
						};
					};
				};

				sleep 5;
				_AliveNumber  = count (NEKY_Hunt_CurrentCount select {alive _X});
				//SystemChat format ["%1 Spawned %2 - Current Count %3 - Max Count: %4",_Base,count units _Group,_AliveNumber,NEKY_Hunt_MaxCount];
				sleep (_RespawnDelay * OKS_ResponseMultiplier);
			};
		};
	}
	else
	{
		sleep (_RefreshRate * OKS_ResponseMultiplier);
	};

};

if(!alive _Base) exitWith { SystemChat "Base Destroyed - Exiting Script"; deleteVehicle _Base};
if(_Waves == 0) exitWith { SystemChat "Waves Depleted - Exiting Script"; deleteVehicle _Base};

/*
	Params ["_Side","_Number","_Leaders","_Units","_Pos"];

	_Grp = CreateGroup _Side;
	_Leader = _Grp CreateUnit [(selectRandom _Leaders), [0,0,0], [], 10, "NONE"];
	_Leader SetRank "Sergeant";
	_Pos = getPos _SpawnPos;
	_Leader setPos _Pos;

	For "_i" from 2 to _Number step 1 do
	{
		_Unit = _Grp createUnit [(SelectRandom _Units), _Leader, [], 10, "NONE"];
		_Unit setRank "PRIVATE";
	};

*/



