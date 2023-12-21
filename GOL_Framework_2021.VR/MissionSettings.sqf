/* Gear Settings */
GOL_MAGNIFIED_OPTICS = 0;
GOL_OPTICS = 1;
GOL_WEAPONS = 1;
GOL_ARSENAL_ALLOWED = 1;
GOL_ENTRENCH = 0;
GOL_OKS_SecondPrimaryWeapon = 0;
GOL_PACKED_HMG = "RHS_M2StaticMG_USMC_D";
GOL_PACKED_MORTAR = "B_G_Mortar_01_F";
GOL_PACKED_AT = "RHS_TOW_TriPod_USMC_D";
GOL_PACKED_GMG = "RHS_MK19_TriPod_USMC_WD";

/* AI Gear Settings */
// 0 = 0%, 1 = 100%
GOL_LAT_Chance = 0.25;
GOL_MAT_Chance = 0.15;
GOL_UGL_Chance = 0.25;

/* AI Static Settings */
// 0 = 0%, 1 = 100%
GOL_Static_Enable_Chance = 0.5;
GOL_Static_Enable_Refresh = 30;

/* AI Vehicle Settings */
// Removes HE/FRAG rounds from SPG-9, T-** Tanks and BMP1s.
GOL_Remove_HE_From_StaticAndVehicle = true;
GOL_Remove_ATGM_FromVehicles = true;

// ACE Carry/Drag Container Settings
ACE_maxWeightCarry = 1400; 
ACE_maxWeightDrag = 2200;

/* Logistics & Support Settings */
GOL_NEKY_SERVICESTATION = 1;
GOL_NEKY_RESUPPLY = 1;
GOL_NEKY_PARADROP = 0;
GOL_NEKY_PICKUP = 0;
GOL_NEKY_REINSERT = 0;  // Requires Additional Script
GOL_OKS_REINFORCEMENT = 0;  // Requires Additional Script
GOL_NEKY_FASTROPE = 0; // Not particularly good - engine limitations stop helicopters from hovering under 50-ish meters.
GOL_OKS_SUPPORT = 0;  // Requires Additional Script

GOL_OKS_TentMHQ = 1; 
/* ^ Change code in "Scripts/OKS_TentMHQ/ACE_MoveMHQ.sqf" to enable all players to move tent.
Requires init.sqf line 28 to be commented out and replaced with line 29.
_condition = {true} is the correct one to use for that. */

/* AI Settings & Scripts*/
GOL_NEKY_SHARE = 0; // Requires Additional Script
GOL_OKS_SPAWN = 1;
GOL_OKS_AMBIENCE = 1;
GOL_OKS_HUNT = 0; // Requires Additional Script
GOL_OKS_Enemy_Talk = 0;
GOL_OKS_Tracker = 0;

/* HuntBases */
GOL_NEKY_HUNT = 1;
GOL_NEKY_AIRDROP = 1;

/* HuntBases Settings */
NEKY_Hunt_MaxCount = 40;
NEKY_Hunt_CurrentCount = [];
publicVariable "NEKY_Hunt_MaxCount";
publicVariable "NEKY_Hunt_CurrentCount";

/* Optional Settings */
GOL_AAC_SETUP = 1; // Adds ability for pilots to switch seats more freely
GOL_AAC_DoorGunReplacement = false; // Changes miniguns to Yak-9s for better accuracy of tracers. Causes hearing damage so needs to be fired at a slower rate.
GOL_OKS_TASK = 1;
GOL_OKS_TANKER = 0;  // Requires Additional Script
GOL_NEKY_TASK = 0; 
GOL_OKS_SCRAMBLER = 0;  // Requires Additional Script
GOL_OKS_MHQ_PARADROP = 0;  // Requires Additional Script
GOL_EnableHelicopterScriptToAllVehicles = 0;
GOL_BLU_AUTO_TS_CHANNEL = 1;

/* GOL Dynamic Scripts */
GOL_OKS_DYNAMIC = 1;

/* Classname Settings */
GOL_NEKY_SUPPLY_HELICOPTER = "";

if(!isNil "Vehicle_1") then {
	GOL_NEKY_VEHICLEDROP_VEHICLECLASS = (typeOf Vehicle_1); // Classname
	GOL_NEKY_VEHICLEDROP_APPEARANCE = compile ([Vehicle_1,""] call BIS_fnc_exportVehicle);
	GOL_NEKY_VEHICLEDROP_CODE = {

		Params ["_Vehicle"];
		_Vehicle call GOL_NEKY_VEHICLEDROP_APPEARANCE;

		sleep 5;
		[_Vehicle] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";	


	};
};
if(!isNil "MHQ_1") then {
	GOL_NEKY_MHQDROP_VEHICLECLASS = (typeOf MHQ_1); // Classname
	GOL_NEKY_MHQDROP_APPEARANCE = compile ([MHQ_1,""] call BIS_fnc_exportVehicle);
	GOL_NEKY_MHQDROP_CODE = {

		Params ["_Vehicle"];
		_Vehicle call GOL_NEKY_MHQDROP_APPEARANCE;

		[_Vehicle, "medium"] call GW_MHQ_Fnc_Handler;
		[_Vehicle,25,true] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";

		sleep 5;	
		[_Vehicle] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";	

	};
};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*
	Set AI Faces & Voices for Factions / Units

	Options:
	african
	asian
	english
	american
	middleeast
	russian
	french

	!! OKS_Ambience must be turned to 1 in MissionSettings.sqf !!
*/
[] spawn {
	if(isServer && GOL_OKS_AMBIENCE isEqualTo 1) then {
		waitUntil {sleep 1; !(isNil "OKS_FaceSwap")};
		[east,"russian"] spawn OKS_FaceSwap;
	};
};

/* DO NOT EDIT BELOW */
OKS_MISSION_SETTINGS = true;
