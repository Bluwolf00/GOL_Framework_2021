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

// ACE Carry/Drag Container Settings
ACE_maxWeightCarry = 1400; 
ACE_maxWeightDrag = 2200;

/* Logistics & Support Settings */
enableEngineArtillery false; // Enable/Disable Artillery Computer (Undefined = true)
GOL_OKS_MhqSafeZone = 100;
/*
Change code in "Scripts\GOL_PlayerSetup\init.sqf" to enable all players to move tent.
Requires line 34 to be replaced with line below.
	_condition = {true};
*/

/* AI Settings & Scripts*/
GOL_OKS_SPAWN = 1;
GOL_OKS_AMBIENCE = 1;

/* HuntBases Settings */
NEKY_Hunt_CurrentCount = [];
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

/* DO NOT EDIT BELOW */
OKS_MISSION_SETTINGS = true;
OKS_MISSION_SETTINGS
