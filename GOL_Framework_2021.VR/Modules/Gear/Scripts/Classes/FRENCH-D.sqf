_useMineDetector = false;
_allowedNightStuff = true;

_goggles = "";
_helmet = selectRandom ["helmet_lwh_CCE"];
_OfficerHelmet = "cap_CCE";
_uniform = selectRandom ["Uniform_Rolled_CCE","Uniform_Full_CCE"];
_vest = selectRandom ["vest_spc_radio_CCE"];
_backpack = "CCE_Kitbag";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "CCE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "CCE_PB_Bergen";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_alt_helmet";
	_vest = "vest_spc_crewman_CCE";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p";
	_vest = "vest_spc_crewman_CCE";
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

_silencer = "";
_pointer = "rhsusf_acc_m952v";
_sight = "";
_bipod = "rhsusf_acc_harris_bipod";

_rifle = ["hlc_rifle_416D145_CAG", _silencer, _pointer, _sight, _bipod];
_rifleC = ["bg21_famas_HG", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_416D145_gl", _silencer, _pointer, _sight, _bipod];
_rifleL = ["arifle_SPAR_03_blk_F", _silencer, _pointer, "optic_erco_blk_f", _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR";
_rifle_mag_tr = "hlc_30rnd_556x45_t";
_rifleGL_mag = "hlc_30rnd_556x45_EPR";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t";
_rifleL_mag = "ACE_20Rnd_762x51_Mk319_Mod_0_Mag";
_rifleL_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";

_LMG = ["rhs_weap_m249_light_S", _silencer, _pointer, _sight, "rhsusf_acc_grip4_bipod"];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_m240B", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["hlc_pistol_Mk25", _silencer, "hlc_acc_tlr1", "hlc_optic_vtac", _bipod];
_pistol_mag = "hlc_15Rnd_9x19_B_P226";

_silencer = "";
_pointer = "";
_sight = "hlc_optic_leupoldm3a";
_bipod = "";

_rifleMarksman = ["hlc_rifle_awmagnum_BL", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_300WM_T_AWM";
_rifleMarksman_mag_tr = "";
