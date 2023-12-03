//	[Side] Call OKS_Dynamic_Settings;
//
//	Settings for OKS Dynamic.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_Units","_SideMarker","_SideColor","_Vehicles","_Wheeled","_APC","_Tank","_Artillery","_Supply","_Transport","_Civilian","_Officer","_Settings","_AntiAir","_EnableEnemyMarkers","_RoadblockVehicleType","_UnitArray","_MarkerColor"];

/* Faction Selection for Vehicles spawned by OKS_Dynamic

	* = Not updated with 3CB thus broken <<< Important!

BLUFOR FACTIONS:       CDF* LDF TANOA*
OPFOR FACTIONS:        CHEDAKI TKA TURKEY* DESERT_INSURGENTS RUSSIA_MODERN SOVIET DESERT_MILITIA COMMUNIST_REBELS ARDISTAN
INDEPENDENT FACTIONS:  NAPA* SYRIA*

*/
Private _Faction = "CHEDAKI";
Switch (_Faction) do {
	case "SYNDIKAT": {
		// Syndikat/Livonian Seperatist Militia 3CB - OPFOR
		_Wheeled = ["I_C_Offroad_02_unarmed_F", "I_C_Offroad_02_LMG_F", "I_C_Offroad_02_AT_F",  "UK3CB_LSM_I_BTR40_MG", "UK3CB_LSM_I_BTR40", "UK3CB_LSM_I_Datsun_Pkm", "UK3CB_LSM_I_Hilux_M2", "UK3CB_LSM_I_Hilux_Open", "UK3CB_LSM_I_Pickup"];
		_APC = ["UK3CB_LSM_I_BRDM2", "UK3CB_LSM_I_BTR60", "UK3CB_LSM_I_MTLB_PKT", "UK3CB_LSM_I_BRM1K"];
		_Tank = ["UK3CB_LSM_I_T72A", "UK3CB_LSM_I_T55"];
		_Artillery = ["UK3CB_LSM_I_BM21","UK3CB_LSM_I_2b14_82mm","UK3CB_LSM_I_D30"];
		_AntiAir = ["UK3CB_LSM_I_Gaz66_ZU23", "UK3CB_LSM_I_Ural_Zu23","UK3CB_LSM_I_ZU23"];
		_Helicopter = ["UK3CB_I_G_UH1H_FIA", "UK3CB_I_G_UH1H_M240_FIA"];
		_Transport = ["UK3CB_LSM_I_BTR40", "UK3CB_LSM_I_Kraz255_Open", "UK3CB_LSM_I_Ural_Open","I_C_Van_02_transport_F", "I_C_Van_01_transport_F"];
		_Supply = ["UK3CB_LSM_I_Gaz66_Med", "UK3CB_LSM_I_Gaz66_Ammo", "UK3CB_LSM_I_Gaz66_Radio", "UK3CB_LSM_I_Gaz66_Repair"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];	
	};
	case "COMMUNIST_REBELS":{
		// Rebel Communist 3CB - OPFOR
		_Wheeled = ["UK3CB_CCM_O_Datsun_Civ_Open", "UK3CB_CCM_O_Datsun_Pkm", "UK3CB_CCM_O_Hilux_Dshkm", "UK3CB_CCM_O_Hilux_Pkm", "UK3CB_CCM_O_LR_M2", "UK3CB_CCM_O_LR_Closed", "UK3CB_CCM_O_LR_Open", "UK3CB_CCM_O_UAZ_Closed", "UK3CB_CCM_O_UAZ_Dshkm", "UK3CB_CCM_O_Ural_Open", "UK3CB_CCM_O_Kamaz_Covered", "UK3CB_CCM_O_Hilux_Civ_Open"];
		_APC = ["UK3CB_KDF_O_BTR40_MG", "UK3CB_KDF_O_BTR60", "UK3CB_KDF_O_BTR70", "UK3CB_KDF_O_BTR80", "UK3CB_KDF_O_BTR80a", "UK3CB_KDF_O_MTLB_PKT", "UK3CB_KDF_O_BMD1K", "UK3CB_KDF_O_BMD2", "UK3CB_KDF_O_BRM1K"];
		_Tank = ["LOP_NK_T34","UK3CB_KDF_O_T55"];
		_Artillery = ["UK3CB_KDF_O_2S1", "rhs_D30_msv", "UK3CB_CW_SOV_O_LATE_2S3"];
		_AntiAir = ["UK3CB_KDF_O_Gaz66_ZU23", "UK3CB_KDF_O_Ural_Zu23", "UK3CB_KDF_O_ZsuTank"];
		_Helicopter = ["UK3CB_KDF_O_Mi8AMTSh","UK3CB_KDF_O_Mi8"];
		_Transport = ["UK3CB_CCM_O_LR_Closed", "UK3CB_CCM_O_Ural_Open", "UK3CB_CCM_O_Kamaz_Covered"];
		_Supply = ["UK3CB_KDF_O_Ural_Recovery", "UK3CB_KDF_O_Ural_Repair", "UK3CB_KDF_O_Ural_Ammo", "UK3CB_KDF_O_Ural_Fuel", "UK3CB_KDF_O_Gaz66_Med", "UK3CB_KDF_O_Gaz66_Ammo"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "ARDISTAN":{
		// African Desert Militia 3CB - OPFOR
		_Wheeled = ["UK3CB_ARD_O_GAZ_Vodnik_Cannon", "UK3CB_ARD_O_GAZ_Vodnik_KVPT", "UK3CB_ARD_O_BRDM2", "UK3CB_ARD_O_GAZ_Vodnik_PKT", "UK3CB_ARD_O_Hilux_M2", "UK3CB_ARD_O_Hilux_Dshkm", "UK3CB_ARD_O_Hilux_Spg9", "UK3CB_ARD_O_Hilux_Zu23_Front"];
		_APC = ["UK3CB_ARD_O_BMP1", "UK3CB_ARD_O_BMP2", "UK3CB_ARD_O_BRM1K", "UK3CB_ARD_O_BTR80a", "UK3CB_ARD_O_MTLB_Cannon", "UK3CB_ARD_O_MTLB_BMP"];
		_Tank = ["UK3CB_ARD_O_T55", "UK3CB_ARD_O_T72A", "UK3CB_ARD_O_T72B", "UK3CB_ARD_O_T72BM"];
		_Artillery = ["UK3CB_ARD_O_D30", "UK3CB_ARD_O_BM21"];
		_AntiAir = ["UK3CB_ADM_O_V3S_Zu23", "UK3CB_ADM_O_MTLB_ZU23","UK3CB_ADM_O_ZU23"];
		_Helicopter = ["UK3CB_ARD_O_Mi_24P","UK3CB_ARD_O_Mi8AMTSh"];
		_Transport = ["UK3CB_ARD_O_UAZ_Open", "UK3CB_ARD_O_Ural", "UK3CB_ARD_O_Hilux_Open","UK3CB_ARD_O_GAZ_Vodnik"];
		_Supply = ["UK3CB_ARD_O_Ural_Ammo", "UK3CB_ARD_O_Ural_Repair", "UK3CB_ARD_O_Ural_Fuel"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};	
	case "DESERT_MILITIA":{
		// African Desert Militia 3CB - OPFOR
		_Wheeled = ["UK3CB_ADM_O_BTR40_MG", "UK3CB_ADM_O_BTR40", "UK3CB_ADM_O_Hilux_Dshkm", "UK3CB_ADM_O_Hilux_Open", "UK3CB_ADM_O_LR_Open", "UK3CB_ADM_O_LR_Closed", "UK3CB_ADM_O_Offroad_M2", "UK3CB_ADM_O_Pickup_DSHKM", "UK3CB_ADM_O_Pickup", "UK3CB_ADM_O_Datsun_Pkm"];
		_APC = ["UK3CB_ADM_O_BTR40_MG", "UK3CB_ADM_O_MTLB_PKT", "UK3CB_ADM_O_BRDM2", "UK3CB_ADM_O_BRDM2_HQ"];
		_Tank = ["UK3CB_ADE_O_T34"];
		_Artillery = ["UK3CB_ADM_O_D30","UK3CB_ADM_O_2b14_82mm"];
		_AntiAir = ["UK3CB_ADM_O_V3S_Zu23", "UK3CB_ADM_O_MTLB_ZU23","UK3CB_ADM_O_ZU23"];
		_Helicopter = ["UK3CB_ADA_O_UH1H_M240", "UK3CB_ADA_O_UH1H_GUNSHIP"];
		_Transport = ["UK3CB_ADM_O_V3S_Closed", "UK3CB_ADM_O_V3S_Open", "UK3CB_ADM_O_Van_Transport"];
		_Supply = ["UK3CB_ADM_O_V3S_Refuel", "UK3CB_ADM_O_V3S_Reammo", "UK3CB_ADM_O_V3S_Repair", "UK3CB_ADM_O_Van_Fuel"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};

	case "DESERT_INSURGENTS":
	{
		// Middle Eastern Insurgents 3CB - OPFOR
		_Wheeled = ["UK3CB_ADE_O_BTR40", "UK3CB_ADE_O_Hilux_Pkm", "UK3CB_ADE_O_V3S_Closed", "UK3CB_ADE_O_Datsun_Pkm", "UK3CB_ADE_O_Datsun_Open", "UK3CB_ADE_O_Hilux_Dshkm", "UK3CB_ADE_O_Offroad_M2", "UK3CB_ADE_O_Hilux_M2", "UK3CB_ADE_O_LR_M2"];
		_APC = ["UK3CB_ADE_O_BTR40_MG", "UK3CB_ADE_O_MTLB_PKT", "UK3CB_ADE_O_BRDM2"];
		_Tank = ["UK3CB_ADE_O_T34"];
		_Artillery = ["UK3CB_ADE_O_Hilux_Mortar", "UK3CB_ADE_O_D30", "UK3CB_ADE_O_2b14_82mm"];
		_AntiAir = ["UK3CB_ADE_O_V3S_Zu23", "UK3CB_ADE_O_ZU23"];
		_Helicopter = ["UK3CB_ARD_O_Mi8"];
		_Transport = ["UK3CB_ADE_O_V3S_Closed"];
		_Supply = ["UK3CB_ADE_O_V3S_Reammo", "UK3CB_ADE_O_V3S_Refuel", "UK3CB_ADE_O_V3S_Repair", "UK3CB_ADE_O_Van_Fuel"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};	

	case "SOVIET":{
		// Modern Russian Armed Forces (RUSSIA) 3CB RHS - OPFOR
		_Wheeled = ["rhs_tigr_msv","rhs_tigr_m_msv","RHS_UAZ_MSV_01","rhs_gaz66_msv","rhs_kamaz5350_msv"];
		_APC = ["rhs_btr60_msv","rhs_btr70_msv","rhs_bmp1_msv","rhs_bmp2e_msv"];
		_Tank = ["rhs_t72ba_tv","UK3CB_CW_SOV_O_LATE_T55"];
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

	case "SYRIA":{
		// Modern Russian Armed Forces (RUSSIA) - OPFOR
		_Wheeled = ["LOP_SYR_UAZ_DshKM","LOP_SYR_UAZ","LOP_SYR_UAZ_Open","UK3CB_ADA_O_Datsun_Pickup_PKM", "UK3CB_ADA_O_Datsun_Pickup", "UK3CB_ADA_O_V3S_Closed", "UK3CB_ADA_O_Pickup", "UK3CB_ADA_O_Pickup_DSHKM", "UK3CB_ADA_O_Van_Transport", "UK3CB_ADA_O_LR_SF_M2", "UK3CB_ADA_O_LR_SPG9","UK3CB_ADA_O_BTR40"];
		_APC = ["LOP_SYR_BTR60","LOP_SYR_BTR70", "UK3CB_ADA_O_BTR40_MG", "UK3CB_ADA_O_MTLB_PKT"];
		_Tank = ["LOP_SYR_T55"];
		_Artillery = ["LOP_SYR_2S1","rhs_D30_vmf","UK3CB_ADA_O_Hilux_Rocket_Arty", "UK3CB_ADA_O_BM21"];
		_AntiAir = ["UK3CB_ADA_O_V3S_Zu23","UK3CB_ADA_O_ZsuTank","UK3CB_ADA_O_Hilux_Zu23"];
		_Helicopter = ["RHS_Mi24P_vdv","RHS_Mi8MTV3_vdv"];
		_Transport = ["LOP_SYR_UAZ_Open","UK3CB_ADA_O_Datsun_Pickup", "UK3CB_ADA_O_V3S_Closed", "UK3CB_ADA_O_BTR40"];
		_Supply = ["UK3CB_ADA_O_V3S_Reammo", "UK3CB_ADA_O_V3S_Refuel", "UK3CB_ADA_O_V3S_Recovery", "UK3CB_ADA_O_V3S_Repair", "UK3CB_ADA_O_Van_Fuel", "UK3CB_ADA_O_Ural_Recovery"];
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
		_Wheeled = ["rhsgref_ins_uaz_dshkm","rhsgref_ins_uaz_spg9","UK3CB_CHD_W_O_MTLB_KPVT", "UK3CB_CHD_W_O_MTLB_PKT", "UK3CB_CHD_W_O_BRDM2", "UK3CB_CHD_W_O_LR_Open", "UK3CB_CHD_W_O_LR_Closed", "UK3CB_CHD_W_O_Zil131_Covered", "UK3CB_CHD_W_O_Gaz66_Covered"];
		_APC = ["UK3CB_CHD_W_O_MTLB_BMP", "UK3CB_CHD_W_O_MTLB_KPVT", "UK3CB_CHD_W_O_MTLB_Cannon", "UK3CB_CHD_W_O_BRM1K", "UK3CB_CHD_W_O_BMP1", "UK3CB_CHD_W_O_BMD1PK", "UK3CB_CHD_W_O_BMD2"];
		_Tank = ["rhsgref_ins_t72ba", "UK3CB_CHD_W_O_T34", "UK3CB_CHD_W_O_T55"];
		_Artillery = ["rhsgref_ins_d30","rhsgref_ins_2b14","rhsgref_ins_2s1","rhsgref_ins_BM21"];
		_AntiAir = ["UK3CB_CHD_O_Ural_Zu23", "UK3CB_CHD_O_Gaz66_ZU23", "UK3CB_CHD_O_MTLB_ZU23","rhsgref_ins_ZU23"];
		_Helicopter = ["UK3CB_CHD_W_O_Mi8", "UK3CB_CHD_W_O_Mi8AMT", "UK3CB_CHD_W_O_Mi8AMTSh"];
		_Transport = ["UK3CB_CHD_W_O_Kamaz_Covered"];
		_Supply = ["UK3CB_CHD_W_O_Ural_Ammo", "UK3CB_CHD_W_O_Ural_Repair", "UK3CB_CHD_W_O_Ural_Fuel"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	case "TKA":
	{
		// Takistani Army - OPFOR
		_Wheeled = ["UK3CB_TKA_O_BTR40_MG", "UK3CB_TKA_O_BTR40", "UK3CB_TKA_O_M113_M2", "UK3CB_TKA_O_BRDM2", "UK3CB_TKA_O_GAZ_Vodnik_Cannon", "UK3CB_TKA_O_GAZ_Vodnik_KVPT", "UK3CB_TKA_O_GAZ_Vodnik_PKT", "UK3CB_TKA_O_GAZ_Vodnik", "UK3CB_TKA_O_Hilux_Closed", "UK3CB_TKA_O_Hilux_M2", "UK3CB_TKA_O_Hilux_Dshkm", "UK3CB_TKA_O_Hilux_Open", "UK3CB_TKA_O_Hilux_Pkm", "UK3CB_TKA_O_Hilux_Spg9", "UK3CB_TKA_O_Hilux_Zu23_Front", "UK3CB_TKA_O_Ural_Open", "UK3CB_TKA_O_Ural", "UK3CB_TKA_O_UAZ_SPG9", "UK3CB_TKA_O_UAZ_MG"];
		_APC = ["UK3CB_TKA_O_BMP1", "UK3CB_TKA_O_BMP2", "UK3CB_TKA_O_BTR70", "UK3CB_TKA_O_BTR80a"];
		_Tank = ["UK3CB_TKA_O_T34", "UK3CB_TKA_O_T55"];
		_Artillery = ["UK3CB_TKA_O_BM21", "UK3CB_TKA_O_D30", "UK3CB_TKA_O_2b14_82mm"];
		_AntiAir = ["UK3CB_TKA_O_Ural_Zu23", "UK3CB_TKA_O_ZsuTank", "UK3CB_TKA_O_ZU23"];
		_Helicopter = ["UK3CB_TKA_O_Bell412_Armed", "UK3CB_TKA_O_UH1H_M240", "UK3CB_TKA_O_UH1H_GUNSHIP"];
		_Transport = ["UK3CB_TKA_O_BTR40"];
		_Supply = ["UK3CB_TKA_O_Ural_Fuel", "UK3CB_TKA_O_Ural_Ammo", "UK3CB_TKA_O_Ural_Repair"];
		_Vehicles = [_Wheeled,_APC,_Tank,_Artillery,_Helicopter,_Transport,_Supply,_AntiAir];
	};
	
	case "LDF": {
		// Livonia Defence Force - 1980s
		_Wheeled = ["UK3CB_LDF_B_M1025_M2", "UK3CB_LDF_B_M1151_GPK_M2", "UK3CB_LDF_B_M1151_GPK_PKM", "UK3CB_LDF_B_M1151_OGPK_M2", "UK3CB_LDF_B_Offroad_M2", "UK3CB_LDF_B_Offroad_AT", "UK3CB_LDF_B_Pickup_SPG9"];
		_APC = ["UK3CB_LDF_B_BRDM2", "UK3CB_LDF_B_BMP1", "UK3CB_LDF_B_BMP2", "UK3CB_LDF_B_Marshall", "UK3CB_LDF_B_MTLB_Cannon", "UK3CB_LDF_B_MTLB_BMP"];
		_Tank = ["UK3CB_LDF_B_T72A", "UK3CB_LDF_B_T72BB"];
		_Artillery = ["UK3CB_LDF_B_RM70", "UK3CB_LDF_B_T810_MLRS", "UK3CB_LDF_B_2S1"];
		_AntiAir = ["rhsgref_cdf_b_ZU23","UK3CB_LDF_B_MTLB_ZU23", "UK3CB_LDF_B_T810_ZU23", "UK3CB_LDF_B_ZsuTank"];
		_Helicopter = ["rhs_uh1h_hidf"];
		_Transport = ["UK3CB_LDF_B_T810_Open", "UK3CB_LDF_B_T810_Closed", "UK3CB_LDF_B_T810_Closed_PKM", "UK3CB_LDF_B_T810_Open_PKM"];
		_Supply = ["UK3CB_LDF_B_T810_Repair", "UK3CB_LDF_B_T810_Refuel", "UK3CB_LDF_B_T810_Reammo"];
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
			"B_Soldier_LAT_F",
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F",
			"B_Soldier_F",
			"B_Soldier_F",
			"B_Soldier_F"
			
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
			"O_Soldier_LAT_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F",
			"O_Soldier_F",
			"O_Soldier_F",
			"O_Soldier_F"
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
			"I_Soldier_LAT_F",
			"I_Soldier_AR_F",
			"I_medic_F",
			"I_Soldier_GL_F",
			"I_soldier_M_F",
			"I_Soldier_F",
			"I_Soldier_F",
			"I_Soldier_F"		
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

/* If tasks should show have pop-ups when completed */
_TaskNotification = false;

/* CompoundSize defines in meters how large a compound is conisdered in this mission. Garrisons will spread out at this distance*/
_CompoundSize = 25;

/* Standard Patrol size */
_PatrolSize = 4;

/* EnableEnemyMarkers will place markers at enemy strongpoints, compounds, roadblocks & mortar pits populated by Static Targets */
_EnableEnemyMarkers = false;

/* Mark Trigger Area with Zone Marker*/
_EnableZoneMarker = false;

/* Mark Trigger Area with Zone Type Marker */
_EnableZoneTypeMarker = false;

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
_Configuration = [_CompoundSize,_EnableEnemyMarkers,_EnableZoneMarker,_EnableZoneTypeMarker,_RoadblockVehicleType,_EnableObjectiveTasks,_MarkerColor,_PatrolSize,_TaskNotification];
[_UnitArray,_SideMarker,_SideColor,_Vehicles,_Civilian,_ObjectiveTypes,_Configuration]
