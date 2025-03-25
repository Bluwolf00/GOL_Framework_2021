//	execVM "Scripts\OKS_Spawn\OKS_Radar\Init.sqf";
//
//	This initializes all the functions for OKS Radar.
//
//	Made by Oksman
// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
GW_Ambient_AAA = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Radar\GW_Ambient_AAA.sqf";
OKS_Radar = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Radar\OKS_Radar.sqf";
OKS_SAM = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Radar\OKS_SAM.sqf";
