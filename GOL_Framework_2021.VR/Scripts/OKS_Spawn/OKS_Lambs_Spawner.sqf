/*
	OKS_Lambs_Spawner
	[SpawnPos,"hunt",UnitsPerBase,Side,Range,[],TriggerActivatedToDisableSpawner] spawn OKS_Lambs_Spawner;
	[SpawnPos,"rush",UnitsPerBase,Side,Range,[],TriggerActivatedToDisableSpawner] execVM "Scripts\OKS_Spawn\OKS_Lambs_Spawner.sqf";
*/

 	if(!isServer) exitWith {};

	Params [
		"_SpawnPos",
		["_LambsType","rush",[""]],
		["_NumberInfantry",5,[0]],
		["_Side",east,[sideUnknown]],
		["_Range",1500,[0]],
		["_Array",[],[[]]],
		["_ActivatedToDisableSpawner",objNull,[objNull,""]],
		["_RespawnDelay",180,[0]]
	];
	private ["_RandomPos","_Center","_Condition1","_Condition2"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];

	while {true} do {

		if(typeName _ActivatedToDisableSpawner == "OBJECT") then {
			_Condition1 = (!triggerActivated _ActivatedToDisableSpawner);
			_Condition2 = (triggerActivated _ActivatedToDisableSpawner);
		};
		if(typeName _ActivatedToDisableSpawner == "STRING") then {
			Call Compile Format ["%1 = false",_ActivatedToDisableSpawner];
			_Condition1 = (Call Compile Format ["%1 == false",_ActivatedToDisableSpawner]);
			_Condition2 = (Call Compile Format ["%1 == true",_ActivatedToDisableSpawner]);
		};
		if(!((typeName _ActivatedToDisableSpawner) in ["OBJECT","STRING"])) exitWith {
			SystemChat "ActivatedToDisableSpawner is not string or object. Check parameters for Lambs Spawner..";
		};

		if(_Condition1) then {
			SystemChat "Trigger inactive, spawning new hunter.";
			_Group = CreateGroup _Side;
			_Group setVariable ["acex_headless_blacklist",true,true];
			for "_i" from 1 to round(_NumberInfantry * OKS_ForceMultiplier) do
			{
				Private "_Unit";
				if ( (count (units _Group)) == 0 ) then
				{
					_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SpawnPos getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
					_Unit setRank "SERGEANT";
				} else {
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SpawnPos getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
					_Unit setRank "PRIVATE";
				};
				sleep 0.5;
			};
			{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill"]; _Array pushBackUnique _X } foreach units _Group;
			Call Compile Format ["PublicVariable '%1'",_Array];

			/* 
				Arguments:
				0: Group performing action, either unit <OBJECT> or group <GROUP>
				1: Range of tracking, default is 500 meters <NUMBER>
				2: Delay of cycle, default 15 seconds <NUMBER>
				3: Area the AI Camps in, default [] <ARRAY>
				4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
				5: Only Players, default true <BOOL>
			*/
			sleep 15;
			if(OKS_Suppression isEqualTo 1) then {
				{[_X] remoteExec ["OKS_Suppressed",0]} foreach units _group;
			};	

			waitUntil {sleep 1; !isNil "lambs_wp_fnc_moduleRush"};
			[_Group,_Range,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];

			waitUntil { sleep 5; {Alive _X || [_X] call ace_common_fnc_isAwake} count units _Group < 1};
			systemChat format["Group destroyed or unconscious. Passed WaitUntil. Sleep: %1",_RespawnDelay];
			sleep (_RespawnDelay * OKS_ResponseMultiplier);
		};
		
		if(_Condition2) exitWith {
			systemChat "Spawner Disabled.";
		};
		sleep 10;
	};


