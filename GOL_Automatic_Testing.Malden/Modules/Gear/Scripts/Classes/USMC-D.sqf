_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "";
_helmet = "rhsusf_lwh_helmet_marpatd";
_OfficerHelmet = "rhs_8point_marpatd";
_uniform = "rhs_uniform_FROG01_d";
_vest = "rhsusf_spc_rifleman";
_backpack = "B_Kitbag_tan";
if (true) then {
	_backpackRadio = "tfw_ilbe_blade_d";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spc_iar";
};
if (_role in ["ar","mmg"]) then {
	_vest = "rhsusf_spc_mg";
};
if (_role isEqualTo "crew") then {
	_vest = "rhsufs_spc_crewman";
	_helmet = "rhsusf_cvc_helmet";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_cvc_helmet";
	_vest = "rhsusf_spc_light";
};

if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "UK3CB_CW_US_B_LATE_U_J_Pilot_Uniform_01_NATO";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["JCA_arifle_M16A4_FG_black_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["JCA_arifle_M4A1_black_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["JCA_arifle_M16A4_GL_black_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["JCA_arifle_SR10_AFG_black_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleC_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "JCA_20Rnd_762x51_Red_PMAG";
_rifleL_mag_tr = "JCA_20Rnd_762x51_Tracer_Red_PMAG";

_LMG = ["rhs_weap_m249_light_L", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_m240B", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_sand_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["JCA_hgun_P226_black_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "JCA_15Rnd_9x21_P226_Red_Mag";

_pdw = ["JCA_smg_UMP_black_F", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "JCA_25Rnd_45ACP_UMP_Red_Mag";
_pdw_mag_tr = "JCA_25Rnd_45ACP_UMP_Tracer_Red_Mag";

_silencer = "";
_pointer = "";
_rifleMarksman = ["JCA_srifle_AWM_black_F", _silencer, _pointer, "JCA_optic_HPPO_black", "JCA_bipod_AWM_black"];
_rifleMarksman_mag = "JCA_5Rnd_338LM_AWM_Mag";
_rifleMarksman_mag_tr = "JCA_5Rnd_338LM_AWM_Tracer_Red_Mag";