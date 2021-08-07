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
		_Units = [
			"B_Soldier_A_F",
			"B_Soldier_AR_F",
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_medic_F",
			"B_crew_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_LAT_F"
		]; // Class names for infantry units.
		_Officer = ["B_officer_F"];
		_Wheeled = ["rhsusf_m1025_w_s_m2","British_LandRover_WMIK_GPMG_Green_A", "LOP_CDF_UAZ", "LOP_CDF_UAZ_Open", "LOP_CDF_UAZ_SPG", "rhsgref_cdf_b_reg_uaz_dshkm", "rhsgref_cdf_b_gaz66o"];
		_APC = ["rhsgref_BRDM2_b", "rhsgref_BRDM2_HQ_b", "rhsgref_cdf_b_btr60", "rhsgref_cdf_b_btr80", "rhsgref_cdf_b_btr70"];
		_Tank = ["rhsgref_cdf_b_t72ba_tv"];
		_Artillery = ["rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
		_SideMarker = "b_inf";
		_SideColor = "ColorBlufor";
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_A_F",
			"O_Soldier_AR_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_medic_F",
			"O_crew_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_LAT_F"
		];
		_Officer = ["O_officer_F"];
		_Wheeled = ["rhsgref_ins_uaz_dshkm","rhsgref_ins_uaz_spg9","rhsgref_ins_uaz_open","rhsgref_ins_uaz","rhsgref_ins_gaz66"];
		_APC = ["rhsgref_ins_btr60","rhsgref_ins_btr70","rhsgref_ins_bmd1","rhsgref_ins_bmd1p","rhsgref_ins_bmd2"];
		_Tank = ["rhsgref_ins_t72ba"];
		_Artillery = ["rhsgref_ins_2b14","rhsgref_ins_2s1","rhsgref_ins_BM21"];
		_Helicopter = ["rhsgref_ins_Mi8amt"];
		_Transport = ["rhsgref_ins_ural"];
		_Supply = ["rhsgref_ins_gaz66_r142","rhsgref_ins_gaz66_ap2","rhsgref_ins_kraz255b1_fuel","rhsgref_ins_ural_repair","rhsgref_ins_gaz66_ammo"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
		_SideMarker = "o_inf";
		_SideColor = "ColorOpfor"
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_TL_F","I_Soldier_TL_F"];
		_Units = [
			"I_Soldier_A_F",
			"I_Soldier_AR_F",
			"I_Soldier_AR_F",
			"I_medic_F",
			"I_medic_F",
			"I_crew_F",
			"I_Soldier_GL_F",
			"I_HeavyGunner_F",
			"I_soldier_M_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_LAT_F"
		];
		_Officer = ["I_officer_F"];
		_Wheeled = ["LOP_NAPA_Landrover_M2", "I_G_Offroad_01_armed_F", "I_G_Offroad_01_F", "LOP_AM_Nissan_PKM"];
		_APC = ["rhsgref_BRDM2_ins_g", "rhsgref_BRDM2_HQ_ins_g", "LOP_UKR_BTR60", "LOP_UKR_BTR70"];
		_Tank = ["LOP_AFR_T55","LOP_AFR_T34"];
		_Artillery = ["rhsgref_nat_d30"];
		_Helicopter = ["I_E_Heli_light_03_dynamicLoadout_F"];
		_Transport = ["I_G_Offroad_01_F","I_G_Van_02_transport_F"];
		_Supply = ["I_Truck_02_ammo_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_box_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
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
_ObjectiveTypes = ["cache","artillery","hostage","motorpool","radiotower"];

// DO NOT EDIT ANYTHING BELOW \\
[_Units,_SideMarker,_SideColor,_Vehicles,_Civilian,_ObjectiveTypes]

/*
		EAST - Takistani Army Settings

		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_A_F",
			"O_Soldier_AR_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_medic_F",
			"O_crew_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_LAT_F"
		];
		_Officer = ["O_officer_F"];
		_Wheeled = ["LOP_TKA_UAZ_SPG","LOP_TKA_UAZ_DshKM","rhsgref_tla_offroad_at","LOP_TKA_BMP1"];
		_APC = ["LOP_TKA_T34","LOP_TKA_BTR70","LOP_TKA_BTR60","LOP_TKA_T55"];
		_Tank = ["LOP_TKA_T55"];
		_Artillery = ["LOP_TKA_BM21", "LOP_TKA_Static_D30"];
		_Helicopter = ["LOP_TKA_Mi8MTV3_UPK23"];
		_Transport = ["LOP_TKA_Ural_open"];
		_Supply = ["rhs_gaz66_ammo_msv","rhs_gaz66_r142_vdv","rhs_gaz66_ap2_vdv"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
		_SideMarker = "o_inf";
		_SideColor = "ColorOpfor"
*/
/*
		EAST - Chedaki Army Settings

		_Leaders = ["O_Soldier_TL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_A_F",
			"O_Soldier_AR_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_medic_F",
			"O_crew_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_LAT_F"
		];
		_Officer = ["O_officer_F"];
		_Wheeled = ["rhsgref_ins_uaz_dshkm","rhsgref_ins_uaz_spg9","rhsgref_ins_uaz_open","rhsgref_ins_uaz","rhsgref_ins_gaz66"];
		_APC = ["rhsgref_ins_btr60","rhsgref_ins_btr70","rhsgref_ins_bmd1","rhsgref_ins_bmd1p","rhsgref_ins_bmd2"];
		_Tank = ["rhsgref_ins_t72ba"];
		_Artillery = ["rhsgref_ins_d30","rhsgref_ins_2b14","rhsgref_ins_2s1","rhsgref_ins_BM21"];
		_Helicopter = ["rhsgref_ins_Mi8amt"];
		_Transport = ["rhsgref_ins_ural"];
		_Supply = ["rhsgref_ins_gaz66_r142","rhsgref_ins_gaz66_ap2","rhsgref_ins_kraz255b1_fuel","rhsgref_ins_ural_repair","rhsgref_ins_gaz66_ammo"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
		_SideMarker = "o_inf";
		_SideColor = "ColorOpfor"
*/
/*
		WEST - LDF Army

		_Leaders = ["B_Soldier_TL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = [
			"B_Soldier_A_F",
			"B_Soldier_AR_F",
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_medic_F",
			"B_crew_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_LAT_F"
		]; // Class names for infantry units.
		_Officer = ["B_officer_F"];
		_Wheeled = ["Canadian_FMTV_M2","rhsgref_hidf_m1025_m2","rhsgref_hidf_m1025","rhsusf_m1152_rsv_usmc_wd","rhsusf_m1165_usmc_wd"];
		_APC = ["rhsgref_BRDM2_b", "rhsgref_cdf_b_btr60","M113_Olive_M240","rhsusf_stryker_m1127_m2_wd","rhsusf_m113_usarmy_M2_90"];
		_Tank = ["rhsgref_cdf_b_t72ba_tv"];
		_Artillery = ["rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
		_SideMarker = "b_inf";
		_SideColor = "ColorBlufor";

*/