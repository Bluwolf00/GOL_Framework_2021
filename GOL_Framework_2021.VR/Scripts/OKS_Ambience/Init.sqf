//	[] execVM "Scripts\OKS_Ambience\Init.sqf";
//
//	This initializes all the functions for OKS Ambience.
//
//	Made by Oksman

OKS_Chat = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Chat.sqf"; // Used by Clients only
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
if(GOL_OKS_Enemy_Talk isEqualTo 1) then {
	OKS_Enemy_Talk = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Talk.sqf";
};
OKS_Enemy_Radio = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Radio.sqf";
OKS_Enemy_Sentry = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Enemy_Sentry.sqf";
OKS_Faceswap = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_FaceSwap.sqf";
OKS_Dynamic_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\Settings.sqf";
OKS_Nearby_Units_Hunt = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Nearby_Units_Hunt.sqf";
OKS_Surrender = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Surrender.sqf";
OKS_HVT_MoraleHit_Intel = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_HVT_MoraleHit_Intel.sqf";
OKS_AlarmSound = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_AlarmSound.sqf";
OKS_PowerGenerator = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_PowerGenerator.sqf";
OKS_Destroy_Houses = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\OKS_Destroy_Houses.sqf";
JBOY_Speak = compile preprocessFileLineNumbers "Scripts\OKS_Ambience\Talk\JBOY_Speak.sqf";