/*
	Author: GuzzenVonLidl
	Gets the appropriate difficulty setting for a unit based on its side
	Supports per-side difficulty configuration with fallback to global setting

	Usage:
	[_unit] call GW_SetDifficulty_fnc_getDifficultyForSide;
	[west] call GW_SetDifficulty_fnc_getDifficultyForSide;

	Arguments:
	0: Unit <OBJECT> or Side <SIDE>

	Return Value:
	Difficulty index <NUMBER>

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unitOrSide", objNull, [objNull, sideUnknown]]
];

private _side = _unitOrSide;
if (_unitOrSide isEqualType objNull) then {
	_side = side _unitOrSide;
};

private _difficulty = GVAR(unitTraining); // Default to global setting

// Get side-specific setting
private _sideDifficulty = switch (_side) do {
	case west: { GVAR(unitTraining_WEST) };
	case east: { GVAR(unitTraining_EAST) };
	case independent: { GVAR(unitTraining_INDEPENDENT) };
	case civilian: { GVAR(unitTraining_CIVILIAN) };
	default { -1 };
};

// If side-specific setting is not -1 (Use Global), use it instead
if (_sideDifficulty != -1) then {
	_difficulty = _sideDifficulty;
};

_difficulty
