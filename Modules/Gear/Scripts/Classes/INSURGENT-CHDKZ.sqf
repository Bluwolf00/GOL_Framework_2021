


_allowedNightStuff = false;

_goggles = selectRandom ["G_Bandanna_oli","G_Balaclava_oli",""];
_helmet = selectRandom ["","rhs_ssh68","rhsgref_M56"];
_uniform = selectRandom ["LOP_U_ChDKZ_Fatigue_02","LOP_U_ChDKZ_Fatigue_03","LOP_U_ChDKZ_Fatigue_04"];
_vest = selectRandom ["rhsgref_6b23_khaki_rifleman","rhsgref_6b23_khaki","rhsgref_6b23_khaki_sniper","rhsgref_6b23_khaki_medic"];
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_mr3000_rhs";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "rhs_sidor";
};

if (_role isEqualTo "p") then {
	_helmet = "booniehat_M05";
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

_rifle = ["hlc_rifle_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_akmgl", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_762x39_b_ak";
_rifle_mag_tr = "hlc_30Rnd_762x39_m_ak";
_rifleC_mag = "hlc_30Rnd_762x39_b_ak";
_rifleC_mag_tr = "hlc_30Rnd_762x39_m_ak";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_45Rnd_762x39_t_rpk";

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
