_useMineDetector = true;


_goggles = "";
_helmet = "rhs_ssh60";
_OfficerHelmet = "PO_H_PASGT_ANA";
_uniform = "LOP_U_ANA_M93_spec4e_01";
_vest = "rhsgref_otv_khaki";
_backpack = "OLIVE_Kitbag";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "OLIVE_PB_Rucksack";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_HeliPilotCoveralls";
	_vest = "V_TacVest_blk";
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
_pointer = "gvl_x2000_wide";
_sight = "";
_bipod = "";

_rifle = ["hlc_rifle_M4", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_CQBR", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_m4m203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_CQBR", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";


_LMG = ["hlc_lmg_minimi", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_m240G", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_rpg7_PG7VL_mag";
_MAT_mag_HE = "rhs_rpg7_PG7VL_mag";

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_JHP";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21_svd";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_10Rnd_762x54_Tracer_mag";
