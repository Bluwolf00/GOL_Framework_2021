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

_goggles = "";
_helmet = ["rhs_stsh81"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_pilotka";
_uniform = "rhs_uniform_afghanka_spetsodezhda";
_vest = selectRandom ["rhs_6b3_AK_3","rhs_6b3"];
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if(_role in ["ftl","sl","fac","pl"]) then {
	_vest = selectRandom ["rhs_6b3_off","rhs_6b3_R148"];
};

if(_role in ["mat"]) then {
	_backpack = "rhs_rpg_6b3";
};

if(_role isEqualTo "rhs_6b3_VOG_2") then {
	_vest = "rhs_6b3_VOG_2";
};

if(_role in ["mmg","ar"]) then {
	_vest = "rhs_6b3_RPK";
	_backpack = "rhs_rd54_vest";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_rd54_vest";
	_vest = "rhs_6b3_RPK";
};

if (_role isEqualTo "p") then {
	_helmet = "rhs_tsh4";
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

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_aks74n_2", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74n_2_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akms", "rhs_acc_dtkakm", _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_545x39_Mag_F";
_rifleGL_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleL_mag = "rhs_30Rnd_762x39mm_bakelite_tracer";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_75Rnd_762x39_t_rpk";

_MMG = ["rhs_weap_pkp", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg18_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_rpg7_PG7VM_mag";
_MAT_mag_HE = "rhs_rpg7_OG7V_mag";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhs_weap_makarov_pm", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x18_8_57N181S";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";