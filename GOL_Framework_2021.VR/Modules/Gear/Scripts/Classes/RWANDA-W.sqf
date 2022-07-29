_useMineDetector = false;
_allowedNightStuff = false;

_glHE = "hlc_VOG25_AK";
_glsmokeW = "hlc_GRD_White";
_glsmokeB = "hlc_GRD_blue";
_glsmokeG = "hlc_GRD_green";
_glsmokeO = "hlc_GRD_orange";
_glsmokeP = "hlc_GRD_purple";
_glsmokeR = "hlc_GRD_Red";
_glsmokeY = "hlc_GRD_yellow";

_glflareG = "";
_glflareR = "";
_glflareW = "";


_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = "G_Balaclava_TI_blk_F";
_helmet = selectRandom ["rhsusf_opscore_fg"];
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["UK3CB_ADM_B_U_CombatUniform_01_MAR_WDL_ALT","UK3CB_ADM_B_U_CombatUniform_01_WDL_DDPM","UK3CB_ADM_B_U_CombatUniform_01_WDL","UK3CB_B_U_CombatUniform_02_WDL","UK3CB_B_U_CombatUniform_01_WDL"];
_vest = "rhssaf_vest_md98_rifleman";
_backpack = "B_Kitbag_rgr";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_green_F";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_Tank_black_F";
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

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "rhs_acc_2dpzenit";
_bipod = "";

_rifle = ["hlc_rifle_aks74", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_AKS_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_aks74_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m76", _silencer, _pointer, "rhs_acc_1p29", _bipod];
_rifle_mag = "hlc_30Rnd_545x39_EP_ak_Black";
_rifle_mag_tr = "hlc_30Rnd_545x39_t_ak_Black";
_rifleGL_mag = "hlc_30Rnd_545x39_EP_ak_Black";
_rifleGL_mag_tr = "hlc_30Rnd_545x39_t_ak_Black";
_rifleC_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleC_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "rhsgref_10Rnd_792x57_m76";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LMG = ["hlc_rifle_RPK12", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_t_rpk";

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
