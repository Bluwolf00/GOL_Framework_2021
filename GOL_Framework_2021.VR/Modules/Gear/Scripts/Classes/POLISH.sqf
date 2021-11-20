
// Cloths
_goggles = "";
_helmet = selectRandom ["helmet_lwh_WZ2000","helmet_lwh_WZ2000_2"];
_OfficerHelmet = "beret_Maroon";
_uniform = SelectRandom ["Uniform_Full_WZ2000","Uniform_Rolled_WZ2000"];
_vest = "vest_spc_radio_WZ2000";
_backpack = "WZ2000_Kitbag";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_WZ2000_big_rt1523g";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "WZ2000_PB_Rucksack";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "WZ2000_PB_Rucksack";
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
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "optic_ERCO_blk_F";
_bipod = "";

// Primary Weapons
_rifle = ["hlc_rifle_SG551SB_TAC", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_SG553SB_TAC", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_SG551SB_TAC_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_SG550Sniper_RIS", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_556x45_SOST_sg550";
_rifle_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleGL_mag = "hlc_30Rnd_556x45_SOST_sg550";
_rifleGL_mag_tr = "hlc_30Rnd_556x45_T_sg550";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_MG3";

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

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

// Pistol
_pistol = ["hlc_Pistol_M11A1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "hlc_13Rnd_9x19_B_P228";

_rifleMarksman = ["arifle_MSBS65_Mark_black_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "30Rnd_65x39_caseless_msbs_mag";
_rifleMarksman_mag_tr = "30Rnd_65x39_caseless_msbs_mag_Tracer";
