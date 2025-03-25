//	[] execVM "Scripts\OKS_Spawn\OKS_Arty\Init.sqf";
//
//	This initializes all the functions for OKS Arty.
//
//	Made by Oksman

// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Modules
execVM "Scripts\OKS_Spawn\OKS_IR\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Infantry_Pincer\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Radar\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Lambs\Init.sqf";

OKS_ArtyFire = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Arty\OKS_ArtyFire.sqf";
OKS_ArtySupression = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Arty\OKS_ArtySupression.sqf";