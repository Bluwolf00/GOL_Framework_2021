/*
	Author: GuzzenVonLidl
	Gets the deploy type for the mhq

	Usage:
	[mhq_1] call GW_MHQ_Fnc_getFlag;

	Arguments:
	0: Unit <OBJECT>
	1: Type <STRING>

	Return Value: <OBJECT>

	Public: No
*/
#include "script_Component.hpp"

private ["_return"];
params ["_mhq"];

switch (_mhq getVariable [QGVAR(Side), "west"]) do {
	case "west": {
		_return = flag_west_1;
	};
	case "east": {
		_return = flag_east_1;
	};
	case "independent": {
		_return = flag_independent_1;
	};
};

_return
