/*
	Author: GuzzenVonLidl

	Usage:
	[] call GW_MiscSettings_fnc_customMenu_Example;

	Arguments: NO

	Return Value: NO

	Public: NO
*/
#include "script_component.hpp"

_params = _this select 1;

_menuName = "";
_menuRsc = "popup";

if (typeName _params isEqualTo typeName []) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = _params select 0;
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

private _menuDef = [];
private _menus = [
	[
		["exampleMenu", "Settings Menu", _menuRsc],
		[
			[
				"List >",
				"","","",
				[QUOTE(call FUNC(customMenu_Example)),"example", 1],
				-1,true,
				true
			],
			["Kill yourself", { player setDamage 1; } ]
		]
	]
];

if (_menuName isEqualTo "example") then {
	_menus pushBack [
		["example","Action Examples", _menuRsc],
		[

			[
				"Say Hello",
				{hint "Hello"},
				"","","",-1,true,
				(alive player)
			],
			["1 + 1", { Hint "1 + 1 = 3"; } ]
		]
	];
};

{
	if (((_x select 0) select 0) isEqualTo _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if ((count _menuDef) isEqualTo 0) then {
	hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName isEqualTo "") then {_this}else{""},__FILE__];
	diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};

_menuDef
