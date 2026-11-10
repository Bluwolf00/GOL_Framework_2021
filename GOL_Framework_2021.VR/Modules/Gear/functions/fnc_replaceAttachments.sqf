#include "script_Component.hpp"

#define	OPENMENU(Var1) Format ["['player', [], -100, ['_this call GW_Gear_Fnc_replaceAttachments', 'main']] call cba_fnc_fleximenu_openMenuByDef;", Var1]
#define	FIRSTPAGE(Var1,Var2) compile ((Format ["%1 = 0;", Var1]) + (OPENMENU(Var2)))
#define	NEXTPAGE(Var1,Var2) compile ((Format ["%1 = %1 + 1;", Var1]) + (OPENMENU(Var2)))

#define	GETNAME(Var1)	format ["%1",getText(configfile >> "CfgWeapons" >> Var1 >> "displayName")]
#define	GETPICTURE(Var1)	format ["%1",getText(configfile >> "CfgWeapons" >> Var1 >> "picture")]
#define	SETITEM(Var1,Var2)	compile ((Format ["switch (currentWeapon player) do {case (primaryWeapon player): {player addPrimaryWeaponItem '%1';};case (handgunWeapon player): {player addHandgunItem '%1';};case (secondaryWeapon player): {player addSecondaryWeaponItem '%1';};};", Var1]) + (OPENMENU(Var2)))

private _params = (_this select 1);
private _menuName = "";
private _menuRsc = "popup";
private _maxValue = 10;
private _suboptions_101 = [];
private _suboptions_201 = [];
private _suboptions_301 = [];
private _suboptions_302 = [];
private _allAttatchments = ([currentWeapon player] call GW_Gear_Fnc_getAttachments);

if ((typeName _params) isEqualTo (typeName [])) then {
	if (count _params < 1) exitWith {diag_log format["Error: Invalid params: %1, %2", _this, __FILE__];};
	_menuName = (_params select 0);
	_menuRsc = if (count _params > 1) then {_params select 1} else {_menuRsc};
} else {
	_menuName = _params;
};

_menus =
[
	[
		["main", "Attachment Menu", _menuRsc],
		[
			[
				"Replace Muzzle >",
				"","","",
				["_this call GW_Gear_Fnc_replaceAttachments","101", 1],
				-1,true,
				GVAR(Enabled_101)
			],
			[
				"Replace Optic >",
				"","","",
				["_this call GW_Gear_Fnc_replaceAttachments","201", 1],
				-1,true,
				GVAR(Enabled_201)
			],
			[
				"Replace Pointer >",
				"","","",
				["_this call GW_Gear_Fnc_replaceAttachments","301", 1],
				-1,true,
				GVAR(Enabled_301)
			],
			[
				"Replace Bipod >",
				"","","",
				["_this call GW_Gear_Fnc_replaceAttachments","302", 1],
				-1,true,
				GVAR(Enabled_302)
			],
			["Reset Menus", {GVAR(Index101) = 0; GVAR(Index201) = 0; GVAR(Index301) = 0; GVAR(Index302) = 0;}]
		]
	]
];

// -------------------------------- Player Actions ----------------------------------- \\

if (_menuName isEqualTo "101") then {
	private _attachments = (_allAttatchments select 0);
	private _loadPage = "101";
	private _From = (0 + (_maxValue * GVAR(Index101)));
	private _To = (_maxValue + (_maxValue * GVAR(Index101)));
	if ((count _attachments) > _maxValue) then {
		for "_i" from _From to _To step 1 do {
			if ((_i isEqualTo _To) && (_i < (count _attachments))) then {
					_suboptions_101 pushBack ["Next >", NEXTPAGE(QGVAR(Index101),'main'),"","",""];
			} else {
				if (_i isEqualTo (Count _attachments)) then {
					_suboptions_101 pushBack ["First Page >", FIRSTPAGE(QGVAR(Index101),'main'),"","",""];
				} else {
					if (!(_i isEqualTo _To) && (_i < (Count _attachments))) then {
						_index = (_attachments select _i);
						_suboptions_101 pushBack [GETNAME(_attachments select _i), SETITEM((_attachments select _i),_loadPage), GETPICTURE(_attachments select _i)];
					};
				};
			};
		};
	} else {
		{
			_suboptions_101 pushBack [GETNAME(_x),SETITEM(_x,_loadPage),GETPICTURE(_x),"",""];
		} forEach _attachments;
	};
	_menus pushBack [[_loadPage, "Muzzle List", _menuRsc],_suboptions_101];
};

