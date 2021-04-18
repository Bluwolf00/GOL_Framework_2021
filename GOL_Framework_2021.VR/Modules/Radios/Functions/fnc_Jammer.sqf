/*
	Author: GuzzenVonLidl

	Usage:
	[this, 500, 50] spawn GW_Radios_fnc_Jammer;

	Arguments:
	0: Object <OBJECT>
	1: Jammer Max Distance <NUMBER>
	2: Jamming Interference Full Effect <NUMBER>

	Return Value: NO

	Public: NO
*/
#include "script_Component.hpp"

params ["_object","_distance","_interference"];

if !(hasInterface) exitWith {false};
if !(canSuspend) exitWith {
	_this spawn FUNC(Jammer);
};

private _radius = (_distance / 2);
private _unit = player;

while {alive _object} do {
	if (_unit inArea [(getPos _object), _radius, _radius, 0, false, _radius]) then {
		_reldir = (_object getRelDir _unit);
		_relpos = (_object getRelPos [_interference, _reldir]);
		_currentDistance = (_unit distance _relpos);
		_lerpDistance = (_currentDistance/_radius);
		_radioLossReceiving = [100, (_unit getVariable QGVAR(receiving)), _lerpDistance] call BIS_fnc_lerp;
		if ((_unit distance _object) < _interference) then {
			[QGVAR(setRadioLoss), [_unit, 100]] call CBA_fnc_localEvent;
		} else {
			if (_currentDistance > _radius) then {	// Reset if teleported
				[QGVAR(setRadioLoss), [_unit, (_unit getVariable QGVAR(receiving))]] call CBA_fnc_localEvent;
			} else {
				[QGVAR(setRadioLoss), [_unit, round(_radioLossReceiving)]] call CBA_fnc_localEvent;
			};
		};
	};
	sleep 1;
};

// Reset on destroyed
[QGVAR(setRadioLoss), [_unit, (_unit getVariable QGVAR(receiving))]] call CBA_fnc_localEvent;
