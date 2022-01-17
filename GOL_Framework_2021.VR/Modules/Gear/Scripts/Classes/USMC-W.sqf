_useMineDetector = false;
_allowedNightStuff = true;

_goggles = "rhs_googles_clear";
_helmet = selectRandom ["rhsusf_lwh_helmet_marpatwd_ess","rhsusf_lwh_helmet_marpatwd"];
_OfficerHelmet = "rhs_8point_marpatwd";
_uniform = "rhs_uniform_FROG01_wd";
_vest = "rhsusf_spc_light";
_backpack = "rhsusf_falconii_coy_gr";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_MARPAT_WD_big_rt1523g";
};

if (_role in ["ftl","sl"]) then {
	_vest = "rhsusf_spc_teamleader";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_vest = "rhsusf_spc_corpsman";
	_backpack = "rhsusf_assault_eagleaiii_coy_medic";
};
if (_role in ["ar","mmg"]) then {
	_vest = "rhsusf_spc_mg";
	_backpack = "rhsusf_assault_eagleaiii_coy_mg";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_helmet";
	_vest = "rhsusf_spc_crewman";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p";
	_vest = "rhsusf_spc_crewman";
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
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m4a1_blockII_bk", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhsusf_weap_MP7A2", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m4a1_blockII_M203_bk", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m4a1_blockII_bk", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_556x45_Stanag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "30Rnd_556x45_Stanag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "rhsusf_mag_40Rnd_46x30_FMJ";

_LMG = ["rhs_weap_m249_light_S", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

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

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";

_silencer = "";
_pointer = "";
_rifleMarksman = ["rhs_weap_sr25", _silencer, _pointer, "optic_dms", "bipod_01_f_blk"];
_rifleMarksman_mag = "rhsusf_20Rnd_762x51_SR25_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_20Rnd_762x51_SR25_m62_Mag";