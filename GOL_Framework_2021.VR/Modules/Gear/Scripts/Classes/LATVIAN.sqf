// Cloths
_goggles = "";
_helmet = "helmet_lwh_NBS";
_OfficerHelmet = "beret_Maroon";
_uniform = SelectRandom ["Uniform_Full_NBS","Uniform_Rolled_NBS"];
_vest = "vest_spc_radio_NBS";
_backpack = "NBS_Assaultpack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_NBS_big_rt1523g";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "NBS_Medicpack";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "NBS_Kitbag_MachineGunner";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "helmet_lwh_NBS_3";
};
if (_role isEqualTo "crew") then {
	_helmet = "helmet_lwh_NBS_3";
	_vest = "vest_spc_crewman_NBS";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_NBS";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "vest_spc_crewman_NBS";
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
_pointer = "rhsusf_acc_anpeq15_bk";
_sight = "rksl_optic_eot552";
_bipod = "";

// Primary Weapon
_rifle = ["hlc_rifle_G36V", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_smg_mp5a3", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_G36VAG36", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3sg1ris", _silencer, _pointer, "optic_hamr", _bipod];
_rifle_mag = "hlc_30rnd_556x45_M_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleL_mag = "hlc_20rnd_762x51_T_G3";
_rifleC_mag = "hlc_30Rnd_9x19_B_MP5";

_LMG = ["rhs_weap_m249", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

// Marksman
_rifleMarksman = ["arifle_SPAR_03_blk_F", _silencer, _pointer, "hlc_optic_leupoldm3a", _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";


// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";
