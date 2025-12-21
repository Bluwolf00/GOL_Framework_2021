/*
	Author: GuzzenVonLidl
	From array spawns Units in a group, vehicles are spawned and ocupied by group and waypoints are added

	Usage:
	[] call GW_Common_fnc_spawnGroup;

	Arguments:
	#0:	ARRAY - A shit ton of multidimensional arrays

	Return Value: <GROUP>
	Group that spawned

	Public: NO
*/
#include "script_Component.hpp"

if (is3DEN) exitWith {
	_this call FUNC(spawn3DEN);
	false
};

params [
	["_unitArray", []],
	["_vehicleArray", []],
	["_waypointArray", []],
	["_side",GVAR(Faction),[sideUnknown]],
	["_skipQueue", false],
	["_skipDelays", false]
];
//systemChat str ["spawnGroup - pre", _side];
([str _side] call FUNC(getGroupType)) params ["_side"];

//systemChat str ["spawnGroup - post", _side];
_group = CreateGroup _side;
_group setVariable [QEGVAR(Performance,autoDelete), false];

[_unitArray,_vehicleArray,_waypointArray,_skipQueue,_skipDelays,_group,_side] spawn FUNC(spawnHandler);

_group