if (_menuName isEqualTo "201") then {
	private _attachments = (_allAttatchments select 1);
	private _loadPage = "201";
	private _From = (0 + (_maxValue * GVAR(Index201)));
	private _To = (_maxValue + (_maxValue * GVAR(Index201)));
	if ((count _attachments) > _maxValue) then {
		for "_i" from _From to _To step 1 do {
			if ((_i isEqualTo _To) && (_i < (count _attachments))) then {
					_suboptions_201 pushBack ["Next >", NEXTPAGE(QGVAR(Index201),'main'),"","",""];
			} else {
				if (_i isEqualTo (Count _attachments)) then {
					_suboptions_201 pushBack ["First Page >", FIRSTPAGE(QGVAR(Index201),'main'),"","",""];
				} else {
					if (!(_i isEqualTo _To) && (_i < (Count _attachments))) then {
						_index = (_attachments select _i);
						_suboptions_201 pushBack [GETNAME(_attachments select _i), SETITEM((_attachments select _i),_loadPage), GETPICTURE(_attachments select _i)];
					};
				};
			};
		};
	} else {
		{
			_suboptions_201 pushBack [GETNAME(_x),SETITEM(_x,_loadPage),GETPICTURE(_x),"",""];
		} forEach _attachments;
	};
	_menus pushBack [[_loadPage, "Optics List", _menuRsc],_suboptions_201];
};

if (_menuName isEqualTo "301") then {
	private _attachments = (_allAttatchments select 2);
	private _loadPage = "301";
	private _From = (0 + (_maxValue * GVAR(Index301)));
	private _To = (_maxValue + (_maxValue * GVAR(Index301)));
	if ((count _attachments) > _maxValue) then {
		for "_i" from _From to _To step 1 do {
			if ((_i isEqualTo _To) && (_i < (count _attachments))) then {
					_suboptions_301 pushBack ["Next >", NEXTPAGE(QGVAR(Index301),'main'),"","",""];
			} else {
				if (_i isEqualTo (Count _attachments)) then {
					_suboptions_301 pushBack ["First Page >", FIRSTPAGE(QGVAR(Index301),'main'),"","",""];
				} else {
					if (!(_i isEqualTo _To) && (_i < (Count _attachments))) then {
						_index = (_attachments select _i);
						_suboptions_301 pushBack [GETNAME(_attachments select _i), SETITEM((_attachments select _i),_loadPage), GETPICTURE(_attachments select _i)];
					};
				};
			};
		};
	} else {
		{
			_suboptions_301 pushBack [GETNAME(_x),SETITEM(_x,_loadPage),GETPICTURE(_x),"",""];
		} forEach _attachments;
	};
	_menus pushBack [[_loadPage, "Pointer List", _menuRsc],_suboptions_301];
};

if (_menuName isEqualTo "302") then {
	private _attachments = (_allAttatchments select 3);
	private _loadPage = "302";
	private _From = (0 + (_maxValue * GVAR(Index302)));
	private _To = (_maxValue + (_maxValue * GVAR(Index302)));
	if ((count _attachments) > _maxValue) then {
		for "_i" from _From to _To step 1 do {
			if ((_i isEqualTo _To) && (_i < (count _attachments))) then {
					_suboptions_302 pushBack ["Next >", NEXTPAGE(QGVAR(Index302),'main'),"","",""];
			} else {
				if (_i isEqualTo (Count _attachments)) then {
					_suboptions_302 pushBack ["First Page >", FIRSTPAGE(QGVAR(Index302),'main'),"","",""];
				} else {
					if (!(_i isEqualTo _To) && (_i < (Count _attachments))) then {
						_index = (_attachments select _i);
						_suboptions_302 pushBack [GETNAME(_attachments select _i), SETITEM((_attachments select _i),_loadPage), GETPICTURE(_attachments select _i)];
					};
				};
			};
		};
	} else {
		{
			_suboptions_302 pushBack [GETNAME(_x),SETITEM(_x,_loadPage),GETPICTURE(_x),"",""];
		} forEach _attachments;
	};
	_menus pushBack [[_loadPage, "Bipod List", _menuRsc],_suboptions_302];
};

_menuDef = [];
{
  if (_x select 0 select 0 isEqualTo _menuName) exitWith {_menuDef = _x};
} forEach _menus;

if (count _menuDef isEqualTo 0) then {
  hintC format ["Error: Menu not found: %1\n%2\n%3", str _menuName, if (_menuName isEqualTo "") then {_this}else{""},__FILE__];
  diag_log format ["Error: Menu not found: %1, %2, %3", str _menuName, _this, __FILE__];
};
_menuDef
