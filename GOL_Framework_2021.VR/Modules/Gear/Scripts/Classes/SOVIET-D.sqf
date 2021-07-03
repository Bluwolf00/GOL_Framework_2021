

_glHE = "hlc_VOG25_AK";
_glsmokeW = "hlc_GRD_White";
_glsmokeB = "";
_glsmokeG = "hlc_GRD_green";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "hlc_GRD_Red";
_glsmokeY = "";

_glflareG = "";
_glflareR = "";

_goggles = "";
_helmet = ["rhs_ssh60"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = "rhs_uniform_afghanka_para";
_vest = "rhsgref_6b23_khaki";
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "Coyote_big_rt1523g";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_rd54";
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
	_vest = "rhsgref_6b23_khaki_medic";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "rhs_acc_okp7_dovetail";
_bipod = "";

_rifle = ["hlc_rifle_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_akmgl", _silencer, _pointer, _sight, _bipod];
_rifleC_mag = "30Rnd_545x39_Mag_F";
_rifleC_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifle_mag = "30Rnd_762x39_Mag_F";
_rifle_mag_tr = "30Rnd_762x39_Mag_Tracer_F";

_LMG = ["rhs_weap_pm63", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg18_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_pistol = ["rhs_weap_makarov_pm", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x18_8_57N181S";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
