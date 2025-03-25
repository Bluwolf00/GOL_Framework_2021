//	execVM "Scripts\OKS_Spawn\OKS_IR\Init.sqf";
//
//	This initializes all the functions for OKS IR.
//
//	Made by Oksman

// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_IR_AA = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_IR_AA.sqf";
OKS_Forced_Reload = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Forced_Reload.sqf";
OKS_Target_Finder = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Target_Finder.sqf";
OKS_Remove_InfantryWeapons = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Remove_InfantryWeapons.sqf";
OKS_Spawn_AntiAir_Soldier = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Spawn_AntiAir_Soldier.sqf";