/*
	Author: GuzzenVonLidl
	Sets the difficulty read from mission configs

	Usage:
	[this, 2] call GW_SetDifficulty_fnc_setSkill;

	Arguments:
	0: Unit <OBJECT>
	1: BehaviorTree <NUMBER>	(OPTIONAL)

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]]
];

if (_unit getVariable [QGVAR(blackList), false]) exitWith {false};

if (isPlayer _unit) exitWith {
//	_this call FUNC(setDetectionCoef);
	false
};

[_unit] call FUNC(setSkill);

true
