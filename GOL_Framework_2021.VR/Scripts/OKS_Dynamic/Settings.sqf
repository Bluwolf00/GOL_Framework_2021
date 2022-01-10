//	[Side] Call OKS_Dynamic_Settings;
//
//	Settings for OKS Dynamic.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_Units","_SideMarker","_SideColor","_Vehicles","_Wheeled","_APC","_Tank","_Artillery","_Supply","_Transport","_Civilian","_Officer","_Settings","_AntiAir","_EnableEnemyMarkers","_RoadblockVehicleType","_UnitArray","_MarkerColor"];

/* Faction Selection for Vehicles spawned by OKS_Dynamic

BLUFOR FACTIONS:       CDF LDF TANOA
OPFOR FACTIONS:        CHEDAKI TKA DESERT_INSURGENTS RUSSIA_MODERN SOVIET TURKEY
INDEPENDENT FACTIONS:  NAPA SYRIA

*/
Private _Faction = "DESERT_INSURGENTS";
Switch (_Faction) do {

	case "SYRIA":{
		// Modern Russian Armed Forces (RUSSIA) - OPFOR
		_Wheeled = ["LOP_SYR_UAZ_DshKM","LOP_SYR_UAZ","LOP_SYR_UAZ_Open","LOP_SYR_KAMAZ_Transport","LOP_SYR_KAMAZ_Covered"];
		_APC = ["LOP_SYR_BTR60","LOP_SYR_BTR70"];
		_Tank = ["LOP_SYR_T55"];
		_Artillery = ["LOP_SYR_2S1","rhs_D30_vmf"];
		_AntiAir = ["LOP_SYR_ZSU234","LOP_SYR_Static_ZU23"];
		_Helicopter = ["RHS_Mi24P_vdv","RHS_Mi8MTV3_vdv"];
		_Transport = ["LOP_SYR_UAZ_Open"];
		_Supply = ["LOP_SYR_KAMAZ_Medical","LOP_SYR_KAMAZ_Fuel","LOP_SYR_KAMAZ_Ammo","LOP_SYR_KAMAZ_Repair"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "TURKEY":{
		// Modern Russian Armed Forces (RUSSIA) - OPFOR
		_Wheeled = ["LOP_TRK_Landrover","LOP_TRK_Landrover_M2","rhsusf_m998_w_s_2dr","rhsgref_nat_uaz"];
		_APC = ["LOP_TRK_BTR80","LOP_TRK_M113_W"];
		_Tank = ["Leopard_Olive"];
		_Artillery = ["rhs_2s1_tv","RHS_M119_WD","B_MBT_01_arty_F"];
		_AntiAir = ["LOP_UKR_ZSU234","rhsgref_nat_ZU23"];
		_Helicopter = ["rhs_uh1h_hidf_gunship","RHS_UH60M"];
		_Transport = ["rhsusf_m998_w_s_2dr"];
		_Supply = ["LOP_TRK_HEMTT_Ammo_D","LOP_TRK_HEMTT_Fuel_D","LOP_TRK_HEMTT_Medical_D","LOP_TRK_HEMTT_Repair_D"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "SOVIET":{
		// Modern Russian Armed Forces (RUSSIA) - OPFOR
		_Wheeled = ["rhs_tigr_msv","rhs_tigr_m_msv","RHS_UAZ_MSV_01","rhs_gaz66_msv","rhs_kamaz5350_msv"];
		_APC = ["rhs_btr60_msv","rhs_btr70_msv","rhs_bmp1_msv","rhs_bmp2e_msv"];
		_Tank = ["rhs_t72ba_tv","LOP_AFR_OPF_T55"];
		_Artillery = ["rhs_2s1_tv","rhs_D30_vmf","RHS_BM21_VMF_01"];
		_AntiAir = ["rhs_zsu234_aa","RHS_ZU23_VDV"];
		_Helicopter = ["RHS_Mi24P_vdv","RHS_Mi8MTV3_vdv"];
		_Transport = ["rhs_gaz66o_msv"];
		_Supply = ["rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_kamaz5350_ammo_vdv","RHS_Ural_Repair_VDV_01"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "RUSSIA_MODERN":{
		// Modern Russian Armed Forces (RUSSIA) - OPFOR
		_Wheeled = ["rhs_tigr_msv","rhs_tigr_m_msv","RHS_UAZ_MSV_01","rhs_gaz66_msv","rhs_kamaz5350_msv"];
		_APC = ["rhs_btr80a_vdv","rhs_btr80_vdv","rhs_bmd4_vdv","rhs_bmp3_msv","rhs_bmp2_msv"];
		_Tank = ["rhs_t90sab_tv","rhs_t90saa_tv","rhs_t90_tv","rhs_t80bvk"];
		_Artillery = ["rhs_2s1_tv","rhs_2s3_tv","rhs_D30_vmf","RHS_BM21_VMF_01"];
		_AntiAir = ["rhs_zsu234_aa","RHS_ZU23_VDV"];
		_Helicopter = ["RHS_Mi24P_vdv","RHS_Mi8MTV3_vdv"];
		_Transport = ["rhs_kamaz5350_open_msv"];
		_Supply = ["rhs_gaz66_r142_vdv","rhs_gaz66_repair_vdv","rhs_kamaz5350_ammo_vdv","RHS_Ural_Repair_VDV_01"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "TANOA":{
		// Tanoa Horizon Forces (TANOA) - BLUFOR
		_Wheeled = ["rhsgref_hidf_m113a3_unarmed","rhsgref_hidf_m1025_m2","rhsgref_hidf_M998_2dr_fulltop","rhsgref_hidf_m1025","rhsgref_hidf_M998_4dr_fulltop","rhsgref_hidf_M998_4dr_halftop","B_G_Offroad_01_armed_F"];
		_APC = ["rhsgref_BRDM2_b", "rhsgref_BRDM2_HQ_b", "rhsgref_hidf_m113a3_m2"];
		_Tank = ["LOP_AFR_T34","LOP_NK_T55"];
		_Artillery = ["rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
		_AntiAir = ["rhsgref_cdf_b_zsu234"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "CDF":
	{
		// Chernarussian Defence Force (CDF) - BLUFOR
		_Wheeled = ["rhsusf_m1025_w_s_m2","British_LandRover_WMIK_GPMG_Green_A", "LOP_CDF_UAZ", "LOP_CDF_UAZ_Open", "LOP_CDF_UAZ_SPG", "rhsgref_cdf_b_reg_uaz_dshkm", "rhsgref_cdf_b_gaz66o"];
		_APC = ["rhsgref_BRDM2_b", "rhsgref_BRDM2_HQ_b", "rhsgref_cdf_b_btr60", "rhsgref_cdf_b_btr80", "rhsgref_cdf_b_btr70"];
		_Tank = ["rhsgref_cdf_b_t72ba_tv"];
		_Artillery = ["rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
		_AntiAir = ["rhsgref_cdf_b_zsu234"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "CHEDAKI":
	{
		_Wheeled = ["rhsgref_ins_uaz_dshkm","rhsgref_ins_uaz_spg9","rhsgref_ins_uaz_open","rhsgref_ins_uaz","rhsgref_ins_gaz66"];
		_APC = ["rhsgref_ins_btr60","rhsgref_ins_btr70","rhsgref_ins_bmd1","rhsgref_ins_bmd1p","rhsgref_ins_bmd2"];
		_Tank = ["rhsgref_ins_t72ba"];
		_Artillery = ["rhsgref_ins_d30","rhsgref_ins_2b14","rhsgref_ins_2s1","rhsgref_ins_BM21"];
		_AntiAir = ["rhsgref_ins_zsu234"];
		_Helicopter = ["rhsgref_ins_Mi8amt"];
		_Transport = ["rhsgref_ins_ural"];
		_Supply = ["rhsgref_ins_gaz66_r142","rhsgref_ins_gaz66_ap2","rhsgref_ins_kraz255b1_fuel","rhsgref_ins_ural_repair","rhsgref_ins_gaz66_ammo"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "TKA":
	{
		// Takistani Army - OPFOR
		_Wheeled = ["LOP_TKA_UAZ_SPG","LOP_TKA_UAZ_DshKM","rhsgref_tla_offroad_at"];
		_APC = ["LOP_TKA_BTR70","LOP_TKA_BTR60","LOP_SYR_BMP1","rhsgref_BRDM2_b"];
		_Tank = ["LOP_TKA_T55","LOP_TKA_T34","LOP_SYR_BMP1"];
		_Artillery = ["LOP_TKA_BM21", "LOP_TKA_Static_D30"];
		_AntiAir = ["LOP_TKA_ZU23"];
		_Helicopter = ["LOP_TKA_Mi8MTV3_UPK23"];
		_Transport = ["LOP_TKA_Ural_open"];
		_Supply = ["rhs_gaz66_ammo_msv","rhs_gaz66_r142_vdv","rhs_gaz66_ap2_vdv"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "DESERT_INSURGENTS":
	{
		// Middle Eastern Insurgents - OPFOR
		_Wheeled = ["LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Landrover_M2","LOP_AM_OPF_Landrover","LOP_AM_OPF_Landrover_SPG9","LOP_AM_OPF_UAZ_Open"];
		_APC = ["LOP_SYR_BMP1"];
		_Tank = ["LOP_TKA_T55","LOP_TKA_T34"];
		_Artillery = ["rhs_2b14_82mm_msv", "LOP_TKA_Static_D30"];
		_AntiAir = ["rhsgref_ins_ZU23"];
		_Helicopter = ["LOP_TKA_Mi8MTV3_UPK23"];
		_Transport = ["LOP_TKA_Ural_open"];
		_Supply = ["rhs_gaz66_ammo_msv","rhs_gaz66_r142_vdv","rhs_gaz66_ap2_vdv"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "LDF": {
		// Livonia Defence Force - 1980s
		_Wheeled = ["Canadian_FMTV_M2","rhsgref_hidf_m1025_m2","rhsgref_hidf_m1025","rhsusf_m1152_rsv_usmc_wd","rhsusf_m1165_usmc_wd"];
		_APC = ["rhsgref_BRDM2_b", "M113_Olive_M240","rhsusf_m113_usarmy_M2_90"];
		_Tank = ["rhsgref_cdf_b_t72ba_tv"];
		_Artillery = ["I_E_Truck_02_MRL_F","rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
		_AntiAir = ["rhsgref_cdf_b_ZU23"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["rhsusf_m998_w_4dr_halftop"];
		_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "NAPA":
	{
		// NAPA Insurgents - INDEPENDENT
		_Wheeled = ["LOP_NAPA_Landrover_M2", "I_G_Offroad_01_armed_F", "I_G_Offroad_01_F", "LOP_AM_Nissan_PKM"];
		_APC = ["rhsgref_BRDM2_ins_g", "rhsgref_BRDM2_HQ_ins_g", "LOP_UKR_BTR60", "LOP_UKR_BTR70"];
		_Tank = ["LOP_AFR_T55","LOP_AFR_T34"];
		_Artillery = ["rhsgref_nat_d30"];
		_AntiAir = ["rhsgref_nat_ZU23"];
		_Helicopter = ["I_E_Heli_light_03_dynamicLoadout_F"];
		_Transport = ["I_G_Offroad_01_F","I_G_Van_02_transport_F"];
		_Supply = ["I_Truck_02_ammo_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_box_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	Default {
		Switch (_Side) do
		{
			case BLUFOR:	// BLUFOR settings
			{
				// Chernarussian Defence Force (CDF) - BLUFOR
				_Wheeled = ["rhsusf_m1025_w_s_m2","British_LandRover_WMIK_GPMG_Green_A", "LOP_CDF_UAZ", "LOP_CDF_UAZ_Open", "LOP_CDF_UAZ_SPG", "rhsgref_cdf_b_reg_uaz_dshkm", "rhsgref_cdf_b_gaz66o"];
				_APC = ["rhsgref_BRDM2_b", "rhsgref_BRDM2_HQ_b", "rhsgref_cdf_b_btr60", "rhsgref_cdf_b_btr80", "rhsgref_cdf_b_btr70"];
				_Tank = ["rhsgref_cdf_b_t72ba_tv"];
				_Artillery = ["rhsgref_cdf_b_2s1", "rhsgref_cdf_b_reg_d30"];
				_AntiAir = ["rhsgref_cdf_b_zsu234"];
				_Helicopter = ["rhs_uh1h_hidf"];
				_Transport = ["rhsusf_m998_w_4dr_halftop"];
				_Supply = ["rhsgref_cdf_b_gaz66_ammo", "rhsgref_cdf_b_gaz66_r142", "rhsgref_cdf_b_gaz66_zu23", "rhsgref_cdf_b_gaz66_ap2", "rhsgref_cdf_b_gaz66_repair", "rhsgref_cdf_b_zil131_flatbed"];
				_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
			};

			case OPFOR:
			{
				// Takistani Army - OPFOR
				_Wheeled = ["LOP_TKA_UAZ_SPG","LOP_TKA_UAZ_DshKM","rhsgref_tla_offroad_at","LOP_TKA_BMP1"];
				_APC = ["LOP_TKA_T34","LOP_TKA_BTR70","LOP_TKA_BTR60","LOP_TKA_T55"];
				_Tank = ["LOP_TKA_T55"];
				_Artillery = ["LOP_TKA_BM21", "LOP_TKA_Static_D30"];
				_Helicopter = ["LOP_TKA_Mi8MTV3_UPK23"];
				_Transport = ["LOP_TKA_Ural_open"];
				_Supply = ["rhs_gaz66_ammo_msv","rhs_gaz66_r142_vdv","rhs_gaz66_ap2_vdv"];
				_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply];
			};

			case independent:
			{
				// NAPA Insurgents - INDEPENDENT
				_Wheeled = ["LOP_NAPA_Landrover_M2", "I_G_Offroad_01_armed_F", "I_G_Offroad_01_F", "LOP_AM_Nissan_PKM"];
				_APC = ["rhsgref_BRDM2_ins_g", "rhsgref_BRDM2_HQ_ins_g", "LOP_UKR_BTR60", "LOP_UKR_BTR70"];
				_Tank = ["LOP_AFR_T55","LOP_AFR_T34"];
				_Artillery = ["rhsgref_nat_d30"];
				_AntiAir = ["LOP_AM_Static_ZU23"];
				_Helicopter = ["I_E_Heli_light_03_dynamicLoadout_F"];
				_Transport = ["I_G_Offroad_01_F","I_G_Van_02_transport_F"];
				_Supply = ["I_Truck_02_ammo_F","I_Truck_02_medical_F","I_Truck_02_fuel_F","I_Truck_02_box_F"];
				_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
			};

		};
	};
};


Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_SL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = [
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_LAT_F"
		]; // Class names for infantry units.
		_Officer = ["B_officer_F"];
		_SideMarker = "b_inf";
		_SideColor = "ColorBlufor";
		_UnitArray = [_Leaders,_Units,_Officer];
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_SL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_LAT_F"
		];
		_Officer = ["O_officer_F"];
		_SideMarker = "o_inf";
		_SideColor = "ColorOpfor";
		_UnitArray = [_Leaders,_Units,_Officer];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_SL_F","I_Soldier_TL_F"];
		_Units = [
			"I_Soldier_AR_F",
			"I_medic_F",
			"I_Soldier_GL_F",
			"I_soldier_M_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_LAT_F"
		];
		_Officer = ["I_officer_F"];
		_SideMarker = "n_inf";
		_SideColor = "ColorIndependent";
		_UnitArray = [_Leaders,_Units,_Officer];
	};

	case civilian:
	{
		_Leaders = ["C_man_1"];
		_Units = [
			"C_man_polo_1_F",
			"C_man_polo_2_F",
			"C_man_polo_3_F",
			"C_man_polo_4_F",
			"C_man_polo_5_F",
			"C_man_polo_6_F",
			"C_man_1_1_F",
			"C_man_1_2_F",
			"C_man_1_3_F"
		];
		_Officer = ["C_man_1_1_F"];
		_SideMarker = "empty";
		_SideColor = "ColorCivilian";
		_UnitArray = [_Leaders,_Units,_Officer];
		_Wheeled = ["UK3CB_Civ_LandRover_Soft_Green_A","C_Offroad_01_covered_F","C_Offroad_01_repair_F","C_Van_02_transport_F","LOP_CHR_Civ_Landrover","LOP_CHR_Civ_UAZ","LOP_CHR_Civ_UAZ_Open",""];
		_APC = ["LOP_AFR_Civ_Hatchback"];
		_Tank = ["LOP_TAK_Civ_Ural"];
		_Artillery = [""];
		_AntiAir = [""];
		_Helicopter = ["RHS_Mi8t_civilian"];
		_Transport = ["LOP_TAK_Civ_Ural"];
		_Supply = ["C_Van_01_box_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Van_01_fuel_F"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	// DO NOT EDIT ANYTHING BELOW \\
	default
	{
		_SkillVariables = "";
		_Skill = "";
		_Leaders = "";
		_Units = "";
		_UnitArray = "";
	};
};

/* ADDITIONAL SETTINGS */

/* ObjectiveTypes: ["cache","artillery","hostage","hvttruck","ammotruck","radiotower","motorpool","antiair"] If you wish to disable just remove them from the array above. */
_ObjectiveTypes = ["cache","artillery","hostage","hvttruck","ammotruck","radiotower","motorpool","antiair"];

/* CompoundSize defines in meters how large a compound is conisdered in this mission. Garrisons will spread out at this distance*/
_CompoundSize = 25;

/* EnableEnemyMarkers will place markers at enemy strongpoints, compounds, roadblocks & mortar pits populated by Static Targets */
_EnableEnemyMarkers = true;

/* Mark Trigger Area with Zone Marker*/
_EnableZoneMarker = false;

/* Mark Trigger Area with Zone Type Marker */
_EnableZoneTypeMarker = true;

/* Enemy Marker Color - Default SideColor set to _MarkerColor = false*/
_MarkerColor = false;

/* Enable Tasking on Objectives - False if you want objectives without tasks attached */
_EnableObjectiveTasks = true;

/* Vehicle Type for Roadblock Vehicles - Options: _Wheeled, _APC, _Tank, _AntiAir */
_RoadblockVehicleType = _APC;


/* Civilian Units for Hostage Objectives & HVT Objectives */
_CivilianUnits = ["C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];

/* Settings for Dynamic Civilian Module */
_CivilianTriggerSize = 200;
_CivilianCount = 8;
_HouseWaypoints = 15;
_RandomWaypoints = 5;
_ShouldBeAgent = false;
_ShouldPanic = false;

_Ethnicity = "middleeast";
/*
	_Ethnicity - OKS_FaceSwap - Only works if OKS_Ambience is enabled in MissionSettings.sqf & _ShouldBeAgent is false
	african
	asian
	english
	american
	middleeast
	russian
	french
 */



// DO NOT EDIT ANYTHING BELOW \\
_DynamicCivilianArray = [_CivilianTriggerSize,_CivilianCount,_HouseWaypoints,_RandomWaypoints,_ShouldBeAgent,_ShouldPanic,_Ethnicity];
_Civilian = [_CivilianUnits,_Officer,_DynamicCivilianArray];
_Configuration = [_CompoundSize,_EnableEnemyMarkers,_EnableZoneMarker,_EnableZoneTypeMarker,_RoadblockVehicleType,_EnableObjectiveTasks,_MarkerColor];
[_UnitArray,_SideMarker,_SideColor,_Vehicles,_Civilian,_ObjectiveTypes,_Configuration]
