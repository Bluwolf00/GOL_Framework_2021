



/*
	Code: [Spawn Position,"Vehicle Classname",NumberofInfantry,Side,Dismount Position,Range/HuntTrigger] spawn OKS_TroopDismount;
	Example: [[10581.5,10539.1,0],"O_APC_Tracked_02_cannon_F",6,EAST,[10540.3,10145.5,0],[10473.5,10015.5,0]] spawn OKS_TroopDismount;
*/

Params
[
	["_Spawn", objNull, ["",[],objNull]],
	["_Classname", "", [""]],
	["_Soldiers", 0, [0]],
	["_Side", EAST, [SideUnknown]],
	["_Disembark", "", ["",[],objNull]],
	["_HuntRange", 300, [0,objNull]]
];

private ["_Dir","_Leaders","_Units","_SkillVariables","_Skill","_Trigger","_Group","_OKS_ShareInfo"];

// Skill Settings
_SkillVariables = ["aimingspeed","aimingaccuracy","aimingshake","spotdistance","spottime","commanding","general"];	//	Add/Remove AI skill types here and add the number to unit skills below. ( https://community.bistudio.com/wiki/AI_Sub-skills#Sub-Skills )
_Skill = [0.4, 0.35, 0.35, 0.5, 0.6, 0.8, 0.7];	// Higher is better (0 - 1)

// Side specific settings
Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_TL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_TL_F","I_Soldier_TL_F"];
		_Units = ["I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
	};
};


//systemChat str [_Leaders,_Units];

/*
_Settings = [] Call OKS_Ambient_Settings;
_Settings Params ["_SkillVariables","_Skill","_Leaders","_Units"];
*/

	if (typeName _Spawn == "STRING") then {_Spawn = getMarkerPos _Spawn; _Dir = MarkerDir _Spawn};
	if (typeName _Spawn == "OBJECT") then {_Dir = getDir _Spawn; _Spawn = getPos _Spawn; };

	if (typeName _Disembark == "STRING") then {_Disembark = getMarkerPos _Disembark; _Dir = MarkerDir _Disembark};
	if (typeName _Disembark == "OBJECT") then {_Dir = getDir _Disembark; _Disembark = getPos _Disembark; };

		_Vehicle = CreateVehicle [_Classname, _Spawn, [], 0, "CAN_COLLIDE"];
		_Vehicle setDir getDir _Dir;
		_Vehicle setUnloadInCombat [false, false];
		createVehicleCrew _Vehicle;

		sleep 2;
		_Crew = createGroup [_Side,true];
		{[_X] joinSilent _Crew} foreach crew _Vehicle;
		_Crew allowFleeing 0;

		_Group = createGroup [_Side,true];
		_CargoSeats = ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - (["TypeOf _Vehicle",false] call BIS_fnc_crewCount);
		if(_CargoSeats > _Soldiers) then { _CargoSeats = _Soldiers };

			/// Create Leader
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
			_Unit setRank "SERGEANT";
			_Unit MoveInCargo _Vehicle;
			_Group selectLeader _Unit;

		for "_i" from 1 to (_CargoSeats - 1) do
		{
			Private "_Unit";
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
			_Unit setRank "PRIVATE";
			_Unit MoveInCargo _Vehicle;
		};

		///SystemChat str [_Skill,_SkillVariables,_Group];
		[_Group, _SkillVariables, _Skill] Spawn NEKY_Hunt_SetSkill;
		_Group AllowFleeing 0;
		_Vehicle lockCargo true;
		//_Vehicle forceFollowRoad true;
		_Vehicle allowCrewInImmobile true;

		_Unload = _Crew addWaypoint [_Disembark,0];
		_Unload setWaypointType "TR UNLOAD";
		_Unload setWaypointBehaviour "SAFE";

		_Getout = _Group addWaypoint [_Disembark,0];
		_Getout setWaypointType "GETOUT";
		_Getout setWaypointBehaviour "AWARE";



			waitUntil { sleep 10; _Vehicle distance _Disembark < 30 || !canMove _Vehicle || !Alive _Vehicle || {_X distance _Vehicle < 200 && isTouchingGround _X} count AllPlayers >= 1};
			{deleteWaypoint [_Group,(_X select 1)]} foreach waypoints _Group;
			{deleteWaypoint((waypoints _Crew) select 0)}forEach waypoints _Crew;
			_Vehicle forceSpeed 0;
			_Vehicle lockCargo false;
			_Vehicle forceFollowRoad false;

			if(Count (TypeOf _Vehicle call BIS_fnc_AllTurrets) == 0) then {
				{[_X] joinSilent _Group} foreach crew _Vehicle;
			};

			{_Group leaveVehicle _vehicle; doGetOut _X} foreach units _Group;

			waitUntil { sleep 5; {_X in _Vehicle} count units _Group isEqualTo 0 || {Alive _X} count units _Group isEqualTo 0 };
			{deleteWaypoint((waypoints _Crew) select 0)}forEach waypoints _Crew;
			{deleteWaypoint [_Group,(_X select 1)]} foreach waypoints _Group;
			if !(isNil "NEKY_Hunt_Run") then
			{
				if (typeName _HuntRange == "OBJECT") then {
					_Trigger = _HuntRange;
					waitUntil {sleep 10; TriggerActivated _HuntRange};
				}
				else
				{
					_Trigger = createTrigger ["EmptyDetector", _Disembark, false];
					_Trigger setTriggerActivation ["ANYPLAYER", "PRESENT", true];
					_Trigger setTriggerArea [_HuntRange, _HuntRange, 0, false];
					waitUntil {sleep 10; TriggerActivated _Trigger};
				};
				/// Change to massive zone to have unlimited hunt?
				[_Group, nil, _Trigger, 0, 30, 0, {}] Spawn NEKY_Hunt_Run;
			};

			/*
				{_X addEventHandler ["Fired",{
					_OKS_ShareInfo = {

						params ["_Unit"];
						_targets = _Unit targets [true, 300];

						_list = _Unit nearEntities [["Man", "Car", "Motorcycle", "Tank"], 300];
						_nearTeams = _list select {side _X == side _Unit};

						for [{ _i = 0 }, { _i < count _targets }, { _i = _i + 1 }] do {

							(_list select [_i]) reveal [(_targets select [_i]),2];
							systemChat str [_list select [_i],_targets select [_i]];

						};

					};
					[(_this select 0)] spawn _OKS_ShareInfo}]
				} foreach units _Group;

				*/


			_Vehicle forceSpeed 10;
			sleep 5;
			_Vehicle forceSpeed -1;

			while {Alive _Vehicle && !({Alive _X} count units _Group isEqualTo 0)} do {

				//{_Value = leader _Group knowsAbout _X; _Crew reveal [_X,_Value]; sleep 1;} foreach (leader _Group targets [true, 300]);

				if(_Vehicle distance leader _Group > 50) then {
					_Vehicle forceSpeed -1;
					{deleteWaypoint((waypoints _Crew) select 0)}forEach waypoints _Crew;
					_Hold = _Crew addWaypoint [Leader _Group getPos [30,(random 360)],0];
					_Hold setWaypointType "HOLD";
					_Hold setWaypointBehaviour "AWARE";
					sleep 30;
				};
				sleep 30;

			};







