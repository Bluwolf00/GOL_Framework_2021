//	[] execVM "Scripts\OKS_Ambience\Init.sqf";
//
//	This initializes all the functions for OKS Ambience.
//
//	Made by Oksman
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script


// Functions
GW_Ambient_AAA = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\GW_Ambient_AAA.sqf";
OKS_Ambient_Settings = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\Settings.sqf";
OKS_ArtyFire = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_ArtyFire.sqf";
OKS_ScudLaunch = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_ScudLaunch.sqf";
OKS_TroopDismount = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_TroopDismount.sqf";
OKS_Enemy_Radio = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Radio.sqf";
OKS_Faceswap = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_FaceSwap.sqf";
