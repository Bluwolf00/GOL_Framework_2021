//	[] execVM "Scripts\OKS_AAC\Init.sqf";
//
//	This initializes all the functions for OKS AAC.
//
//	Made by Oksman

// Functions
OKS_DAP_Config = compile preprocessFileLineNumbers "Scripts\OKS_AAC\OKS_DAP_Config.sqf";
OKS_Interact_Apply = compile preprocessFileLineNumbers "Scripts\OKS_AAC\OKS_Interact_Apply.sqf";
OKS_Interact_Copilot = compile preprocessFileLineNumbers "Scripts\OKS_AAC\OKS_Interact_Copilot.sqf";
OKS_Interact_DoorGunner = compile preprocessFileLineNumbers "Scripts\OKS_AAC\OKS_Interact_DoorGunner.sqf";
OKS_Interact_Pilot = compile preprocessFileLineNumbers "Scripts\OKS_AAC\OKS_Interact_Pilot.sqf";

sleep 5;

[] spawn OKS_DAP_Config;
