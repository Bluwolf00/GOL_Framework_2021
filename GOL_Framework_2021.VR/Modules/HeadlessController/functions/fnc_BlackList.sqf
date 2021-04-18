/*
	Author: GuzzenVonLidl
	Adds or removes a unit or group HC transfer blacklist
	The blacklist itself means the unit or group will not be transfered to a headless client

	Usage:
	[] call GW_HeadlessController_Fnc_BlackList

	Arguments:
	0: _unit <OBJECT> or <GROUP>
	1: _toggle <BOOL>

	Return Value: YES <BOOl>
	True if unit was added to blacklist else false

	Public: NO
*/
#include "script_Component.hpp"

private ["_group"];
params ["_unit",["_toggle", true]];
_group = _unit call CBA_fnc_getGroup;

_group setVariable [QGVAR(BlackList), _toggle, true];

_toggle
