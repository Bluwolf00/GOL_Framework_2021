//	[Side] Call OKS_Dynamic_Settings;
//
//	Settings for OKS Dynamic.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_Units","_SideMarker","_SideColor","_Vehicles","_Wheeled","_APC","_Tank","_Artillery","_Supply","_Transport","_Civilian","_Officer"];

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_TL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = ["B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"]; // Class names for infantry units.
		_Officer = ["B_officer_F"];
		_Wheeled = ["rhsusf_m1025_w_s_m2","CUP_B_UAZ_MG_CDF","CUP_B_UAZ_SPG9_CDF","CUP_B_UAZ_Unarmed_CDF","CUP_B_Kamaz_CDF","CUP_B_UAZ_Open_CDF"];
		_APC = ["CUP_B_BTR80_CDF","CUP_B_BTR60_CDF","CUP_B_BRDM2_CDF","rhsusf_m113_usarmy"];
		_Tank = ["CUP_B_T72_CDF"];
		_Artillery = ["CUP_B_D30_CDF"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["CUP_B_BMP2_AMB_CDF","CUP_B_Kamaz_Reammo_CDF","CUP_B_Kamaz_Refuel_CDF","CUP_B_Kamaz_Repair_CDF","CUP_B_CDF_Soldier_MNT"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Transport,_Supply];
		_SideMarker = "b_inf";
		_SideColor = "ColorBlufor";
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = ["O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
		_Officer = ["O_officer_F"];
		_Wheeled = ["CUP_O_Datsun_PK","CUP_O_Hilux_DSHKM_CHDKZ","CUP_O_Datsun_4seat","CUP_O_UAZ_Unarmed_CHDKZ","CUP_O_UAZ_Open_CHDKZ"];
		_APC = ["CUP_O_BTR60_CHDKZ","CUP_O_BRDM2_CHDKZ","CUP_O_BTR80_CHDKZ"];
		_Tank = ["CUP_O_T55_CHDKZ","CUP_O_T72_CHDKZ"];
		_Artillery = ["rhs_D30_msv","rhs_2s3_tv","RHS_BM21_MSV_01"];
		_Transport = ["CUP_O_UAZ_Unarmed_CHDKZ"];
		_Supply = ["rhs_gaz66_ammo_msv","rhs_gaz66_r142_vdv","rhs_gaz66_ap2_vdv"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Transport,_Supply];
		_SideMarker = "o_inf";
		_SideColor = "ColorOpfor";
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_TL_F","I_Soldier_TL_F"];
		_Units = ["I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
		_Officer = ["I_officer_F"];
		_Wheeled = ["CUP_I_Hilux_DSHKM_IND_G_F","I_G_Offroad_01_armed_F","CUP_I_Datsun_PK_TK","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Covered_TKG","CUP_I_Datsun_4seat_TK","CUP_I_V3S_Covered_TKG","CUP_I_BTR40_TKG"];
		_APC = ["CUP_I_BRDM2_NAPA","CUP_I_BMP2_NAPA","CUP_I_Hilux_btr60_TK"];
		_Tank = ["CUP_I_T34_NAPA","CUP_I_T55_NAPA"];
		_Artillery = ["CUP_I_D30_TK_GUE"];
		_Transport = ["CUP_I_LR_Transport_AAF","I_G_Van_02_transport_F","CUP_I_BTR40_TKG"];
		_Supply = ["I_Truck_02_ammo_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_box_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Transport,_Supply];
		_SideMarker = "n_inf";
		_SideColor = "ColorIndependent";
	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_SkillVariables = "";
		_Skill = "";
		_Leaders = "";
		_Units = "";
	};
};

_CivilianUnits = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
_Civilian = [_CivilianUnits,_Officer];

// DO NOT EDIT ANYTHING BELOW \\
[_Units,_SideMarker,_SideColor,_Vehicles,_Civilian]