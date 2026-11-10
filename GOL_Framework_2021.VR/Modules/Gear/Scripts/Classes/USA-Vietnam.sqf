_useMineDetector = false;
_allowedNightStuff = false;

// Fix for NVG = "SAN_Headlamp_v1"

_insignia = "";
_goggles = [
	"G_claysack_flak","G_simc_US_flak_Bandoleer_556","G_simc_US_Bandoleer_flak_556_left"
];
_helmet = ["H_Simc_M1_jenk_sk2","H_Simc_M1C_bitch_a2","H_Simc_M1C_bitch_b1_alt","H_Simc_M1C_bitch_b2_alt","H_Simc_M1C_bitch_b6","H_Simc_M1C_bitch_low_op","H_Simc_M1C_bitch_op","H_Simc_M1_g_turis","H_Simc_MC_M1_bitch_ns","H_Simc_MC_M1_bitch_op","H_Simc_MC_M1_bitch_b4","H_Simc_MC_M1_bitch_low_ben","H_Simc_MC_M1_bitch_b","H_Simc_MC_M1C_bitch_low_rot","H_Simc_MC_M1C_bitch_b","H_Simc_MC_M1C_bitch_b6","H_Simc_MC_M1C_bitch_b9","H_Simc_MC_M1C_bitch_low_ben"];
_OfficerHelmet = "H_Simc_MC_hat_2";
_uniform = ["U_Simc_TCU_mk1_roll","U_Simc_TCU_mk2_roll","U_Simc_TCU_mk2_roll_sub","U_Simc_TCU_mk2_trop","U_Simc_TCU_mk3_poplijn_trop","U_Simc_TCU_mk1_og_trop","U_Simc_OG107_tee_MC","U_Simc_OG107_mk1_trop_MC","U_Simc_TCU_mk1_trop_mc","U_Simc_OG107_mk3_gas_trop_blench"];
_vest = [
	"V_Simc_flak_M69_alt","V_Simc_flak_M69_belt","V_Simc_flak_M69_open",
	"V_Simc_flak_M69_79","V_Simc_flak_M69_bandoleer_belt","V_Simc_flak_M69_45",
	"V_Simc_flak_M69_45_belt_band","V_Simc_flak_M69_45_belt"
];
_backpack = [
	"B_simc_pack_frem_flak_8","B_simc_pack_frem_flak_2_alt",
	"B_simc_pack_frem_flak_2","B_simc_pack_frem_flak_3_a",
	"B_simc_pack_frem_flak_3_b"
];
if (true) then {
	_backpackRadio = [
		"B_simc_rajio_flak_1","B_simc_rajio_flak_2","B_simc_rajio_flak_2_a",
		"B_simc_rajio_flak_4","B_simc_rajio_flak_base","B_simc_rajio_flak_3_alt"
	];
};

if(_role in ["sl","pl"]) then {
	_uniform = "U_Simc_OG107_mk1_blench";
};

if (_role in ["ag","ammg","lr","ab","hat","ahat"]) then {
	_backpack = "B_simc_pack_frem_flak_med3";
	_vest = "V_Simc_flak_M69_med";
};

if(_role in ["ar","mmg"]) then {
	_vest = ["V_Simc_flak_M69_60","V_Simc_flak_M69_60_belt","V_Simc_flak_M69_60_belt_ass"];
}
if (_role isEqualTo "crew") then {
	_helmet = "H_Simc_Hat_Patrol_od7_swdg";
	_uniform = "U_Simc_TCU_mk1_nomex";
	_vest = "V_Simc_flak_55_mk2";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Simc_hat_trop_cib_air";
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

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["st3_m16a1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_M16_Carbine", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["st3_m16a1_m203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_M16A1_LSW", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_M16_30rnd_556x45_R";
_rifle_mag_tr = "UK3CB_M16_30rnd_556x45_RT";
_rifleGL_mag = "UK3CB_M16_30rnd_556x45_R";
_rifleGL_mag_tr = "UK3CB_M16_30rnd_556x45_RT";
_rifleL_mag = "UK3CB_M16_30rnd_556x45_R";
_rifleL_mag_tr = "UK3CB_M16_30rnd_556x45_RT";
_rifleC_mag = "UK3CB_M16_30rnd_556x45_R";
_rifleC_mag_tr = "UK3CB_M16_30rnd_556x45_RT";

_LMG = ["UK3CB_M60", _silencer, _pointer, _sight, ""];
_LMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_MMG = ["UK3CB_M60", _silencer, _pointer, _sight, ""];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_maaws", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";
_HAT_mag_HE = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m1911a1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_7x45acp_MHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_ACOG_USMC";
_bipod = "rhsusf_acc_harris_swivel";

_rifleMarksman = ["rhs_weap_m24sws_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_762x51_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_5Rnd_762x51_m62_Mag";
