
_goggles = "";
_helmet = "helmet_lwh_M90";
_OfficerHelmet = "beret_Green";
_uniform = SelectRandom ["Uniform_Full_M90","Uniform_Rolled_M90"];
_vest = "vest_spc_radio_M90";
_backpack = "M90_Assaultpack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_M90_big_rt1523g";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "SWEDISH_assaultpack_Medic";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "M90_Kitbag_MachineGunner";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "helmet_lwh_M90_3";
};
if (_role isEqualTo "crew") then {
	_helmet = "helmet_lwh_M90_3";
	_vest = "vest_spc_crewman_M90";
	_uniform = "Uniform_Coveralls_M90";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_M90";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "vest_spc_crewman_M90";
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
_silencer = "rhsusf_acc_sfmb556";
_pointer = "";
_sight = "optic_erco_blk_f";
_bipod = "rhsusf_acc_grip3";

// Primary Weapon
_rifle = ["hlc_rifle_SG551SB_TAC", _silencer, _pointer, _sight, _bipod];
_rifleC = ["SMG_05_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_SG551SB_TAC_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3a3ris", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["hlc_rifle_g3a3", _silencer, _pointer, "hlc_optic_zf95_g3", _bipod];
_rifle_mag = "hlc_30Rnd_556x45_SOST_sg550";
_rifle_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleGL_mag = "hlc_30Rnd_556x45_SOST_sg550";
_rifleGL_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleC_mag = "hlc_30Rnd_9x19_B_MP5";
_rifleL_mag = "hlc_20rnd_762x51_barrier_G3";
_rifleL_mag_tr = "hlc_20rnd_762x51_T_G3";
_rifleMarksman_mag = "hlc_20Rnd_762x51_b_G3";
_rifleMarksman_mag_tr = "hlc_20rnd_762x51_T_G3";

_LMG = ["hlc_lmg_mk46", _silencer, _pointer, _sight, ""];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "MRAWS_HEAT55_F";
_LAT_ReUsable = true;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = "rhs_weap_fim92";
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";
