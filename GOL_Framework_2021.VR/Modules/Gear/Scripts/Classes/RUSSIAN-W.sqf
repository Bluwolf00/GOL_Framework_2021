


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

_goggles = "rhsusf_shemagh2_grn";
_helmet = ["rhs_altyn_visordown","rhs_altyn","rhs_altyn_novisor_ess","rhs_altyn_novisor"] call BIS_fnc_selectRandom;
_uniform = "rhs_uniform_gorka_r_g";
_vest = "rhs_6b43";
_backpack = "rhs_assault_umbts";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_mr3000_rhs";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "B_Carryall_green_F";
};

if (_role isEqualTo "p") then {
	_helmet = "rhs_altyn_novisor_ess_bala";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "rhs_acc_dtk";
_pointer = "rhs_acc_perst3";
_sight = "optic_Arco_AK_blk_F";
_bipod = "rhs_acc_grip_rk2";

_rifle = ["rhs_weap_ak74m_zenitco01_b33", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_AK12U_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74m_gp25_npz", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_camo_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_green";

_LMG = ["arifle_RPK12_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["arifle_RPK12_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_75Rnd_762x39mm_tracer";

_LAT = ["launch_RPG32_green_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG32_F";
_LAT_ReUsable = true;

_MAT = ["launch_RPG32_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG32_F";

_pistol = ["rhs_weap_pya", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19_17";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
