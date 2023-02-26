_useMineDetector = false;
_allowedNightStuff = false;

_insignia = "";
_goggles = "";
_helmet = ["UK3CB_ARD_B_H_Ssh68_Des"];
_OfficerHelmet = "H_Beret_blk";
_uniform = ["UK3CB_TKA_O_U_CombatUniform_01_ADPM","UK3CB_TKA_O_U_CombatUniform_02_ADPM"];
_vest = ["rhs_6b2_chicom","rhs_6b2_lifchik","rhs_6b2_RPK"];
_backpack = "UK3CB_B_Alice_K";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_O_Alice_Radio_Backpack";
};

if(_role in ["r","lr"]) then {
	_backpack = "rhs_rpg_2";
};

if (_role in ["ag","ammg","ab"]) then {
	_backpack = "UK3CB_B_Alice_Med_K";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "UK3CB_TKA_B_U_H_Pilot_DES";
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

_silencer = "rhs_acc_pgs64_74u";
_pointer = "";
_sight = "";
_bipod = "";

_rifleC = ["hlc_rifle_aks74u", _silencer, _pointer, _sight, _bipod];

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["hlc_rifle_aks74", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_aks74_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_aks74", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_545x39_Mag_F";
_rifleGL_mag_tr = "30Rnd_545x39_Mag_Tracer_F";

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
_sight = "rhs_acc_pso1m2";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";