//	[] execVM "Scripts\OKS_Stealth\Init.sqf";
//
//	This initializes all the functions for OKS Tracker.
//
//	Made by Oksman

OKS_HuntedGroups = [];

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_Hunted = compile preprocessFileLineNumbers "Scripts\OKS_Stealth\OKS_Hunted.sqf";
OKS_Tracker = compile preprocessFileLineNumbers "Scripts\OKS_Stealth\OKS_Tracker.sqf";
if(GOL_OKS_Enemy_Talk isEqualTo 1) then {
	OKS_Enemy_Talk = compile preprocessFileLineNumbers "Scripts\OKS_Stealth\OKS_Enemy_Talk.sqf";
};
OKS_Enemy_Radio = compile preprocessFileLineNumbers "Scripts\OKS_Stealth\OKS_Enemy_Radio.sqf";
OKS_Enemy_Sentry = compile preprocessFileLineNumbers "Scripts\OKS_Stealth\OKS_Enemy_Sentry.sqf";

if(GOL_OKS_Tracker isEqualTo 1) then {
	waitUntil {sleep 5; !isNil "OKS_Hunted"};
	{
		if(isPlayer (leader _X)) then {
			[
				_X
				/*,
				Optional: Trigger with Any Player to only create tracks inside */
			] spawn OKS_Hunted
		}
	} foreach AllGroups;
};


