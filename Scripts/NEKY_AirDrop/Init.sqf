//	[] execVM "Scripts\NEKY_AirDrop\Init.sqf";
//
//	This initializes all the functions for NEKY_Hunt.
//
//	Made by NeKo-ArroW

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
NEKY_Airbase = compile preprocessFileLineNumbers "Scripts\NEKY_AirDrop\NEKY_Airbase.sqf";
NEKY_AirDrop = compile preprocessFileLineNumbers "Scripts\NEKY_AirDrop\NEKY_AirDrop.sqf";
