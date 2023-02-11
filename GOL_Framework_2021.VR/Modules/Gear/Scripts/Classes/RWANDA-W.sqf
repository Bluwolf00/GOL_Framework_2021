
_useMineDetector = true;
_allowedNightStuff = true;

_glHE = "rhs_VOG25P";
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
_goggles = selectRandom ["rhsusf_shemagh_grn","rhsusf_shemagh2_grn","rhsusf_shemagh_gogg_grn","rhsusf_shemagh2_gogg_grn"];
_helmet = selectRandom ["rhsusf_opscore_mar_fg","rhsusf_opscore_mar_fg_pelt"];
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["rhssaf_uniform_m10_digital_summer"];
_vest = selectRandom ["UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI","UK3CB_LDF_B_V_Vest_KKZ10_OLI"];
_backpack = "UK3CB_UN_B_B_ASS";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfw_ilbe_dd_gr";
};
if(_role in ["ar","mmg"]) then {
	_vest = "UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Kitbag_rgr";
	_vest = "UK3CB_LDF_B_V_MD_Vest_KKZ10_OLI";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_Tank_black_F";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI"
};
if (_role isEqualTo "p") then {
	_helmet = "H_Tank_black_F";
	_uniform = "U_B_PilotCoveralls";
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

_silencer = "rhs_acc_dtkakm";
_pointer = "rhs_acc_2dpzenit";
_sight = "";
_bipod = "";

_rifle = [selectRandom["rhs_weap_pm63","rhs_weap_akm","rhs_weap_akms"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleGL = [selectRandom["rhs_weap_akm_gp25","rhs_weap_akms_gp25"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svdp", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifle_mag = "hlc_30Rnd_762x39_AP_ak";
_rifle_mag_tr = "hlc_30Rnd_762x39_t_ak";
_rifleGL_mag = "hlc_30Rnd_762x39_AP_ak";
_rifleGL_mag_tr = "hlc_30Rnd_762x39_t_ak";
_rifleC_mag = "hlc_30Rnd_762x39_AP_ak";
_rifleC_mag_tr = "hlc_30Rnd_762x39_t_ak";
_rifleL_mag = "rhs_10Rnd_762x54mmR_7N14";
_rifleL_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_RPK_75rnd_762x39_RM";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";
_MAT_mag_HE = "";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hlc_pistol_P226R_357Combat", _silencer, "acc_flashlight_pistol", "hlc_optic_hp", _bipod];
_pistol_mag = "hlc_12Rnd_357SIG_JHP_P226";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_sight = "rhs_acc_pso1m21";

_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
