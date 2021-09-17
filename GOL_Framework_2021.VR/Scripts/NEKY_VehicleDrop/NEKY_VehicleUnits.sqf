//	[Side, % of cargo to fill, [Waypoints], Vehicle] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleUnits.sqf";
//	
//	This handles creating units and waypoints that are in the vehicle being dropped.
//	
//	Made by NeKo-ArroW

Private ["_Index","_Group","_UnitTypes","_EmptyCargoSeats","_Temp","_Index","_WPIndex"];

_Side = _This select 0;
_FillCargo = _This select 1;
_Waypoints = _This select 2;
_Vehicle = _This select 3;

#include "NEKY_UnitSettings.sqf"

// Create vehicle crew
_Crew = CreateGroup _Side;
_Driver = _Crew CreateUnit [(_UnitTypes call BIS_FNC_SelectRandom), [0,0,0], [], 0, "NONE"];
_Driver AssignAsDriver _Vehicle;
[_Driver] OrderGetin True;
_Driver MoveInDriver _Vehicle;
_CrewSpots = AllTurrets [_Vehicle,true];
{
	_Temp = _Crew CreateUnit [(_UnitTypes call BIS_FNC_SelectRandom), [0,0,200], [], 0, "NONE"];
	_Temp setDir (GetDir _Vehicle);
	_Temp assignAsTurret [_Vehicle,_x];
	[_Temp] OrderGetIn True;
	_Temp MoveInTurret [_Vehicle,_x];
	if (_Vehicle getCargoIndex _Temp == -1) then 
	{
		[_Temp, "Crew",_Side] call NEKY_VehicleDropAISkill;
	} else {
		unAssignVehicle _Temp;
		moveOut _Temp;
		deleteVehicle _Temp;
	};
} forEach _CrewSpots;

if (_FillCargo > 0) then
{
	_EmptyCargoSeats = (_Vehicle emptyPositions "Cargo");
	for "_i" from 1 to (_EmptyCargoSeats) do
	{
		Private "_Unit";
		_Unit = _Crew CreateUnit [(_UnitTypes call BIS_FNC_selectRandom), [0,0,200], [], 0, "NONE"];
		_Unit setRank "PRIVATE";
		[_Unit, "unit", _Side] call NEKY_VehicleDropAISkill;
		_Unit assignAsCargo _Vehicle;
		_Unit moveInCargo _Vehicle;
		sleep 1;
	};
};

_Crew setCombatMode "BLUE";
_Crew setBehaviour "CARELESS";
WaitUntil {sleep 1; (getPosATL _Vehicle select 2 < 5) && (isNull AttachedTo _Vehicle)};

_Crew setCombatMode "YELLOW";
_Crew setBehaviour "AWARE";

// Group Waypoints
_Index = 0;
_WPIndex = 1;
	
//	Waypoints
if (Count _Waypoints > 1) then
{
	for "_i" from 1 to (count _Waypoints -1) do
	{
		_Crew addWaypoint [(_Waypoints select _Index), 20, _WPIndex];
		[_Crew,_WPIndex] SetWaypointType "MOVE";
		[_Crew,_WPIndex] setWaypointBehaviour "AWARE";
		[_Crew,_WPIndex] setWaypointCombatMode "YELLOW";
		[_Crew,_WPIndex] setWaypointSpeed "NORMAL";
		[_Crew,_WPIndex] SetWaypointFormation "WEDGE";
		_WPIndex = _WPIndex +1;
		_Index = _Index +1;
	};
};
_Crew addWaypoint [(_Waypoints select _Index), 30, _WPIndex];
[_Crew,_WPIndex] SetWaypointType "SAD";
[_Crew,_WPIndex] setWaypointBehaviour "AWARE";
[_Crew,_WPIndex] setWaypointCombatMode "RED";
[_Crew,_WPIndex] setWaypointSpeed "AUTO";
[_Crew,_WPIndex] SetWaypointFormation "WEDGE";
sleep 1;

// 	Add waypoints around the target area
for "_i" from 1 to 5 do
{
	_WPIndex = _WPIndex +1;
	_Temp = [(_Waypoints select _Index), ((_WPDistance * 0.3) + (random (_WPDistance * 0.7))), (random 360)] call BIS_fnc_relPos;
	_Crew addWaypoint [_Temp, 0, _WPIndex];
	[_Crew,_WPIndex] SetWaypointType "SAD";
	[_Crew,_WPIndex] setWaypointBehaviour "AWARE";
	[_Crew,_WPIndex] setWaypointCombatMode "RED";
	[_Crew,_WPIndex] setWaypointSpeed "AUTO";
};