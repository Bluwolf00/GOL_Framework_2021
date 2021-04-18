_allowedNightStuff = false;

_goggles = "";
_helmet = selectRandom ["LOP_H_Shemag_TAN","","LOP_H_Turban","LOP_H_Turban_Mask","LOP_H_Pakol"];
_uniform = selectRandom ["LOP_U_AM_Fatigue_01","LOP_U_AM_Fatigue_02_3","LOP_U_AM_Fatigue_01_4","LOP_U_AM_Fatigue_01_6","LOP_U_AM_Fatigue_01_5","LOP_U_AM_Fatigue_02_3","LOP_U_AM_Fatigue_02_5"];
_vest = selectRandom ["V_HarnessO_gry","V_BandollierB_rgr"];
_backpack = "B_AssaultPack_cbr";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_tan_big_rt1523g";
};

if ((random 1) > 0.90) then {
	_goggles = "G_Squares";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "B_Fieldpack_cbr";
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
_rifleC = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_akmgl", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_762x39_b_ak";
_rifle_mag_tr = "hlc_30Rnd_762x39_m_ak";
_rifleC_mag = "hlc_30Rnd_762x39_b_ak";
_rifleC_mag_tr = "hlc_30Rnd_762x39_m_ak";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_45Rnd_762x39_t_rpk";
/*
if (GVARMAIN(mod_CUP_WEAPONS)) then {
	_LMG = ["CUP_arifle_RPK74_45", _silencer, _pointer, _sight, _bipod];
	_LMG_mag = "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M";

	_MMG = ["CUP_lmg_Pecheneg", _silencer, _pointer, _sight, _bipod];
	_MMG_mag = "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
};
*/
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
