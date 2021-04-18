
_goggles = "";
_helmet = "rhsusf_lwh_helmet_marpatd";
_uniform = "rhs_uniform_FROG01_d";
_vest = "rhsusf_spc_rifleman";
_backpack = "rhsusf_assault_eagleaiii_coy_mg";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_MARPAT_D_big_rt1523g";
};

if (_role in ["ag","ammg"]) then {
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
	_uniform = "FIR_Fighter_Pilot_USMC_Nomex5";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m4a1_blockII_bk", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhsusf_weap_MP7A2_desert", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m4a1_blockII_M203_bk", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_556x45_Stanag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "rhsusf_mag_40Rnd_46x30_AP";

_LMG = ["hlc_lmg_M249E1", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_m240B", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_LAT = ["rhs_weap_M136", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_sand_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";

_silencer = "rhsusf_acc_m2010s_d";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["rhs_weap_XM2010_d", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_300winmag_xm2010";
_rifleMarksman_mag_tr = "";
