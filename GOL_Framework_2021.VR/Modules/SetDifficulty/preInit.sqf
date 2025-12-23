
/*
	https://community.bistudio.com/wiki/setSkill_array

	Novice < 0.25
	Rookie >= 0.25 and <= 0.45
	Recruit > 0.45 and <= 0.65
	Veteran > 0.65 and <= 0.85
	Expert > 0.85
*/
#include "script_Component.hpp"

if (isClass(missionConfigFile >> "GW_Modules" >> "SetDifficulty_Legacy")) exitWith {
	["SetDifficulty detected a module duplicate, either disable the this module or its legacy","WARNING: SetDifficulty Duplicate"] spawn BIS_fnc_3DENShowMessage;
	false
};

PREP(init);
PREP(setDetectionCoef);
PREP(setSkill);
PREP(getDifficultyForSide);

GVAR(detectionCoef) = 1.0;
GVAR(unitTrainingBackup) = GVAR(unitTraining);

#define	BEHAVIOURS	(missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour")

GVAR(index) = [];
GVAR(names) = [];
for "_i" from 0 to ((count BEHAVIOURS) - 1) step 1 do {
	GVAR(index) pushBack _i;
	GVAR(names) pushBack (configName (BEHAVIOURS select _i));
};

// Global difficulty (backwards compatibility)
[
	QGVAR(unitTraining), "LIST",
	["Set Unit Training (Global)", "Sets the difficulty of newly spawned units (all sides). Used when side-specific settings are not configured."],
	QUOTE(ADDON), [GVAR(index), GVAR(names), 3],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

// Per-side difficulty settings
[
	QGVAR(unitTraining_WEST), "LIST",
	["Set Unit Training (BLUFOR)", "Sets the difficulty for BLUFOR units. Set to -1 to use global setting."],
	QUOTE(ADDON), [[-1] + GVAR(index), ["Use Global"] + GVAR(names), 0],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(unitTraining_EAST), "LIST",
	["Set Unit Training (OPFOR)", "Sets the difficulty for OPFOR units. Set to -1 to use global setting."],
	QUOTE(ADDON), [[-1] + GVAR(index), ["Use Global"] + GVAR(names), 0],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(unitTraining_INDEPENDENT), "LIST",
	["Set Unit Training (Independent)", "Sets the difficulty for Independent units. Set to -1 to use global setting."],
	QUOTE(ADDON), [[-1] + GVAR(index), ["Use Global"] + GVAR(names), 0],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(unitTraining_CIVILIAN), "LIST",
	["Set Unit Training (Civilian)", "Sets the difficulty for Civilian units. Set to -1 to use global setting."],
	QUOTE(ADDON), [[-1] + GVAR(index), ["Use Global"] + GVAR(names), 0],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

// Initialize backup variables for each side
GVAR(unitTraining_WEST_Backup) = GVAR(unitTraining_WEST);
GVAR(unitTraining_EAST_Backup) = GVAR(unitTraining_EAST);
GVAR(unitTraining_INDEPENDENT_Backup) = GVAR(unitTraining_INDEPENDENT);
GVAR(unitTraining_CIVILIAN_Backup) = GVAR(unitTraining_CIVILIAN);

[QGVAR(randomSkill), "CHECKBOX", ["Use Skill Variation", "Makes each unit have slightly diffrent skill levels within a defined %"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);

if (true) then {
	[QGVAR(damageResistance), "CHECKBOX", ["Damage Resistance in Vehicles", "Players recive less direct damage when in a light vehicle example: prowler, reverts back to normal on exit"], QUOTE(ADDON), false, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
};
