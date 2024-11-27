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
_goggles = "";
_helmet = ["H_Simc_nasi","H_Simc_jaza_pith_netz","H_Simc_jaza_pith","H_Simc_jaza_pith_up"];
_OfficerHelmet = "rhs_pilotka";
_uniform = [
	"U_Simc_vc_black_1","U_Simc_vc_black_1_trop","U_Simc_vc_black_2",
	"U_Simc_vc_black_2_trop","U_Simc_vc_blau_1","U_Simc_vc_blau_1_trop",
	"U_Simc_vc_blau_2","U_Simc_vc_blau_2_trop","U_Simc_vc_grun_1","U_Simc_vc_grun_1_trop",
	"U_Simc_vc_grun_2","U_Simc_vc_grun_2_trop"
];
_vest = [
	"rhsgref_chicom","UK3CB_V_SOV_CHICOM_TAN_GRN","V_Simc_mk56",
	"V_Simc_mk56_alt","V_Simc_mk56_sks","V_Simc_mk56_sks_alt",
	"rhs_suspender_AK8_chestrig","rhs_suspender_ak","rhs_suspender_ak4",
	"rhs_suspender_SKS"
];

// NVA 
// Uniform "UK3CB_CW_SOV_O_Late_U_CombatUniform_02_KHK", Helmet ["H_Simc_jaza_pith_up","H_Simc_jaza_pith"]
_backpack = "UK3CB_B_Invisible";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "rhs_r148";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_B_Invisible";
};

if (_role isEqualTo "p") then {
	_helmet = "rhs_zsh7a_mike_green";
	_uniform = "rhs_uniform_df15_tan";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_helmet = "rhs_zsh7a";
	_uniform = "rhs_uniform_df15_tan";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["uk3cb_ak47", _silencer, _pointer, _sight, _bipod];
_rifleC = ["uk3cb_ppsh41", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["uk3cb_mat49m", _silencer, _pointer, _sight, _bipod];
_rifleL = [["uk3cb_sks_01","uk3cb_sks_01_sling","uk3cb_sks_02"], _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_762x39mm_polymer";
_rifle_mag_tr = "rhs_30Rnd_762x39mm_polymer_tracer";
_rifleGL_mag = "UK3CB_MAT49_35Rnd_762x25_Magazine_G";
_rifleGL_mag_tr = "UK3CB_MAT49_35Rnd_762x25_Magazine_GT";
_rifleC_mag = "uk3cb_PPSH_35rnd_magazine_G";
_rifleC_mag_tr = "uk3cb_PPSH_35rnd_magazine_GT";
_rifleL_mag = "uk3cb_10rnd_magazine_sks_G";
_rifleL_mag_tr = "uk3cb_10rnd_magazine_sks_GT";

_LMG = ["rhs_weap_rpk74m", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_RPK74_60rnd_545x39_GT";

_MMG = ["UK3CB_RPD", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_RPD_100rnd_762x39_GT";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg7_PG7V_mag";
_LAT_ReUsable = true;

_HAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_rpg7_PG7V_mag";

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_rpg7_PG7V_mag";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhs_weap_makarov_pm", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x18_8_57N181S";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["UK3CB_SVD_OLD", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_SVD_10rnd_762x54_G";
_rifleMarksman_mag_tr = "UK3CB_SVD_10rnd_762x54_GT";