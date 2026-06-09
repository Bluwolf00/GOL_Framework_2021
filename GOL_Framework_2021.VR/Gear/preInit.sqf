#include "script_Component.hpp"

// GW_Gear addon is a hard requirement for this framework version.
if !(isClass (configFile >> "CfgPatches" >> "GW_Gear")) exitWith {
	diag_log "[GW_Gear] ERROR: GW_Gear addon is not loaded. This mission requires the GW addon — gear will not function.";
};

private _useLocalDefault   = missionNamespace getVariable ["GW_Gear_UseLocalDefault",   false];
private _useLocalDefaultAI = missionNamespace getVariable ["GW_Gear_UseLocalDefaultAI", false];
private _useLocalHandler   = missionNamespace getVariable ["GW_Gear_UseLocalHandler",   false];

diag_log format ["[GW_Gear][preInit] source flags localDefault=%1 localDefaultAI=%2 localHandler=%3", _useLocalDefault, _useLocalDefaultAI, _useLocalHandler];

GW_Gear_fnc_DefaultCode = compile preProcessFileLineNumbers (
	if (_useLocalDefault) then {
		diag_log "[GW_Gear][preInit] compiling DefaultCode from Gear\\Functions\\fnc_DefaultCode_Local.sqf";
		"Gear\Functions\fnc_DefaultCode_Local.sqf"
	} else {
		diag_log "[GW_Gear][preInit] compiling DefaultCode from \x\gw\addons\gear\functions\fnc_DefaultCode.sqf";
		"\x\gw\addons\gear\functions\fnc_DefaultCode.sqf"
	}
);
GW_Gear_fnc_DefaultAICode = compile preProcessFileLineNumbers (
	if (_useLocalDefaultAI) then {
		diag_log "[GW_Gear][preInit] compiling DefaultAICode from Gear\\Functions\\fnc_DefaultAICode_Local.sqf";
		"Gear\Functions\fnc_DefaultAICode_Local.sqf"
	} else {
		diag_log "[GW_Gear][preInit] compiling DefaultAICode from \x\gw\addons\gear\functions\fnc_DefaultAICode.sqf";
		"\x\gw\addons\gear\functions\fnc_DefaultAICode.sqf"
	}
);

if (_useLocalHandler) then {
	diag_log "[GW_Gear][preInit] compiling Handler from Gear\\Functions\\fnc_Handler.sqf";
	GW_Gear_fnc_Handler = compile preProcessFileLineNumbers "Gear\Functions\fnc_Handler.sqf";
};
// All other functions (Init, getLoadoutClass, Handler, etc.) are auto-registered
// by the addon's XEH_PREP.sqf — no PREP calls needed here.

// All settings (faction lists, behaviour, stamina) are registered by the
// GW_Gear addon initSettings.sqf — no CBA settings calls needed here.

