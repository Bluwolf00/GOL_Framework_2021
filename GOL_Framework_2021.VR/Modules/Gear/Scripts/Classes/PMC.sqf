_allowedNightStuff = false;
_useMineDetector = false;

_insignia = "";
_goggles = ["G_Bandanna_blk","G_Bandanna_khk","G_Bandanna_oli"];
_helmet = ["H_Shemag_olive","H_ShemagOpen_tan","H_Bandanna_khk","H_Booniehat_khk","H_Cap_oli","H_Watchcap_blk"];
_OfficerHelmet = "rhsgref_hat_M1951";
_uniform = ["U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_5_F"];
_vest = "V_TacVest_oli";
_backpack = "B_FieldPack_khk";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_anprc155";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_oli";
};
if (_role isEqualTo "crew") then {
	_vest = ["V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_oli"];
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

_rifle = ["rhs_weap_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_akm_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akm", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_762x39mm_89";
_rifle_mag_tr = "rhs_30Rnd_762x39mm_tracer";
_rifleGL_mag = "rhs_30Rnd_762x39mm_89";
_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_tracer";
_rifleC_mag = "rhs_30Rnd_762x39mm_89";
_rifleC_mag_tr = "rhs_30Rnd_762x39mm_tracer";

_LMG = ["rhs_weap_rpk74m", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_RPK74_60rnd_545x39_GT";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG7_F";
_LAT_ReUsable = true;

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "bipod_03_F_oli";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "20Rnd_762x51_Mag";
