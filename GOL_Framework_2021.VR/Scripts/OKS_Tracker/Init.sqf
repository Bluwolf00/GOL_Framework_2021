//	[] execVM "Scripts\OKS_Tracker\Init.sqf";
//
//	This initializes all the functions for OKS Tracker.
//
//	Made by Oksman

OKS_HuntedGroups = [];

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_Hunted = compile preprocessFileLineNumbers "Scripts\OKS_Tracker\OKS_Hunted.sqf";
OKS_Tracker = compile preprocessFileLineNumbers "Scripts\OKS_Tracker\OKS_Tracker.sqf";



