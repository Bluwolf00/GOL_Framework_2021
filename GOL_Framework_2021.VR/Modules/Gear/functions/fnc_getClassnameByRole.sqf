/*
	Author: GuzzenVonLidl
	Returns the appropriate unit classname for a given role and side.
	This is the reverse function of fnc_getLoadoutClass.

	Usage:
	["r", west] call GW_Gear_Fnc_getClassnameByRole;
	["sl", east] call GW_Gear_Fnc_getClassnameByRole;

	Arguments:
	0: Role <STRING> - The role identifier (e.g., "r", "sl", "ftl", "ar")
	1: Side <SIDE> - The side (west, east, independent, civilian)

	Return Value: Classname <STRING>

	Public: NO
*/
#include "script_Component.hpp"

params [
	["_role", "r", [""]],
	["_side", west, [west]]
];

private _classname = "";
private _sidePrefix = "";

// Determine side prefix
switch (_side) do {
	case west: { _sidePrefix = "B_"; };
	case east: { _sidePrefix = "O_"; };
	case independent: { _sidePrefix = "I_"; };
	case civilian: { _sidePrefix = "C_"; };
	default { _sidePrefix = "B_"; };
};

// Role to classname mapping
// Based on vanilla Arma 3 units
switch (toLower _role) do {
	case "officer": {
		_classname = _sidePrefix + "officer_F";
	};
	case "pl": {
		// Platoon Leader - use officer or squad leader
		_classname = _sidePrefix + "officer_F";
	};
	case "sl": {
		// Squad Leader
		_classname = _sidePrefix + "Soldier_SL_F";
	};
	case "fac": {
		// JTAC / Forward Air Controller
		_classname = _sidePrefix + "soldier_UAV_F";
	};
	case "ftl": {
		// Fire Team Leader
		_classname = _sidePrefix + "Soldier_TL_F";
	};
	case "ab": {
		// Ammo Bearer / Engineer
		_classname = _sidePrefix + "soldier_exp_F";
	};
	case "mat": {
		// AT Specialist
		_classname = _sidePrefix + "soldier_AT_F";
	};
	case "g": {
		// Grenadier
		_classname = _sidePrefix + "Soldier_GL_F";
	};
	case "ag": {
		// Assistant / Medic / Combat Life Saver
		_classname = _sidePrefix + "medic_F";
	};
	case "ar": {
		// Autorifleman
		_classname = _sidePrefix + "soldier_AR_F";
	};
	case "mmg": {
		// Machine Gunner
		_classname = _sidePrefix + "HeavyGunner_F";
	};
	case "crew": {
		// Crewman
		_classname = _sidePrefix + "crew_F";
	};
	case "p": {
		// Pilot
		_classname = _sidePrefix + "Helipilot_F";
	};
	case "marksman": {
		// Marksman / Sniper
		_classname = _sidePrefix + "soldier_M_F";
	};
	case "lr": {
		// Long Range / Marksman / Spotter
		_classname = _sidePrefix + "soldier_M_F";
	};
	case "aa": {
		// Anti-Air Specialist
		_classname = _sidePrefix + "soldier_AA_F";
	};
	case "r";
	default {
		// Rifleman (default)
		_classname = _sidePrefix + "Soldier_F";
	};
};

_classname