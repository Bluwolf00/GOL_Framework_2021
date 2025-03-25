//	[] execVM "Scripts\OKS_Spawn\OKS_Convoy\Init.sqf";
//
//	This initializes all the functions for OKS Convoy.
//
//	Made by Oksman

// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

OKS_Convoy_Reinforce = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy\OKS_Convoy_Reinforce.sqf";
OKS_Convoy_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy\OKS_Convoy_Spawn.sqf";