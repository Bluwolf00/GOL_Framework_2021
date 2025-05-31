
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

if (hasInterface) then {
	_condition = {player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4]};
	_action = ["Request_Support", "Request Support","\A3\ui_f\data\map\VehicleIcons\iconCrateVeh_ca.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
	execVM "Scripts\GOL_PlayerSetup\ORBAT\OKS_Orbat_Action.sqf";
};

// Server & HC Execution
if (hasInterface && !isServer) exitWith {false};



