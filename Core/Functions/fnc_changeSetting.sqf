/*
	Author: GuzzenVonLidl
	Changes values on all connections and JIP

	Usage:
	["GW_Common_Faction", "civilian"] call GW_Fnc_changeSetting;

	Arguments:
	0: Setting <STRING>
	1: Value <STRING, ARRAY, NUMBER>

	Return Value:
	true

	Public: Yes

*/
#include "script_Component.hpp"

params ["_setting","_value"];

[_setting, _value, 2, "server"] call CBA_settings_fnc_set;

true
