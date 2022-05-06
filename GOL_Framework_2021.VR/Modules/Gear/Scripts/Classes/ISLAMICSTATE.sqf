_useMineDetector = false;
_allowedNightStuff = false;

_goggles = "";
_helmet = selectRandom ["LOP_H_Shemag_BLK","","","LOP_H_Shemag_BLK","LOP_H_Turban_mask","LOP_H_Turban","PO_H_cap_tub"];
_uniform = selectRandom ["LOP_U_ISTS_Fatigue_21","LOP_U_ISTS_Fatigue_27","LOP_U_ISTS_Fatigue_12","LOP_U_ISTS_Fatigue_03","LOP_U_ISTS_Fatigue_07","LOP_U_ISTS_Fatigue_14","LOP_U_ISTS_Fatigue_05","LOP_U_ISTS_Fatigue_15","LOP_U_ISTS_Fatigue_09"];
_vest = selectRandom ["LOP_V_CarrierLite_TRI","LOP_V_CarrierLite_WDL","LOP_V_CarrierLite_TAN"];
_backpack = "LOP_ISTS_Sidor_Med";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_tan_big_rt1523g";
};

if ((random 1) > 0.90) then {
	_goggles = "G_Squares";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "rhs_sidor";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "Uniform_Coveralls_VZ85";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["hlc_rifle_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_akmgl", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_762x39_b_ak";
_rifle_mag_tr = "hlc_30Rnd_762x39_m_ak";
_rifleGL_mag = "hlc_30Rnd_762x39_b_ak";
_rifleGL_mag_tr = "hlc_30Rnd_762x39_m_ak";
_rifleC_mag = "rhsgref_30rnd_1143x23_M1911B_SMG";

_LMG = ["hlc_rifle_rpk74n", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_t_rpk";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";


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
