_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_shemagh_tan";
_helmet = selectRandom ["rhsusf_ach_helmet_headset_ess_ucp","rhsusf_ach_helmet_headset_ucp_alt","rhsusf_ach_helmet_ESS_ucp_alt","rhsusf_ach_helmet_ucp_norotos"];
_OfficerHelmet = "rhsusf_patrolcap_ucp";
_uniform = "rhs_uniform_cu_ucp_10th";
_vest = "rhsusf_spcs_ucp_rifleman_alt";
_backpack = "UK3CB_B_Alice_K";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_B_Alice_Radio_Backpack";
};

if (_role isEqualTo "sl") then {
	_vest = "rhsusf_spcs_ucp_squadleader";
};

if(_role isEqualTo "ftl") then {
	_vest = "rhsusf_spcs_ucp_teamleader_alt";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spcs_ucp_medic";
};
if (_role in ["ar","mmg"]) then {
	_vest = "rhsusf_spcs_ucp_saw";
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
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "rhsusf_acc_eotech_xps3";
_bipod = "rhsusf_acc_tdstubby_tan";

_rifle = ["rhs_weap_mk18_KAC_bk", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m4a1_carryhandle", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m4a1_blockII_M203_bk", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_sr25_ec", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleC_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
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

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "rhsusf_acc_m2010s_wd";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["rhs_weap_XM2010_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_300winmag_xm2010";
_rifleMarksman_mag_tr = "";
