/* ----------------------------------------------------------------------------
[] call compile preprocessFileLineNumbers "core\XEH_preInit.sqf"

["client"] call CBA_settings_fnc_clear;
["server"] call CBA_settings_fnc_clear;
["mission"] call CBA_settings_fnc_clear;

["gw_gear_blufor", ("gw_gear_blufor" call CBA_settings_fnc_get), true, "mission"] call CBA_settings_fnc_set

	} forEach [
		"gw_environment_advlightning",
		"gw_environment_ppeffects",
		"gw_gear_blufor",
		"gw_gear_opfor",
		"gw_gear_indep",
		"gw_gear_auto_assign",
		"gw_performance_enabled",
		"gw_performance_unitenabled",
		"gw_performance_delay",
		"gw_respawn_respawns",
		"gw_respawn_jip",
		"gw_setdifficulty_difficulty",
		"gw_startup_timelimit"
	];
FUNCMAIN(settingsInit);

---------------------------------------------------------------------------- */
#include "script_Component.hpp"

params [
	["_settingName", "", [""]],
	["_settingType", "", [""]],
	["_title", [], ["", []]],
	["_category", "", [""]],
	["_valueInfo", []],
	["_isGlobal", false, [false,"",0]],
	["_script", {}, [{}]],
	["_addSetting", "", [""]]
];

if (_addSetting isEqualTo "") then {
	GVARMAIN(settings3denArray) pushBack _settingName;
};

[
	_settingName,
	_settingType,
	_title,
	_category,
	_valueInfo,
	_isGlobal,
	_script
] call cba_settings_fnc_init;

true
