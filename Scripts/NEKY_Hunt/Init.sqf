//	[] execVM "Scripts\NEKY_Hunt\Init.sqf";
//
//	This initializes all the functions for NEKY_Hunt.
//
//	Made by NeKo-ArroW

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
NEKY_Hunt_Settings = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Settings.sqf";
NEKY_Hunt_Run = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Run.sqf";
NEKY_Hunt_ScanZone = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Functions\ScanZone.sqf";
NEKY_Hunt_SelectPlayer = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Functions\SelectPlayer.sqf";
NEKY_Hunt_Spawn = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Functions\Spawn.sqf";
NEKY_Hunt_SetSkill = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Functions\SetSkill.sqf";
NEKY_Hunt_Hunting = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\Functions\Hunting.sqf";
NEKY_Hunt_HuntBase = compile preprocessFileLineNumbers "Scripts\NEKY_Hunt\HuntBase.sqf";

