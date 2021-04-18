_allowedNightStuff = false;

_goggles = selectRandom ["G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli"];
_helmet = selectRandom ["H_Shemag_olive","H_ShemagOpen_tan","H_Bandanna_khk","H_Booniehat_khk","H_Cap_oli","H_Watchcap_blk"];
_uniform = selectRandom ["U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_5_F"];
_vest = "V_TacVest_oli";
_backpack = "B_FieldPack_khk";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_anprc155";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "B_Carryall_oli";
};
if (_role isEqualTo "crew") then {
	_vest = selectRandom ["V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"];
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_I";
	_uniform = "U_B_HeliPilotCoveralls";
	_vest = "V_TacVest_blk";
};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

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

_rifle = ["hlc_rifle_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_akmgl", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_762x39_b_ak";
_rifle_mag_tr = "hlc_30Rnd_762x39_m_ak";
_rifleC_mag = "hlc_30Rnd_762x39_b_ak";
_rifleC_mag_tr = "hlc_30Rnd_762x39_m_ak";

_LMG = ["hlc_rifle_RPK12", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_b_rpk";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG7_F";
_LAT_ReUsable = true;

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_silencer = "muzzle_snds_B";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "bipod_03_F_oli";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "20Rnd_762x51_Mag";
