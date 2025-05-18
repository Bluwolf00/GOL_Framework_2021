 /* Gear Settings */
GOL_Composition = 0; // Composition Setup for ORBAT - -1 Disabled, 0 Infantry, 1 Mechanized.
GOL_MAGNIFIED_OPTICS = 0; // Allows magnified 2x sights to be selected from the Arsenal.
GOL_OPTICS = 1; 		  // Allows sights to be selected from the Arsenal.
GOL_WEAPONS = 1;		  // Allows weapon variations to be selected from Arsenal (If Faction is setup for it).
GOL_ARSENAL_ALLOWED = 1;  // Allows Attachment Menu
GOL_AllowSpecialistGroundRoles = 1; // 0 - None || 1 - Platoon Mortar Operator || 2 - Dragon (Mortar), Light Rifleman, Ammo Bearer, Anti-Air, Asst. Heavy AT, Heavy AT
GOL_AllowSpecialistAirRoles = 0; // Para-Rescueman, Jet Pilot, Marksman
GOL_ENTRENCH = 0;		  // Adds Entrenching Tools to certain roles.
GOL_WIRECUTTER = 0; 	  // Adds Wirecutters to Riflemen.
GOL_MedicalAsstGunner = ["ShouldGiveMedicalToAsstGunner", 1] call BIS_fnc_getParamValue;
GOL_PACKED_HMG = "RHS_M2StaticMG_USMC_D";
GOL_PACKED_MORTAR = "B_G_Mortar_01_F";
GOL_PACKED_AT = "RHS_TOW_TriPod_USMC_D";
GOL_PACKED_GMG = "RHS_MK19_TriPod_USMC_WD";
GOL_PACKED_DRONE_AP = "B_UAFPV_RKG_AP"; // "B_UAFPV_AP" (IED) || "B_UAFPV_RKG_AP" (HE) || "B_Crocus_AP" (TGV-7)
GOL_PACKED_DRONE_AT = "B_UAFPV_AT"; // "B_UAFPV_AT" (PG-7VL) || "B_Crocus_AT" (PG-7VL)
GOL_PACKED_DRONE_Recon = "B_UAV_01_F";
GOL_PACKED_DRONE_Supply = "B_UAV_06_F";

GOL_PACKED_STATIC_WEAPONS = [GOL_PACKED_HMG,GOL_PACKED_MORTAR,GOL_PACKED_AT,GOL_PACKED_GMG];
OKS_DroneClassnames = [GOL_PACKED_DRONE_Recon,GOL_PACKED_DRONE_Supply,GOL_PACKED_DRONE_AP,GOL_PACKED_DRONE_AT];
GOL_ForceNVG = 0; // Forces addition of NVGs
//GOL_ForceNVGClassname = "G_Armband_NVG_red_alt_F"; // Forces the classname to be used as NVG.

/* AI Gear Settings */
// 0 = 0%, 1 = 100%
GOL_LAT_Chance = 0.25; // Chance for Light AT to be given to AI.
GOL_MAT_Chance = 0.15; // Chance for Medium AT to be given to AI.
GOL_UGL_Chance = 0.25; // Chance for UGL to be given to AI.
GOL_AIForceNVG = 0; // Forces addition of NVGs
//GOL_AIForceNVGClassname = "G_Armband_NVG_grn_alt_F"; // Forces the AI classname to be used as NVG.

/* AI Static Settings */
// 0 = 0%, 1 = 100%
GOL_Static_Enable_Chance = 0.4; // Chance per loop to enable a Static AI to move.
GOL_Static_Enable_Refresh = 60; // Delay per loop to enable movement.
OKS_Suppression = 1; // Adds suppression sensitivty to AI.
OKS_Suppressed_Threshold = 0.75; // Minimum value for Suppression.
OKS_Suppressed_MinimumTime = 6; // Minimum time for Suppressed state.
OKS_Suppressed_MaximumTime = 10; // Maximum time for Suppressed state.

