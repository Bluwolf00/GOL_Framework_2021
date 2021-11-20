
_goggles = "rhsusf_shemagh_tan";
_helmet = selectRandom ["rhsusf_ach_helmet_headset_ess_ucp","rhsusf_ach_helmet_headset_ucp_alt","rhsusf_ach_helmet_ESS_ucp_alt","rhsusf_ach_helmet_ucp_norotos"];
_OfficerHelmet = "rhsusf_patrolcap_ucp";
_uniform = "rhs_uniform_cu_ucp_10th";
_vest = "rhsusf_spcs_ucp_rifleman_alt";
_backpack = "rhsusf_assault_eagleaiii_ucp";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_UCP_big_rt1523g";
};

if (_role isEqualTo "sl") then {
	_vest = "rhsusf_spcs_ucp_squadleader";
};

if(_role isEqualTo "ftl") then {
	_vest = "rhsusf_spcs_ucp_teamleader_alt";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spcs_ucp_medic";
	_backpack = "B_Carryall_cbr";
};
if (_role in ["ar","mmg"]) then {
	_vest = "rhsusf_spcs_ucp_saw";
	_backpack = "rhsusf_assault_eagleaiii_ucp";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_alt_helmet";
	_vest = "rhsusf_spcs_ucp_crewman";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p";
	_vest = "rhsusf_spcs_ocp_crewman";
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

_silencer = "rhsusf_acc_sfmb556";
_pointer = "rhsusf_acc_anpeq16a";
_sight = "optic_mrco";
_bipod = "rhsusf_acc_tdstubby_tan";

_rifle = ["rhs_weap_mk18_KAC_d", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhsusf_weap_MP7A2", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m4a1_blockII_M203_d", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_sr25_d", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_SOST_L5";
_rifle_mag_tr = "hlc_30rnd_556x45_t_L5";
_rifleGL_mag = "hlc_30rnd_556x45_SOST";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t";
_rifleC_mag = "rhsusf_mag_40Rnd_46x30_FMJ";
_rifleL_mag = "rhsusf_20Rnd_762x51_SR25_mk316_special_Mag";
_rifleL_mag_tr = "rhsusf_20Rnd_762x51_SR25_m62_Mag";


_LMG = ["LMG_03_F", _silencer, _pointer, _sight, ""];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_mk48mod1", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";

_silencer = "rhsusf_acc_m2010s_wd";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["rhs_weap_XM2010_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_300winmag_xm2010";
_rifleMarksman_mag_tr = "";
