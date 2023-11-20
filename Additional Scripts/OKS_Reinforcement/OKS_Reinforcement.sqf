//	null = [side, "heli type", Search and Destroy or Egress and despawn, "unload/paradrop", "Spawn position", "unload/paradrop position", "Egress/SAD position", [number of groups, % of cargo to be filled], ["unit waypoints", "last waypoint SAD"], override] execVM "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
////////////////////////
//	Parameters
////////////////////////
//
//	1. Side: 	Side of heli crew. (West/BLUFOR,East/OPFOR or Independent works fine)
//	2. String: 	Class name of the type of heli you want to spawn. Type   nil   for default values.
//	3. Array/String:  Spawn position for heli, can be [X,Y,Z] or "Markername".
//	4. Array/String:  Unload / Paradrop position, can be [X,Y,Z] or "Markername".
//	5. Array/String:  Search and Destroy or Egress and despawn position, can be [X,Y,Z] or "Markername".
//	6. Array: [number of groups, % of total cargo to be filled with units]. [2,1] will spawn 2 groups and fill 100% available cargo seats. [4,0.5] will spawn 4 groups and fill 50% available cargo seats.
//	7. Array of [X,Y,Z] or Strings:  Unit waypoints to follow when disembarking, last waypoint is a "Search and Destroy" waypoint. ["FirstWaypoint","SecondWaypoint",[Third,Way,Point]]
//  8. Integer: Selection of Garrison style. 0 = Even spread, 1 = Building by Building, 3 = Random. Defaults as even spread.
////////////////
//	Examples:
////////////////
//
//	null = [west, "", "helicopter_spawn", [1693.65,3061.53,0], "helicopter_despawn", 1, [1476.58,3016.09,0]] execVM "Scripts\OKS_Reinforcement\OKS_Reinforcement.sqf";
//	[west, "", "helicopter_spawn", [1693.65,3061.53,0], "helicopter_despawn", 1, [1476.58,3016.09,0]] execVM "Scripts\OKS_Reinforcement\OKS_Reinforcement.sqf";
//	null = [west, "", "helicopter_spawn", [1693.65,3061.53,0], "helicopter_despawn", 1, [1476.58,3016.09,0]] execVM "Scripts\OKS_Reinforcement\OKS_Reinforcement.sqf";
//
///////////////////////
//	Made By NeKo-ArroW redesigned by Oksman
//	Version 1.01
///////////////////////

if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

Private ["_SpareIndex","_SkillVariables","_Type",
//"_AIPilotSkill","_AICrewSkill","_AIUnitSkill",
"_UnitTypes","_Dir","_UnitsPerGroup",
//"_Sectors",
"_CrewSpots","_PilotClasses","_CrewClasses","_EmptyCargoSeats","_LZ","_TeamLeaders","_Temp","_Side","_Position","_Index","_HeliClass",
//"_UnitsWPs",
"_Group","_Heli","_HeliGroup","_Pilot","_UnitClasses"];

Params
[
	["_Side", west, [SideUnknown]],
	["_HeliType", "", [""]],
	["_Ingress", "", ["",[]]],
	["_InsertMarker", "", ["",[]]],
	["_Egress", "", ["",[]]],
	["_UnitProcentageOfCargo", 1, [1]],
	["_GarrisonPosition", [""], [[""],[]]],
	["_GarrisonSetting", 0,[0]]
];

#include "NEKY_Settings.sqf"

_TeamLeaders = [(_UnitTypes select 0), (_UnitTypes select 1)];
_UnitClasses = [];
_Index = 2;
for "_i" from 1 to ((count _UnitTypes) -2) do
{
	_UnitClasses PushBack (_UnitTypes select _Index);
	_Index = _Index +1;
};

// AI Skill Setting
NEKY_AirDropAISkill =
{
	Private ["_Temp","_Type","_Skill","_Index","_This","_SkillVariables","_HeliClass","_PilotClasses","_CrewClasses","_UnitTypes","_PilotSkill","_CrewSkill","_UnitSkill"];

	Params ["_Temp","_Type","_Side"];
	#include "NEKY_Settings.sqf"

	call Compile Format ["_Skill = _%1Skill",_Type];
	_Index = 0;
	for "_i" from 1 to (count _SkillVariables) do
	{
		_Temp setSkill [(_SkillVariables select _Index), (_Skill select _Index)];
		_Index = _Index +1;
	};
};

