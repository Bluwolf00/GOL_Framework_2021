/*
	Precompile Paradrop Scripts and initiate functions

	Usage: [] execVM "Scripts\NEKY_Paradrop\Init.sqf";

*/
NEKY_ACE_AddAction = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_ACE_AddAction.sqf";
NEKY_AddAction = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
NEKY_MapClose = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_MapClose.sqf";
NEKY_MoveTrigger = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_MoveTrigger.sqf";
NEKY_OnMapClick = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_OnMapClick.sqf";
NEKY_Paradrop = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_Paradrop.sqf";
NEKY_Settings = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\NEKY_Settings.sqf";




