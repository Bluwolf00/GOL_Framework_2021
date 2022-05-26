_useMineDetector = false;
_allowedNightStuff = true;

_goggles = selectRandom ["Armband_Green_XL"];
_helmet = "rhsgref_helmet_pasgt_flecktarn";
_OfficerHelmet = "rhssaf_beret_green";
_uniform = SelectRandom ["UK3CB_LNM_B_U_CombatSmock_13"];
_vest = "UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI";
_backpack = "UK3CB_CHC_C_B_HIKER";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_helmet";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI";
};
if (_role isEqualTo "p") then {
	_goggles = "";
	_uniform = "UK3CB_CW_US_B_Early_U_CombatUniform_02_OLI";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI";
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

// Attachments
_silencer = "";
_pointer = "rhsusf_acc_anpeq15_bk";
_sight = "rhsusf_acc_t1_high";
_bipod = "";

// Primary Weapon
_rifle = ["arifle_AK12_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_AKS_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_AK12_GL_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svdp", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifle_mag = "hlc_30Rnd_762x39_AP_ak_Valmet";
_rifle_mag_tr = "hlc_30Rnd_762x39_t_ak_Valmet";
_rifleGL_mag = "hlc_30Rnd_762x39_AP_ak_Valmet";
_rifleGL_mag_tr = "hlc_30Rnd_762x39_t_ak_Valmet";
_rifleC_mag = "rhs_30Rnd_545x39_7N22_AK";
_rifleC_mag_tr = "hlc_30Rnd_545x39_t_ak";
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N14";
_rifleMarksman_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_100Rnd_762x54mmR_green";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["launch_NLAW_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