// Convert possible markers to XYZ
if (typeName (_GarrisonPosition) == "STRING") then {_Temp = getMarkerPos _GarrisonPosition;};
if (typeName _Ingress == "STRING") then {_Ingress = getMarkerPos _Ingress;};
if (typeName _InsertMarker == "STRING") then {_InsertMarker = getMarkerPos _InsertMarker};
if (typeName _Egress == "STRING") then {_Egress = getMarkerPos _Egress};

// Create Heli and Crew
if (_HeliType == "") then {_HeliType = _HeliClass};

	_Heli = CreateVehicle [_HeliType, _Ingress, [], 0, "FLY"];
	_Direction = [_Heli, _InsertMarker] call BIS_fnc_dirTo;
	_Heli setDir _Direction;
	_Position = [_InsertMarker, 150, (_Direction + 180)] call BIS_fnc_relPos;

	_HeliGroup = CreateGroup _Side;
	_Pilot = _HeliGroup CreateUnit [(_PilotClasses call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
	_Pilot assignAsDriver _Heli;
	_Pilot MoveInDriver _Heli;
	_Pilot SetRank "SERGEANT";
	_Pilot setVariable ["oks_disable_hunt",true];
	[_Pilot, "pilot",_Side] call NEKY_AirDropAISkill;
	removeBackPack _Pilot;
	_Pilot addBackPack "B_Parachute";
	sleep 1;

	_CrewSpots = AllTurrets [_Heli,true];
	{
		_Temp = _HeliGroup CreateUnit [(_CrewClasses call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
		_Temp assignAsTurret [_Heli,_x];
		[_Temp] OrderGetIn True;
		_Temp MoveInTurret [_Heli,_x];
		_Temp setVariable ["oks_disable_hunt",true];
		if (_Heli getCargoIndex _Temp == -1) then
		{
			[_Temp, "crew",_Side] call NEKY_AirDropAISkill;
			removeBackPack _Temp;
			_Temp addBackpack "B_Parachute";
			_Temp SetBehaviour "SAFE";
			_Temp SetCombatMode "YELLOW";
		} else {
			unAssignVehicle _Temp;
			moveOut _Temp;
			deleteVehicle _Temp;
		};
	} forEach _CrewSpots;


sleep 0.5;
Private _EmptyCargoSeats = (_Heli emptyPositions "Cargo");

// Heli waypoints

	_HeliGroup addWaypoint [_Position, 0, 1];
	[_HeliGroup, 1] SetWaypointType "MOVE";
	[_HeliGroup, 1] SetWaypointCombatMode "YELLOW";
	sleep 1;

	_HeliGroup addWaypoint [_InsertMarker, 0, 2];
	[_HeliGroup, 2] SetWaypointType "TR Unload";
	sleep 1;

	_Pilot SetBehaviour "CARELESS";
	sleep 1;

	_HeliGroup addWaypoint [_Egress, 0, 3];
	[_HeliGroup, 3] SetWaypointType "MOVE";
	sleep 1;

	_HeliGroup addWaypoint [[0,0,100], 0, 4];
	[_HeliGroup, 4] SetWaypointType "MOVE";
		
//	Create groups, units and waypoints
_UnitsPerGroup = round ( (round (_EmptyCargoSeats * (_UnitProcentageOfCargo)) ) );	// # OF GROUPS = (_UnitProcentageOfCargo)  ||  % OF CARGO = (_Units select 1)
_SpareIndex = ( (round (_EmptyCargoSeats * (_UnitProcentageOfCargo))) - (_UnitsPerGroup) );

	_Group = CreateGroup _Side;
	_Group setVariable ["GW_Performance_autoDelete", false, true];
	_Group setVariable ["lambs_danger_disableGroupAI", true];

	for "_i" from 1 to (_UnitsPerGroup + _SpareIndex) do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_TeamLeaders call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
			_Unit setRank "SERGEANT";

		} else {
			_Unit = _Group CreateUnit [(_UnitClasses call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
			_Unit setRank "PRIVATE";

		};
		_Unit assignAsCargo _Heli;
		_Unit moveInCargo _Heli;
		if (!isNil "FRAMEWORK_Gear_Run") then { [_Unit, (SelectRandom FRAMEWORK_AI_PresenceRolesDefined)] spawn FRAMEWORK_Gear_Run };
		if (_SpareIndex > 0) then {_SpareIndex = _SpareIndex -1};
		if (_SpareIndex < 0) then {_SpareIndex = _SpareIndex +1};
		sleep 0.5;
	};
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	{_x disableCollisionWith _Heli} forEach (units _Group);

	// Dismount Waypoint
	_DismountWaypoint = _Group addWaypoint [_InsertMarker, 10, 1];
	_DismountWaypoint SetWaypointType "MOVE";
	_DismountWaypoint setWaypointBehaviour "AWARE";
	_DismountWaypoint setWaypointCombatMode "GREEN";
	_DismountWaypoint setWaypointSpeed "FULL";
	_DismountWaypoint SetWaypointFormation "WEDGE";
	_Group lockWP True;

	// Secure Waypoint
	_GroundWaypoint = _Group addWaypoint [_GarrisonPosition, 0,2];
	_GroundWaypoint SetWaypointType "GUARD";
	_GroundWaypoint setWaypointBehaviour "AWARE";
	_GroundWaypoint setWaypointCombatMode "YELLOW";
	_GroundWaypoint setWaypointSpeed "NORMAL";
	_GroundWaypoint SetWaypointFormation "WEDGE";
	sleep 1;
	WaitUntil {sleep 1; ( !((Alive _Pilot) or (Alive _Heli)) or ((3 <= (CurrentWaypoint _HeliGroup)) && ((GetPosATL _Heli select 2) > 5)) )};
	sleep 10;
	_Group LockWP false;
	_Group SetCurrentWaypoint [_Group, 2];

	[_Group,_GarrisonPosition] spawn {
		Params["_Group","_GarrisonPosition"];
		Private["_PositionCount"];
		waitUntil { sleep 10; {_X distance2D _GarrisonPosition < 50 || !Alive _X} count units _Group > (count units _Group / 2)};
		_AllBuildings = (_GarrisonPosition) nearObjects ["House",25];
		_SortedBuildings = [_AllBuildings,[],{(_GarrisonPosition) distance _x},"ASCEND"] call BIS_fnc_sortBy;
		_PositionCount = 0;
		{if(!(isObjectHidden _X)) then {_PositionCount = _PositionCount + (count ([_X] call BIS_fnc_buildingPositions))}} foreach _SortedBuildings;
		if(_PositionCount >= (count units _Group)) then {
			/* 
				* Arguments:
				* 0: The building(s) nearest this position are used <POSITION>
				* 1: Limit the building search to those type of building <ARRAY>
				* 2: Units that will be garrisoned <ARRAY>
				* 3: Radius to fill building(s) <SCALAR> (default: 50)
				* 4: 0: even filling, 1: building by building, 2: random filling <SCALAR> (default: 0)
				* 5: True to fill building(s) from top to bottom <BOOL> (default: false) (note: only works with filling mode 0 and 1)
				* 6: Teleport units <BOOL> (default: false)
			*/
			[_GarrisonPosition, nil, units _Group, 25, _GarrisonSetting, true, false] remoteExec ["ace_ai_fnc_garrison",0];
		};	
	};

//	Despawn if killed or at last waypoint (excluding SAD)
Sleep 20;

[_Heli,_Egress] Spawn
{
	Params ["_Heli","_Egress"];
	WaitUntil {sleep 5; ((_Heli distance2D _Egress) < 200) or ((!Alive _Heli) or (!Alive (Driver _Heli)))};

	if ((Alive _Heli) and (Alive (Driver _Heli))) then {{deleteVehicle _x} forEach (Crew _Heli); DeleteVehicle _Heli};
	if ((!Alive _Heli) or (!Alive (Driver _Heli))) then {sleep 600; {deleteVehicle _x} forEach (Crew _Heli); deleteVehicle _Heli};
};
