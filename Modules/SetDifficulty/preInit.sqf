
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

GVAR(detectionCoef) = 1.0;
GVAR(unitTrainingBackup) = GVAR(unitTraining);

#define	BEHAVIOURS	(missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour")

GVAR(index) = [];
GVAR(names) = [];
for "_i" from 0 to ((count BEHAVIOURS) - 1) step 1 do {
	GVAR(index) pushBack _i;
	GVAR(names) pushBack (configName (BEHAVIOURS select _i));
};

[
	QGVAR(unitTraining), "LIST",
	["set Unit Training", "Sets the difficulty of newly spawned units"],
	QUOTE(ADDON), [GVAR(index), GVAR(names), 3],
	CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[QGVAR(randomSkill), "CHECKBOX", ["Use Skill Variation", "Makes each unit have slightly diffrent skill levels within a defined %"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);

if (GVARMAIN(mod_ACE3)) then {
	[QGVAR(damageResistance), "CHECKBOX", ["Damage Resistance in Vehicles", "Players recive less direct damage when in a light vehicle example: prowler, reverts back to normal on exit"], QUOTE(ADDON), false, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
};
