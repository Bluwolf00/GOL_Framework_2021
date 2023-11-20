//	[] execVM "Scripts\OKS_Support\Init.sqf";
//
//	This initializes all the functions for OKS Dynamic Spawns.
//
//	Made by Oksman

// Functions
OKS_Support_Settings = compile preprocessFileLineNumbers "Scripts\OKS_Support\Settings.sqf";
OKS_Support_SpawnModule = compile preprocessFileLineNumbers "Scripts\OKS_Support\SpawnModule.sqf";
OKS_ACE_Support_Action = compile preprocessFileLineNumbers "Scripts\OKS_Support\Action.sqf";
[] Spawn OKS_ACE_Support_Action;


