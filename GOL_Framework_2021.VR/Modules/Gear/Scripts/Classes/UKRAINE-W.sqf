_useMineDetector = false;
_allowedNightStuff = false;

_glHE = "rhs_VOG25";
_glHEDP = "rhs_VOG25";
_glsmokeW = "rhs_GRD40_White";
_glsmokeB = "";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "rhs_GRD40_Red";
_glsmokeY = "";

_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";
_glflareW = "rhs_VG40OP_white";

_insignia = "";
_goggles = [
	"rhs_balaclava1_olive","rhs_balaclava","rhsusf_shemagh_od",
	"rhsusf_shemagh2_od","rhsusf_shemagh2_gogg_od",
	"rhsusf_shemagh_gogg_od","UK3CB_G_Gloves_Green_Shemagh_Green",
	"UK3CB_G_Gloves_Green_Shemagh_Green_Headset",
	"UK3CB_G_Tactical_Clear_Shemagh_Green_Tactical_Gloves_Green",
	"UK3CB_G_Tactical_Clear_Tactical_Gloves_Green",
	"UK3CB_G_Tactical_Gloves_Green_Shemagh_Green_Headset",
	"UK3CB_G_Tactical_Gloves_Green"
];
_helmet = ["rhssaf_helmet_m97_olive_nocamo","rhssaf_helmet_m97_olive_nocamo_black_ess","rhssaf_helmet_m97_olive_nocamo_black_ess_bare"];
_OfficerHelmet = "UK3CB_ANA_B_H_OFF_Beret_GRN";
_uniform = ["UK3CB_GAF_B_U_SF_CombatSmock_02_MULTICAM","UK3CB_GAF_B_U_SF_CombatSmock_06_MULTICAM","UK3CB_GAF_B_U_SF_CombatSmock_06_MULTICAM"];
_vest = ["UK3CB_V_MBAV_MG_OLI","UK3CB_V_MBAV_RIFLEMAN_OLI","UK3CB_V_MBAV_LIGHT_OLI","UK3CB_V_MBAV_RIFLEMAN_OLI","UK3CB_V_MBAV_GRENADIER_OLI"];
_backpack = "UK3CB_ION_B_B_RIF_OLI_01";
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = "UK3CB_ION_B_B_RadioBag_OLI";
};

if(_role in ["ag","ammg"]) then {
	_backpack = "UK3CB_GAF_B_B_ENG_OLI";
	_vest = "UK3CB_V_MBAV_MEDIC_OLI";
};
if (_role isEqualTo "p") then {
	_goggles = "";
	_helmet = ["UK3CB_TKA_O_H_zsh7a_mike_Des","UK3CB_TKA_O_H_zsh7a_mike_Des_alt"];
	_uniform = "UK3CB_GAF_B_U_SF_CombatUniform_02_MULTICAM";
	_vest = "UK3CB_V_MBAV_LIGHT_OLI";
	_backpack = "tfw_ilbe_dd_coy";
};

if(_role isEqualTo "crew") then {
	_goggles = "";
	_helmet = "rhs_tsh4";
	_uniform = "UK3CB_GAF_B_U_SF_CombatUniform_02_MULTICAM";
	_vest = "UK3CB_V_MBAV_LIGHT_OLI";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "rhs_zsh7a";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};


_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = [["rhs_weap_aks74n","rhs_weap_aks74","rhs_weap_ak74n_2","rhs_weap_ak74n","rhs_weap_ak74m_fullplum","rhs_weap_ak74m"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74un", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["rhs_weap_ak74n_2_gp25","rhs_weap_ak74n_gp25","rhs_weap_aks74_gp25","rhs_weap_aks74n_gp25","rhs_weap_ak74m_gp25","rhs_weap_ak74_gp25"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["srifle_DMR_07_blk_F", "muzzle_snds_65_TI_blk_F", _pointer, "rhsusf_acc_LEUPOLDMK4_2", ""];
_rifle_mag = selectRandom ["rhs_30Rnd_545x39_7N22_plum_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK"];
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleC_mag = selectRandom ["rhs_30Rnd_545x39_7N22_plum_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK"];
_rifleC_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleGL_mag = selectRandom ["rhs_30Rnd_545x39_7N22_plum_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK"];
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "ACE_20Rnd_65_Creedmor_mag";
_rifleL_mag_tr = "ACE_20Rnd_65_Creedmor_mag";

_LMG = ["rhs_weap_m249_pip", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_olive_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["UK3CB_USP", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_USP_9_15Rnd";

_pdw = ["SMG_05_F", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "30Rnd_9x21_Mag_SMG_02_Tracer_Red";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svds", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";