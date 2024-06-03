_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_shemagh_tan";
_helmet = ["rhsusf_ach_helmet_headset_ess_ucp","rhsusf_ach_helmet_headset_ucp_alt","rhsusf_ach_helmet_ESS_ucp_alt","rhsusf_ach_helmet_ucp_norotos"];
_OfficerHelmet = "rhsusf_patrolcap_ucp";
_uniform = "rhs_uniform_cu_ucp_10th";
_vest = "rhsusf_spcs_ucp_rifleman_alt";
_backpack = "B_Kitbag_cbr";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfw_ilbe_blade_coy";
};

if (_role isEqualTo "sl") then {
	_vest = "rhsusf_spcs_ucp_squadleader";
};

if(_role isEqualTo "ftl") then {
	_vest = "rhsusf_spcs_ucp_teamleader_alt";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spcs_ucp_medic";
	_backpack = "UK3CB_KRG_B_B_FieldPack_SF_MED";
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

_rifle = ["JCA_arifle_M4A4_VFG_sand_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["JCA_arifle_M4A4_AFG_sand_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["JCA_arifle_M4A4_GL_sand_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m16a4_imod", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleC_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";


_LMG = ["rhs_weap_m249_light_S", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["UK3CB_BAF_L110_762", _silencer, _pointer, _sight, ""];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
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
