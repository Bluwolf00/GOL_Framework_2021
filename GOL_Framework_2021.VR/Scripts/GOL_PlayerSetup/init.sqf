
/*
	Init for Player Setup Scripts
	
	execVM "Scripts\GOL_PlayerSetup\init.sqf";
*/
// Global Execution
OKS_TFAR_RadioSetup = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\OKS_TFAR_RadioSetup.sqf";

if(GOL_OKS_TentMHQ isEqualTo 1 && !isNil "Tent_MHQ") then {
	execVM "Scripts\GOL_PlayerSetup\ACE_MoveMHQ.sqf";
};

/* Define Player Side for Scripts */
if(HasInterface && isNil "OKS_FRIENDLY_SIDE") then {
	OKS_FRIENDLY_SIDE = [player] call GW_Common_Fnc_getSide;
	publicVariable "OKS_FRIENDLY_SIDE";
};

// Add ACE Door actions on Helicopters on startup.
{
	[_x] execVM "Scripts\OKS_Vehicles\BLU_HeliActions.sqf";
} forEach (entities "Helicopter");

// Setup Scoreboard Loop
[] spawn {
	while {true} do {
		execVM "Scripts\GOL_PlayerSetup\OKS_DeathScore.sqf";
		sleep 20;
	};
};

// Server & HC Execution
if (hasInterface && !isServer) exitWith {false};


