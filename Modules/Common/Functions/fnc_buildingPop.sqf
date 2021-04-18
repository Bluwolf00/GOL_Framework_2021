/*
	AUTHOR: GuzzenVonLidl
	Collects all positions and selects a random one to place a unit in

	Usage:
	["randomMarker_1", 50, 15] spawn GW_Common_Fnc_BuildingPop;

	Parameters:
	#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
	#1	NUMBER:	Radius of area	(Optional: Default: 50)
	#2	NUMBER:	Amount of ai spawn

	Return Value: <GROUP>
	Group that spawned

	Public: NO
*/
#include "script_Component.hpp"

//	ERROR("Deprecated function used: GW_Common_Fnc_BuildingPop");

params ["_searchPos","_radius","_unitCount"];
([GVAR(Faction)] call FUNC(getGroupType)) params ["_side", "_leader","_unitList"];

private _getPos = [_searchPos] call FUNC(getPosATL);
private _buildings = [];
private _unitClass = _leader;
private _group = CreateGroup _side;

{
	private _house = ([_x] call BIS_fnc_buildingPositions);
	if (count _house >= 1) then {
		_buildings = (_buildings + _house);
	};
} forEach (nearestObjects [_getPos, ["house"], _radius]);

if (_unitCount > count _buildings) then {
	_unitCount = (count _buildings);
	WARNING("UnitCount exided available positions");
};

for "_i" from 1 to _unitCount step 1 do {
	if !(_i isEqualTo 0) then {
		_unitClass = (selectRandom _unitList);
	};
	_unit = _group createUnit [_unitClass, [0,0,0], [], 10, "CAN_COLLIDE"];
	_unit enableSimulationGlobal false;
	_unit setRank "PRIVATE";
	_unit setVariable [QGVAR(isSpawned), true];
	TRACE_1("Created", _unit);

	_dir = floor(random 360);
	_pos = (selectRandom _buildings);
	_buildings deleteAt (_buildings find _pos);
	_unit setFormDir _dir;
	_unit setDir _dir;
	_unit setPosATL _pos;
	_unit setUnitPosWeak "UP";
	_unit disableAI "PATH";
	_unit disableAI "MINEDETECTION";

	sleep 1;
	_unit enableSimulationGlobal true;
};

_group
