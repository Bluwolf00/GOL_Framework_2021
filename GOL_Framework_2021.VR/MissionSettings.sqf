/* Gear Settings */
GOL_MAGNIFIED_OPTICS = 0;
GOL_ARSENAL_ALLOWED = 1;

/* AI Gear Settings */
// 0 = 0%, 1 = 100%
GOL_LAT_Chance = 0.5;
GOL_MAT_Chance = 0.3;
GOL_UGL_Chance = 0.5;

/* AI Static Settings */
// 0 = 0%, 1 = 100%
GOL_Static_Enable_Chance = 0.3;
GOL_Static_Enable_Refresh = 15;

/* AI Vehicle Settings */
// Removes HE/FRAG rounds from SPG-9, T-** Tanks and BMP1s.
GOL_Remove_HE_From_StaticAndVehicle = true;
GOL_Remove_ATGM_FromVehicles = true;

// ACE Carry/Drag Container Settings
ACE_maxWeightCarry = 1200; 
ACE_maxWeightDrag = 2000;

/* Logistics & Support Settings */
GOL_NEKY_SERVICESTATION = 1;
GOL_NEKY_RESUPPLY = 1;
GOL_NEKY_PARADROP = 1;
GOL_NEKY_PICKUP = 0;
GOL_NEKY_REINSERT = 0;
GOL_OKS_REINFORCEMENT = 0;
GOL_NEKY_FASTROPE = 0; // Not particularly good - engine limitations stop helicopters from hovering under 50-ish meters.
GOL_OKS_SUPPORT = 0;

/* AI Settings & Scripts*/
GOL_NEKY_SHARE = 1;
GOL_OKS_SPAWN = 1;
GOL_OKS_AMBIENCE = 1;
GOL_OKS_HUNT = 0;
GOL_OKS_Enemy_Talk = 0;

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
GOL_OKS_TASK = 0;
GOL_OKS_TANKER = 0;
GOL_NEKY_TASK = 0;
GOL_OKS_SCRAMBLER = 0;
GOL_OKS_MHQ_PARADROP = 0;
GOL_EnableHelicopterScriptToAllVehicles = 0;
GOL_BLU_AUTO_TS_CHANNEL = 1;

/* GOL Dynamic Scripts */
GOL_OKS_DYNAMIC = 1;

/* Classname Settings */
GOL_NEKY_SUPPLY_HELICOPTER = "";

/* DO NOT EDIT BELOW */
OKS_MISSION_SETTINGS = true;
