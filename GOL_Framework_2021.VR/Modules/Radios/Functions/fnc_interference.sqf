/*
	Author: GuzzenVonLidl

	Usage:
	[this] spawn GW_Radios_fnc_interference;

	Arguments:
	0: Object <OBJECT>

	Return Value: NO

	Public: NO
*/
#include "script_Component.hpp"

params ["_unit"];

if !(hasInterface) exitWith {false};
if !(canSuspend) exitWith {
	_this spawn FUNC(interference);
};

while {alive _unit} do {
	if !((count GVAR(allJamers)) isEqualTo 0) then {
		_arr1 = (GVAR(allJamers) apply {_x distance player});
		_arr2 = (GVAR(allJamers) apply {_x distance player});
		_arr1 sort true;
		_object = (GVAR(allJamers) select (_arr2 find (_arr1 select 0)));

		(_object getVariable [QGVAR(jammer), [50,100]]) params ["_distance","_fullInterference"];
		private _radius = (_distance / 2);
		if (_unit inArea [(getPos _object), (_distance + 50), (_distance + 50), 0, false, _radius]) then {
			_reldir = (_object getRelDir _unit);
			_relpos = (_object getRelPos [_fullInterference, _reldir]);
		//	_currentDistance = (_unit distance _relpos);
			_currentDistance = (_unit distance _object);
			_currentInterference = (linearConversion [(_radius + _fullInterference), (_distance + _fullInterference), _currentDistance, 50, 1, false]);

			if ((_unit distance _object) <= _fullInterference) then {
				[QGVAR(setRadioLoss), [_unit, 100]] call CBA_fnc_localEvent;
			} else {
				[QGVAR(setRadioLoss), [_unit, round(_currentInterference)]] call CBA_fnc_localEvent;
			};
		} else {
			[QGVAR(setRadioLoss), [_unit, 1]] call CBA_fnc_localEvent;
		};
	};
	sleep 1;
};

// Reset on destroyed
[QGVAR(setRadioLoss), [_unit, (_unit getVariable QGVAR(receiving))]] call CBA_fnc_localEvent;
