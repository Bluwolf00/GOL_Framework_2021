//	execVM "Scripts\OKS_Spawn\OKS_Lambs\Init.sqf";
//
//	This initializes all the functions for OKS Lambs.
//
//	Made by Oksman
// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_Lambs_ChargeSpawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_ChargeSpawn.sqf";
OKS_Lambs_Spawner = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_Spawner.sqf";
OKS_Lambs_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_SpawnGroup.sqf";
OKS_Lambs_Wavespawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_Wavespawn.sqf";