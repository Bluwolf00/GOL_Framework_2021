//	[] execVM "Scripts\OKS_Ambience\Init.sqf";
//
//	This initializes all the functions for OKS Ambience.
//
//	Made by Oksman

OKS_Chat = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Chat.sqf"; // Used by Clients only
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
GW_Ambient_AAA = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\GW_Ambient_AAA.sqf";
OKS_Ambient_Settings = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\Settings.sqf";
OKS_ArtyFire = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_ArtyFire.sqf";
OKS_ScudLaunch = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_ScudLaunch.sqf";
//OKS_TroopDismount = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_TroopDismount.sqf";
if(GOL_OKS_Enemy_Talk isEqualTo 1) then {
	OKS_Enemy_Talk = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Talk.sqf";
};
OKS_Enemy_Radio = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Radio.sqf";
OKS_Faceswap = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_FaceSwap.sqf";
OKS_Convoy_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Convoy_Spawn.sqf";
OKS_AA_Guard = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_AA_Guard.sqf";
OKS_Dynamic_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\Settings.sqf";
OKS_Rush_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Rush_SpawnGroup.sqf";
OKS_Hunt_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Hunt_SpawnGroup.sqf";
OKS_Nearby_Units_Hunt = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Nearby_Units_Hunt.sqf";
OKS_AddVehicleCrew = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_AddVehicleCrew.sqf";
OKS_Surrender = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Surrender.sqf";
OKS_HVT_MoraleHit_Intel = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_HVT_MoraleHit_Intel.sqf";
//TFAR_Scrambler = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\TFAR_Scrambler.sqf";
//GW_DoParadrop = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\GW_DoParadrop.sqf";
//OKS_VehicleParadrop = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_VehicleParadrop.sqf";

