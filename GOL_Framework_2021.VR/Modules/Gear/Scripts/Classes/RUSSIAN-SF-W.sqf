
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

_goggles = ["rhsusf_shemagh2_grn","rhsusf_shemagh_grn"] call BIS_fnc_selectRandom;
_helmet = ["rhs_beanie_green"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = "rhsgref_uniform_olive";
_vest = "rhs_6b3_holster";
_backpack = "OLIVE_Assaultpack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "OLIVE_PB_Bergen";
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

_silencer = "hlc_muzzle_545sup_ak";
_pointer = "rhs_acc_perst3";
_sight = "";
_bipod = "rhs_acc_grip_rk2";

_rifle = ["rhs_weap_asval_grip", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74m_fullplum_gp25", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_20rnd_9x39mm_SP6";
_rifleC_mag = "rhs_30Rnd_545x39_7N22_camo_AK";
_rifleC_mag_tr = "rhs_30Rnd_545x39_AK_green";
_rifleGL_mag = "rhs_30Rnd_545x39_7N22_camo_AK";
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_green";

_LMG = ["rhs_weap_pm63", "hlc_muzzle_762SUP_AK", _pointer, _sight, _bipod];
_LMG_mag = "75Rnd_762x39_Mag_Tracer_F";

_MMG = ["arifle_RPK12_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_75Rnd_762x39mm_tracer";

_LAT = ["rhs_weap_rpg26", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg26_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG32_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG32_F";

_pistol = ["rhs_weap_tt33", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_762x25_8";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
