//	[] execVM "Scripts\OKS_SAM\Init.sqf";
//
//	This initializes all the functions for OKS SAM.
//
//	Made by Oksman
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script


// Functions
OKS_SAM = compile preprocessFileLineNumbers "Scripts\OKS_SAM\OKS_SAM.sqf";

