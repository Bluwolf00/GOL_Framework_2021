

// Created by Oksman
/*
	[east,"UK3CB_AAF_O_Mi8AMTSh",helipad,1000,[2,1],1000,getPos egress,true,true] execVM "Scripts\NEKY_AirDrop\OKS_Helicopter_Patrol.sqf";
*/

if (!isServer) exitWith {false};		// Ensures only server

Params [
	["_Side",East,[sideUnknown]],
	["_HelicopterClassname","",[""]],
	["_HelicopterSpawnPosition",objNull,[objNull]],
	["_PatrolRange",1000,[0]],
	["_Units",[2,1]],
	["_ReinforcementRange",1500,[0]],
	["_Egress",[500,500,100],[[]]],		
	["_ShouldSpawnFlying",true,[true]],
	["_SAD",false,[true]]
];

OKS_GetClassesAndSettings = {
	Params ["_Side","_ShouldSpawnFlying"];
	Private ["_HeliClass","_PilotClasses","_CrewClasses","_UnitTypes","_Form"];

	if(_ShouldSpawnFlying) then {
		_Form = "FLY";
	} else {
		_Form = "NONE";
	};

	Switch (_Side) do
	{
		case BLUFOR:	// BLUFOR settings
		{
			_PilotClasses = ["B_Pilot_F"]; // Class names for pilots
			_CrewClasses = ["B_Crew_F"]; // Class names for crew
			//	_UnitTypes = EnemyUnits;
			_UnitTypes = ["B_Soldier_TL_F","B_Soldier_TL_F","B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!
		};
		case OPFOR:		// OPFOR settings
		{
			_PilotClasses = ["O_Pilot_F"]; // Class names for pilots
			_CrewClasses = ["O_Crew_F"]; // Class names for crew
			//	_UnitTypes = EnemyUnits;
			_UnitTypes = ["O_Soldier_TL_F","O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!
		};
		case INDEPENDENT:	// INDEPENDENT Settings
		{
			_PilotClasses = ["I_Pilot_F"]; // Class names for pilots
			_CrewClasses = ["I_Crew_F"]; // Class names for crew
			//	_UnitTypes = EnemyUnits;
			_UnitTypes = ["I_Soldier_TL_F","I_Soldier_TL_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"]; // Class names for unloaded/paradropped units. The first two are team leaders!
		};
	};
	[_PilotClasses,_CrewClasses,_UnitTypes,_Form];
};

OKS_SpawnPilotAndCrew = {

	Params ["_Side","_PilotClasses","_Heli"];
	_HeliGroup = CreateGroup _Side;
	_HeliGroup setVariable ["acex_headless_blacklist",true];
	_HeliGroup setVariable ["lambs_danger_disableAI", true];
	_Pilot = _HeliGroup CreateUnit [(_PilotClasses call BIS_FNC_selectRandom), [0,0,100], [], 0, "NONE"];
	_Pilot assignAsDriver _Heli;
	_Pilot MoveInDriver _Heli;
	_Pilot SetRank "SERGEANT";
	_Pilot setVariable ["oks_disable_hunt",true];

	_CrewSpots = AllTurrets [_Heli,true];
	{
		_Temp = _HeliGroup CreateUnit [(_CrewClasses call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
		_Temp assignAsTurret [_Heli,_x];
		[_Temp] OrderGetIn True;
		_Temp MoveInTurret [_Heli,_x];
		_Temp setVariable ["oks_disable_hunt",true];
		if (_Heli getCargoIndex _Temp == -1) then
		{
			_Temp SetBehaviour "SAFE";
			_Temp SetCombatMode "YELLOW";
		} else {
			unAssignVehicle _Temp;
			moveOut _Temp;
			deleteVehicle _Temp;
		};
	} forEach _CrewSpots;
	_HeliGroup
};

OKS_CreateLoiterPattern = {
	Params ["_Heli","_HeliGroup","_Range"];
	_move = _HeliGroup addWaypoint [_Heli getPos [_Range,0],0];
	_wp = _HeliGroup addWaypoint [getPos _Heli,0];
	_wp setWaypointType "LOITER";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointLoiterAltitude 50;
	_wp setWaypointLoiterRadius _Range;
	_wp setWaypointLoiterType "CIRCLE";
	_wp;
};

OKS_SpawnCargo = {
	Params ["_Heli","_Units","_UnitTypes","_Pilot"];
	Private ["_Groups","_Group"];
	_EmptyCargoSeats = (_Heli emptyPositions "Cargo");
	if ((_Units Select 0) > 0) then
	{
		_Groups = [];
		_UnitsPerGroup = round ( (round (_EmptyCargoSeats * (_Units select 1))) / (_Units select 0) );	// # OF GROUPS = (_Units select 0)  ||  % OF CARGO = (_Units select 1)
		_SpareIndex = ( (round (_EmptyCargoSeats * (_Units select 1))) - (_UnitsPerGroup * (_Units select 0)) );

		for "_y" from 1 to (_Units select 0) do
		{
			_Group = CreateGroup _Side;
			_Group setVariable ["acex_headless_blacklist",true];
			_Group setVariable ["lambs_danger_disableAI", true];
			for "_i" from 1 to (_UnitsPerGroup + _SpareIndex) do
			{
				Private "_Unit";
				if ( (count (units _Group)) == 0 ) then
				{
					_Unit = _Group CreateUnit [(_UnitTypes select 0), [0,0,200], [], 0, "NONE"];
					_Unit setRank "SERGEANT";
				} else {
					_Unit = _Group CreateUnit [(selectRandom _UnitTypes), [0,0,200], [], 0, "NONE"];
					_Unit setRank "PRIVATE";
				};
				_Unit assignAsCargo _Heli;
				_Unit moveInCargo _Heli;
			};
			_Groups pushBackUnique _Group;
		};
	};
	_Groups;
};

_ClassesAndSettings = [_Side,_ShouldSpawnFlying] call OKS_GetClassesAndSettings;
_ClassesAndSettings Params ["_PilotClasses","_CrewClasses","_UnitTypes","_Form"];

_Heli = CreateVehicle [_HelicopterClassname, _HelicopterSpawnPosition, [], 0, _Form];
_Heli setDir (getDir _HelicopterSpawnPosition);
_HeliGroup = [_Side,_PilotClasses,_Heli] call OKS_SpawnPilotAndCrew;
_Pilot = driver _Heli;
_CargoGroups = [_Heli,_Units,_UnitTypes,_Pilot] call OKS_SpawnCargo;
_LoiterWaypoint = [_Heli,_HeliGroup,_PatrolRange] call OKS_CreateLoiterPattern;

waitUntil { sleep 10; {_Side knowsAbout _X > 3.9 && _X distance _Heli < _ReinforcementRange && isTouchingGround _X} count AllPlayers > 0};
_DetectedPlayers = AllPlayers select {_Side knowsAbout _X > 3.9 && _X distance _Heli < _ReinforcementRange && isTouchingGround _X};
_ClosestPlayers = [_DetectedPlayers, [], { _Heli distance _x }, "ASCEND"] call BIS_fnc_sortBy;
_Target = _ClosestPlayers select 0;
_Position = [_Target, 200, 600, 15, 0, 10, 0] call BIS_fnc_findSafePos;
_RelPos = _Position getPos [200,(_Position getDir _Heli)];

if(!isNil "_Position") then {
	deleteWaypoint _LoiterWaypoint;

	_WP1 = _HeliGroup addWaypoint [_RelPos, 0, 2];
	_WP1 SetWaypointType "MOVE";
	_WP1 SetWaypointCombatMode "YELLOW";
	sleep 1;

	_WP2 = _HeliGroup addWaypoint [_Position, 0, 3];
	_WP2 SetWaypointType "TR Unload";
	sleep 1;

	_Pilot SetBehaviour "CARELESS";
	sleep 1;

	if (_SAD) then
	{
		_WP3 = _HeliGroup addWaypoint [getPos _Target, 0, 4];
		_WP3 SetWaypointType "SAD";
		_WP3 SetWaypointBehaviour "AWARE";
		_WP3 SetWaypointCombatMode "RED";
	} else {
		_WP3 = _HeliGroup addWaypoint [_Egress, 0, 4];
		_WP3 SetWaypointType "MOVE";
		sleep 1;
		_WP4 = _HeliGroup addWaypoint [[0,0,100], 0, 5];
		_WP4 SetWaypointType "MOVE";
	};

	[_CargoGroups,_HeliGroup,_Heli,_Position,_Pilot] spawn {
		Params ["_Groups","_HeliGroup","_Heli","_Position","_Pilot"];
		{
			_Group = _X;
			_Group addWaypoint [_Position, 20, 1];
			[_Group,1] SetWaypointType "MOVE";
			[_Group,1] setWaypointBehaviour "AWARE";
			[_Group,1] setWaypointCombatMode "GREEN";
			[_Group,1] setWaypointSpeed "FULL";
			[_Group,1] SetWaypointFormation "WEDGE";
			_Group lockWP True;
			WaitUntil {sleep 1; ( !((Alive _Pilot) or (Alive _Heli)) or ((3 <= (CurrentWaypoint _HeliGroup)) && ((GetPosATL _Heli select 2) > 5)) )};
			sleep 5;
			_Group LockWP false;
			[_Group, 1500, 30, [], [], false] spawn lambs_wp_fnc_taskRush;
			[_HeliGroup, 1500, 60, [], [], false] spawn lambs_wp_fnc_taskHunt;
		} foreach _Groups;
	};
};

if !(_SAD) then
{
	Sleep 20;
	[_Heli,_Egress] Spawn
	{
		Params ["_Heli","_Egress"];
		WaitUntil {sleep 5; ((_Heli distance2D _Egress) < 200) or ((!Alive _Heli) or (!Alive (Driver _Heli)))};

		if ((Alive _Heli) and (Alive (Driver _Heli))) then {{deleteVehicle _x} forEach (Crew _Heli); DeleteVehicle _Heli};
		if ((!Alive _Heli) or (!Alive (Driver _Heli))) then {sleep 600; {deleteVehicle _x} forEach (Crew _Heli); deleteVehicle _Heli};
	};
};