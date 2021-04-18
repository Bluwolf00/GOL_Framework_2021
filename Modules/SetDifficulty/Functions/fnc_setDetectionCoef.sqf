/*
	Author: GuzzenVonLidl
	Sets player detection Coef

	Usage:
	[this, 2] call GW_SetDifficulty_fnc_setDetectionCoef;

	Arguments:
	0: Unit <OBJECT>

	Return Value: <BOOL>

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]]
];

_skill = (missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour" >> (GVAR(names) select GVAR(unitTraining)) >> "playerCamoCoef");

(getArray(_skill)) params ["_min","_mid","_max"];
private _value = _mid;

if (GVAR(randomSkill)) then {
	_value = (random [_min, _mid, _max]);
	_value = (parseNumber (_value toFixed 3));
};

if (isPlayer _unit) then {
	_unit setUnitTrait ["camouflageCoef", _value];
};
true
