//	[Side] Call OKS_Dynamic_Settings;
//
//	Settings for OKS Dynamic.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_Vehicles","_Wheeled","_APC","_Tank","_Helicopter","_Respawn","_Waves"];

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		_Wheeled = ["rhsusf_m1025_w_s_m2","British_LandRover_WMIK_GPMG_Green_A", "LOP_CDF_UAZ", "LOP_CDF_UAZ_Open", "LOP_CDF_UAZ_SPG", "rhsgref_cdf_b_reg_uaz_dshkm", "rhsgref_cdf_b_gaz66o"];
		_APC = ["rhsgref_BRDM2_b", "rhsgref_BRDM2_HQ_b", "rhsgref_cdf_b_btr60", "rhsgref_cdf_b_btr80", "rhsgref_cdf_b_btr70"];
		_Tank = ["rhsgref_cdf_b_t72ba_tv"];
		_Helicopter = ["RHS_UH1Y_UNARMED"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};
	case OPFOR:		// OPFOR settings
	{
		_Wheeled = ["RHS_UAZ_MSV_01", "rhs_uaz_open_MSV_01", "LOP_US_UAZ_DshKM", "LOP_US_UAZ_SPG", "rhs_gaz66_vdv"];
		_APC = ["rhs_btr60_vdv", "rhs_btr70_vdv", "rhs_btr80_vdv"];
		_Tank = ["rhs_t72ba_tv", "LOP_NK_T55"];
		_Helicopter = ["O_Heli_Light_02_unarmed_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Wheeled = ["LOP_NAPA_Landrover_M2", "I_G_Offroad_01_armed_F", "I_G_Offroad_01_F", "LOP_AM_Nissan_PKM"];
		_APC = ["rhsgref_BRDM2_ins_g", "rhsgref_BRDM2_HQ_ins_g", "LOP_UKR_BTR60", "LOP_UKR_BTR70"];
		_Tank = ["LOP_AFR_T55","LOP_AFR_T34"];
		_Helicopter = ["I_Heli_light_03_unarmed_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_Wheeled = ["RHS_UAZ_MSV_01", "rhs_uaz_open_MSV_01", "LOP_US_UAZ_DshKM", "LOP_US_UAZ_SPG", "rhs_gaz66_vdv"];
		_APC = ["rhs_btr60_vdv", "rhs_btr70_vdv", "rhs_btr80_vdv"];
		_Tank = ["rhs_t72ba_tv", "LOP_NK_T55"];
		_Helicopter = ["O_Heli_Light_02_unarmed_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];
	};
};

/* Respawn Time in seconds */
_InfantryRespawnTime = 1200;
_WheeledRespawnTime = 1200;
_APCRespawnTime = 1200;
_TankRespawnTime = 1200;
_HelicopterRespawnTime = 1200;

/* Number of Waves */
_InfantryWaves = 5;
_WheeledWaves = 5;
_APCWaves = 5;
_TankWaves = 5;
_HelicopterWaves = 5;

/* Global Refresh Rate */
_RefreshRate = 30;

_Waves = [_InfantryWaves,_WheeledWaves,_APCWaves,_TankWaves,_HelicopterWaves];
_Respawn = [_InfantryRespawnTime,_WheeledRespawnTime,_APCRespawnTime,_TankRespawnTime,_HelicopterRespawnTime];

// DO NOT EDIT ANYTHING BELOW \\
[_Vehicles,_Respawn,_Waves,_RefreshRate];