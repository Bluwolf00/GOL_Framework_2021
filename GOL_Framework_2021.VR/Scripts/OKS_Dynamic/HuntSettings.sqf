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
		_Wheeled = ["rhsusf_m1025_w_s_m2","CUP_B_UAZ_MG_CDF","CUP_B_UAZ_SPG9_CDF","CUP_B_UAZ_Unarmed_CDF","CUP_B_Kamaz_CDF","CUP_B_UAZ_Open_CDF"];
		_APC = ["CUP_B_BTR80_CDF","CUP_B_BTR60_CDF","CUP_B_BRDM2_CDF","rhsusf_m113_usarmy"];
		_Tank = ["CUP_B_T72_CDF"];
		_Helicopter = ["RHS_UH1Y_UNARMED"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};
	case OPFOR:		// OPFOR settings
	{
		_Wheeled = ["CUP_O_Datsun_PK","CUP_O_Hilux_DSHKM_CHDKZ","CUP_O_Datsun_4seat","CUP_O_UAZ_Unarmed_CHDKZ","CUP_O_UAZ_Open_CHDKZ"];
		_APC = ["CUP_O_BTR60_CHDKZ","CUP_O_BRDM2_CHDKZ","CUP_O_BTR80_CHDKZ"];
		_Tank = ["CUP_O_T55_CHDKZ","CUP_O_T72_CHDKZ"];
		_Helicopter = ["O_Heli_Light_02_unarmed_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Wheeled = ["CUP_I_Hilux_DSHKM_IND_G_F","I_G_Offroad_01_armed_F","CUP_I_Datsun_PK_TK","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Covered_TKG","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Covered_TKG","CUP_I_BTR40_TKG"];
		_APC = ["CUP_I_BRDM2_NAPA","CUP_I_BMP2_NAPA","CUP_I_Hilux_btr60_TK"];
		_Tank = ["CUP_I_T34_NAPA","CUP_I_T55_NAPA"];
		_Helicopter = ["I_Heli_light_03_unarmed_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Helicopter];

	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_Wheeled = ["CUP_O_Datsun_PK","CUP_O_Hilux_DSHKM_CHDKZ","CUP_O_Datsun_4seat","CUP_O_UAZ_Unarmed_CHDKZ","CUP_O_UAZ_Open_CHDKZ"];
		_APC = ["CUP_O_BTR60_CHDKZ","CUP_O_BRDM2_CHDKZ","CUP_O_BTR80_CHDKZ"];
		_Tank = ["CUP_O_T55_CHDKZ","CUP_O_T72_CHDKZ"];
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