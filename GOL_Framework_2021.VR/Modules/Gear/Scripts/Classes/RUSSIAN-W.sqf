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
_helmet = ["rhs_6b27m_digi"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_ushanka";
_uniform = "rhs_uniform_emr_patchless";
_vest = selectRandom ["rhs_6b23_digi_rifleman","rhs_6b23_digi_sniper","rhs_6b23_digi_engineer"];
_backpack = "rhs_rd54_emr1";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_olive_big_rt1523g";
};
if (_role in ["lr","ab"]) then {
	_vest = "rhs_6b23_digi_vydra_3m";
};
if(_role in ["ag","ammg"]) then {
	_vest = "rhs_6b23_digi_medic";
	_backpack = "rhs_tortila_olive";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_altyn_novisor_ess_bala";
	_vest = "rhs_6b23_digi_crew";
};
if(_role isEqualTo "crew") then {
	_vest = "rhs_6b23_digi_crew";
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


_silencer = "rhs_acc_dtk2";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_ak74m", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74m_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_aek971_mtk", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "hlc_60Rnd_545x39_t_rpk";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg26", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
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