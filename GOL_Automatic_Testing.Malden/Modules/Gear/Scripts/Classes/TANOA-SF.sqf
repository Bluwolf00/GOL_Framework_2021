_useMineDetector = false;
_allowedNightStuff = true;

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

_insignia = "GOL_Insignia_Hellfish";
_goggles = ["UK3CB_G_Balaclava2_BLK"];
_helmet = ["UK3CB_CSAT_U_O_H_6b47_Bare_BLK"];
_OfficerHelmet = "rhssaf_beret_green";
_uniform = ["UK3CB_MEE_O_U_07"];
_vest = ["V_PlateCarrier2_blk","UK3CB_V_Carrier_Rig_CREW_BLK","UK3CB_V_Carrier_Rig_RECON_BLK","UK3CB_V_Carrier_Rig_CQB_BLK","UK3CB_V_Carrier_Rig_Compact_BLK"];
_backpack = "UK3CB_ION_B_B_ASS_BLK_01";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "FRXA_tf_rt1523g_big_Black";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_CSAT_N_O_B_ENG_BLK";
};
if (_role isEqualTo "crew") then {
	_uniform = "UK3CB_MEE_O_U_07";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_ihadss";
	_uniform = "UK3CB_MEE_O_U_07";
	_vest = "UK3CB_V_Carrier_Rig_Compact_BLK";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";
};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "rhs_acc_ak5";
_pointer = "rhs_acc_2dpZenit";
_sight = "rhs_acc_okp7_dovetail";
_bipod = "";

_rifle = [["rhs_weap_ak74m"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["rhs_weap_ak74m_gp25"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svds", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleGL_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleC_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleC_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "rhs_10Rnd_762x54mmR_7N14";
_rifleL_mag_tr = "UK3CB_SVD_10rnd_762x54_GT";

_LMG = ["rhs_weap_m249_pip_S", "", "rhs_acc_2dpZenit_ris", _sight, _bipod];
_LMG_mag = "rhsusf_200Rnd_556x45_mixed_soft_pouch";

_MMG = ["UK3CB_BAF_L110_762", "uk3cb_baf_silencer_l110", _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "";
_MAT_mag_HE = "";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["launch_B_Titan_olive_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_glock17g4", "", _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_ACOG_USMC";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["srifle_DMR_06_olive_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_M14_20rnd_762x51_RT";
_rifleMarksman_mag_tr = "UK3CB_M14_20rnd_762x51_RT";