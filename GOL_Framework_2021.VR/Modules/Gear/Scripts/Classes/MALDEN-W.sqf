_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["rhs_balaclava1_olive","rhs_balaclava","UK3CB_G_KLR_BLK","UK3CB_G_KR_BLK","UK3CB_G_KL_BLK"];
_helmet = ["rhsgref_helmet_pasgt_altis_lizard"];
_OfficerHelmet = "UK3CB_MDF_B_H_Off_Beret";
_uniform = [
	"rhsgref_uniform_altis_lizard"
];
_vest = [
	"UK3CB_LDF_B_V_TL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI",
	"UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI"
];
_backpack = ["UK3CB_ION_B_B_RIF_OLI_01"];
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "FRXA_tf_rt1523g_big_Ranger_Green";
};
if (_role in ["ag","ammg","sm"]) then {
	_backpack = "B_Carryall_oli";
	_vest = "UK3CB_LDF_B_V_MD_Vest_KKZ10_OLI"
};

if (_role in ["lr","ab"]) then {
	_backpack = "B_Carryall_oli";
	_vest = "UK3CB_LDF_B_V_MK_Vest_KKZ10_OLI"
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI"
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_TacVest_blk";
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

_silencer = "hlc_muzzle_17SBrake";
_pointer = "ACE_DBAL_A3_Red";
_sight = "optic_Hamr";
_bipod = "";

_rifle = [["hlc_rifle_ACR68_Carb_black","hlc_rifle_ACR68_MID_black","hlc_rifle_ACR68_aron"], _silencer, _pointer, _sight, _bipod];
_rifleC = [["hlc_rifle_ACR68_SBR_black"], _silencer, _pointer, _sight, _bipod];
_rifleGL = [["hlc_rifle_ACR68_GL_Carb_black","hlc_rifle_ACR68_GL_SBR_black","hlc_rifle_ACR68_GL_mid_black"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_ACR68_full_black", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_68x43_MFMJ_PMAG";
_rifle_mag_tr = "hlc_30rnd_68x43_Tracer_PMAG";
_rifleGL_mag = "hlc_30rnd_68x43_MFMJ_PMAG";
_rifleGL_mag_tr = "hlc_30rnd_68x43_Tracer_PMAG";
_rifleL_mag = "hlc_30rnd_68x43_MFMJ_PMAG";
_rifleL_mag_tr = "hlc_30rnd_68x43_Tracer_PMAG";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_fim92_mag";

_pistol = ["UK3CB_CZ75", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_CZ75_9_20Rnd";

_pdw = ["rhs_weap_m92", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhssaf_30Rnd_762x39_M82_api";
_pdw_mag_tr = "rhssaf_30Rnd_762x39_M82_api";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
