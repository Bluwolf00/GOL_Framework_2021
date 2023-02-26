_useMineDetector = false;
_allowedNightStuff = false;

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
_goggles = "";
_helmet = ["UK3CB_TKM_I_H_Turban_03_1","","UK3CB_TKM_I_H_Turban_04_1","UK3CB_TKM_I_H_Turban_05_1","UK3CB_TKM_I_H_Turban_01_1","UK3CB_TKM_I_H_Turban_02_1","UK3CB_H_Shemag_red_02","H_ShemagOpen_khk"];
_OfficerHelmet = "UK3CB_TKP_B_H_Patrolcap_TAN";
_uniform = ["UK3CB_TKM_B_U_04","UK3CB_TKM_B_U_01","UK3CB_TKM_B_U_03","UK3CB_TKM_I_U_01","UK3CB_TKM_I_U_01_B","UK3CB_TKM_I_U_01_C","UK3CB_TKM_I_U_03","UK3CB_TKM_I_U_03_B","UK3CB_TKM_I_U_03_C","UK3CB_TKM_I_U_04","UK3CB_TKM_I_U_04_C","UK3CB_TKM_I_U_05_B","UK3CB_TKM_I_U_06","UK3CB_TKM_I_U_06_C"];
_vest = ["rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2","UK3CB_TKA_I_V_6Sh92_Des","UK3CB_V_CW_Chestrig_2_Small","rhs_belt_RPK","UK3CB_V_Belt_Rig_KHK"];
_backpack = "UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};


if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_rd54";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "UK3CB_CHC_C_U_Overall_03";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_aks74", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_aks74_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_545x39_Mag_F";
_rifleGL_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleL_mag = "rhs_30Rnd_762x39mm_bakelite_tracer";

_LMG = ["hlc_rifle_rpk74n", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_t_rpk";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