/* AI Vehicle Settings */
// Removes HE/FRAG rounds from SPG-9, T-** Tanks and BMP1s.
GOL_Remove_HE_From_StaticAndVehicle = true;
GOL_Remove_ATGM_FromVehicles = true;

// ACE Carry/Drag Container Settings
ACE_maxWeightCarry = 1400; 
ACE_maxWeightDrag = 2200;

/* Logistics & Support Settings */
enableEngineArtillery false; // Enable/Disable Artillery Computer (Undefined = true)
GOL_NEKY_SERVICESTATION = 1;
GOL_NEKY_RESUPPLY = 1;
GOL_NEKY_PARADROP = 0; // Requires Additional Script
GOL_NEKY_PICKUP = 0; // Requires Additional Script
GOL_NEKY_REINSERT = 0;  // Requires Additional Script
GOL_OKS_REINFORCEMENT = 0;  // Requires Additional Script
GOL_NEKY_FASTROPE = 0; // Not particularly good - engine limitations stop helicopters from hovering under 50-ish meters.
GOL_OKS_SUPPORT = 0;  // Requires Additional Script

GOL_OKS_TentMHQ = 1; 
GOL_OKS_MhqSafeZone = 100;
/*
Change code in "Scripts\GOL_PlayerSetup\init.sqf" to enable all players to move tent.
Requires line 34 to be replaced with line below.
	_condition = {true};
*/

/* AI Settings & Scripts*/
GOL_NEKY_SHARE = 0; // Requires Additional Script
GOL_OKS_SPAWN = 1;
GOL_OKS_AMBIENCE = 1;
GOL_OKS_HUNT = 0; // Requires Additional Script
GOL_OKS_Stealth_Mission = 0; // Requires Additional Script
GOL_OKS_Enemy_Talk = 0; // This requires sound effects from the "GOL_Framework_2021\Additional Radio\Vietnamese" folder to be moved to "MissionFolder\Scripts\OKS_Stealth\Talk"
GOL_OKS_Tracker = 0; // Requires Additional Script

/* HuntBases */
GOL_NEKY_HUNT = 1;
GOL_NEKY_AIRDROP = 1;

if(isNil "OKS_ForceMultiplier") then {
	OKS_ForceMultiplier = 1; // Force Multiplier - Adjusts the values for spawns by Hunt (Increase soldiers by % - Cargo in Vehicles by % - Waves increased by %)
};
if(isNil "OKS_ResponseMultiplier") then {
	OKS_ResponseMultiplier = 1; // Reponse Multiplier - Adjusts the value for respawn/refresh by Hunt (Increase respawn delay by % - Increase refresh delay by %)
};

/* HuntBases Settings */
NEKY_Hunt_MaxCount = 40;
NEKY_Hunt_CurrentCount = [];
publicVariable "NEKY_Hunt_MaxCount";
publicVariable "NEKY_Hunt_CurrentCount";

/* Optional Settings */
GOL_AAC_SETUP = 1; // Adds ability for pilots to switch seats more freely
GOL_AAC_DoorGunReplacement = true; // Changes miniguns to Yak-9s for better accuracy of tracers. Causes hearing damage so needs to be fired at a slower rate.
GOL_OKS_TASK = 1;
GOL_OKS_TANKER = 0;  // Requires Additional Script
GOL_NEKY_TASK = 0; 
GOL_OKS_SCRAMBLER = 0;  // Requires Additional Script
GOL_OKS_MHQ_PARADROP = 0;  // Requires Additional Script
GOL_EnableHelicopterScriptToAllVehicles = 0;
GOL_BLU_AUTO_TS_CHANNEL = 1;

/* GOL Dynamic Scripts */
GOL_OKS_DYNAMIC = 1;

/* Classname Settings for Scripted Resupply Helicopters */
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
OKS_MISSION_SETTINGS
