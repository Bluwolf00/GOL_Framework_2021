_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_oakley_goggles_clr";
_helmet = ["rhsusf_ach_helmet_headset_ocp_alt","rhsusf_ach_helmet_ocp_norotos","rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_ocp_alt"];
_OfficerHelmet = "rhs_8point_marpatwd";
_uniform = "rhs_uniform_cu_ocp_1stcav";
_vest = "rhsusf_spcs_ocp";
_backpack = "rhsusf_assault_eagleaiii_ocp";
if (true) then {
	_backpackRadio = "TFAR_rt1523g_big_rhs";
};

if (_role in ["ftl","sl"]) then {
	_vest = "rhsusf_spcs_ocp_teamleader";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spcs_ocp_medic";
	_backpack = "rhsusf_assault_eagleaiii_ocp";
};
if (_role in ["ar","mmg"]) then {
	_vest = "rhsusf_spcs_ocp_machinegunner";
	_backpack = "rhsusf_assault_eagleaiii_ocp";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_alt_helmet";
	_vest = "rhsusf_spcs_ocp_crewman";
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

// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_mk18_KAC_bk", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m4a1_carryhandle", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_mk18_m320", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m27iar_grip", _silencer, _pointer, _sight, _bipod];
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

_silencer = "";
_pointer = "";
_rifleMarksman = ["UK3CB_M21_Bipod_Railed", _silencer, _pointer, "rhsusf_acc_ACOG2_USMC", ""];
_rifleMarksman_mag = "UK3CB_M14_20rnd_762x51_RT";
_rifleMarksman_mag_tr = "UK3CB_M14_20rnd_762x51_RT";
