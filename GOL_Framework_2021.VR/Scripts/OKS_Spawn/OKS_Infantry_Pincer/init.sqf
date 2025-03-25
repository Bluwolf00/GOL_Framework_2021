//  execVM "Scripts\OKS_Spawn\OKS_Infantry_Pincer\Init.sqf";
//
//	This initializes all the functions for OKS Spawn.
//
//	Made by Oksman

// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_FlankingMovement = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Infantry_Pincer\OKS_FlankingMovement.sqf";
OKS_SpawnInfantrySquad = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Infantry_Pincer\OKS_SpawnInfantrySquad.sqf";
OKS_SuppressiveFireMovement = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Infantry_Pincer\OKS_SuppressiveFireMovement.sqf";
OKS_SpawnInfantryPincer = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Infantry_Pincer\OKS_SpawnInfantryPincer.sqf";
