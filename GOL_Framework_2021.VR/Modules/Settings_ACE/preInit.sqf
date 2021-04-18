#include "script_Component.hpp"

if (!GVARMAIN(mod_ACE3)) exitWith {false};

[
	QGVAR(medical_level), "LIST",
	["Medical Level", "Configures ACE Medical with GOL settings"],
	QUOTE(ADDON),
	[
		[
			1,
			2
		],
		[
			"Basic",
			"Advanced"
		],
		0
	], CBA_SERVEROVERWRITE, {
		if (time > 1) then {
			[{[QGVAR(setMedical), GVAR(medical_level)] call CBA_fnc_localEvent;}, [], 0.1] call CBA_fnc_waitAndExecute;
		};
	}
] call FUNCMAIN(settingsInit);

[
	QGVAR(revive), "LIST",
	["Enable Revive", "Configures ACE Revive with GOL settings"],
	QUOTE(ADDON),
	[
		[
			0,
			1,
			2
		],
		[
			"Disabled",
			"Enabled",
			"Enabled (One Life)"
		],
		0
	], CBA_SERVEROVERWRITE, {
		if (time > 1) then {
			[{[QGVAR(setRevive), GVAR(revive)] call CBA_fnc_localEvent;}, [], 0.1] call CBA_fnc_waitAndExecute;
		};
	}
] call FUNCMAIN(settingsInit);

[QGVAR(setMedical), {
	params ["_type"];
	if (_type isEqualTo 1) then {
		["ACE_Medical_level", 1] call GW_Fnc_changeSetting;
		["ACE_Medical_medicSetting", 1] call GW_Fnc_changeSetting;
		["ACE_Medical_enableOverdosing", true] call GW_Fnc_changeSetting;
		["ACE_Medical_bleedingCoefficient", 1] call GW_Fnc_changeSetting;
		["ACE_Medical_painCoefficient", 1] call GW_Fnc_changeSetting;
		["ACE_Medical_playerDamageThreshold", 1.2] call GW_Fnc_changeSetting;
		["ACE_Medical_AIDamageThreshold", 1] call GW_Fnc_changeSetting;
		["ace_medical_treatment_advancedDiagnose", 0] call GW_Fnc_changeSetting;
		["ace_medical_gui_enableActions", 0] call GW_Fnc_changeSetting;
	//	ACE_Medical_allowDeadBodyMovement = false;		// Does nothing
	} else {
		["ACE_Medical_level", 2] call GW_Fnc_changeSetting;
		["ACE_Medical_medicSetting", 2] call GW_Fnc_changeSetting;
		["ACE_Medical_enableOverdosing", true] call GW_Fnc_changeSetting;
		["ACE_Medical_bleedingCoefficient", 0.5] call GW_Fnc_changeSetting;
		["ACE_Medical_painCoefficient", 2] call GW_Fnc_changeSetting;
		["ACE_Medical_playerDamageThreshold", 1.5] call GW_Fnc_changeSetting;
		["ACE_Medical_AIDamageThreshold", 1] call GW_Fnc_changeSetting;
		["ACE_Medical_enableUnconsciousnessAI", 0] call GW_Fnc_changeSetting;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(setRevive), {
	switch (GVAR(revive)) do {
		case 1: {
			["ace_medical_enableRevive", 1] call GW_Fnc_changeSetting;
			["ace_medical_amountOfReviveLives", -1] call GW_Fnc_changeSetting;
		};
		case 2: {
			["ace_medical_enableRevive", 1] call GW_Fnc_changeSetting;
			["ace_medical_amountOfReviveLives", 1] call GW_Fnc_changeSetting;
		};
		default {
			["ace_medical_enableRevive", 0] call GW_Fnc_changeSetting;
			["ace_medical_amountOfReviveLives", -1] call GW_Fnc_changeSetting;
		};
	};
}] call CBA_fnc_addEventHandler;

["CBA_settingsInitializedDelayed", {
	ACE_MaxWeightDrag = 100000;
	ACE_MaxWeightCarry = 10000;
//	ACE_Hearing_enableCombatDeafness = false;
	[QGVAR(setMedical), GVAR(medical_level)] call CBA_fnc_localEvent;
	[QGVAR(setRevive), GVAR(revive)] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;
