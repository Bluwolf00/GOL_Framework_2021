// Cloths
_goggles = "";
_helmet = "helmet_lwh_WZ2000";
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = SelectRandom ["Uniform_Full_WZ2000","Uniform_Rolled_WZ2000"];
_vest = "vest_spc_radio_WZ2000";
_backpack = "WZ2000_Assaultpack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_WZ2000_big_rt1523g";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "POLISH_assaultpack_Medic";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "WZ2000_Kitbag_MachineGunner";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "helmet_lwh_WZ2000_3";
};
if (_role isEqualTo "crew") then {
	_helmet = "helmet_lwh_WZ2000_3";
	_vest = "vest_spc_crewman_WZ2000";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_WZ2000";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "vest_spc_crewman_WZ2000";
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

// Primary Weapon
_rifle = ["hlc_rifle_ACR_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_smg_mp5a3", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_ACR_GL_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["rhs_weap_svdp_npz", _silencer, _pointer, "hlc_optic_zf95base", _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR";
_rifle_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleC_mag = "hlc_30Rnd_9x19_B_MP5";
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";

_LMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_250Rnd_762x51_B_MG3";
_LMG_mag_tr = "hlc_250Rnd_762x51_T_MG3";

_MMG = ["rhs_weap_pkp", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR";
_MMG_mag_tr = "rhs_100Rnd_762x54mmR_green";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_M136_hedp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

// Pistol
_pistol = ["hlc_pistol_p226US", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "hlc_15Rnd_9x19_B_P226";
