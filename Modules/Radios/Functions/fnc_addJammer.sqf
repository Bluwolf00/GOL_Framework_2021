/*
	Author: GuzzenVonLidl

	Usage:
	[this, 500, 50] spawn GW_Radios_fnc_addJammer;

	Arguments:
	0: Object <OBJECT>
	1: Jammer Max Distance <NUMBER>
	2: Distance for Full Interference <NUMBER>

	Return Value: OBJECT

	Public: NO
*/
#include "script_Component.hpp"

if !(isServer) exitWith {false};

params ["_object","_distance","_fullInterference"];

if (_fullInterference > _distance) exitWith {false};

GVAR(allJamers) pushBackUnique _object;
publicVariable QGVAR(allJamers);

_object setVariable [QGVAR(jammer), [_distance, _fullInterference], true];

_object addEventHandler ["Killed", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	GVAR(allJamers) deleteAt (GVAR(allJamers) find _unit);
	publicVariable QGVAR(allJamers);
}];


_object
