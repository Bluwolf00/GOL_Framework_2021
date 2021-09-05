_allowedNightStuff = false;

_goggles = "";
_helmet = selectRandom ["LOP_H_SSh68Helmet_TAN","rhs_ssh60","rhs_ssh68_2"];
_OfficerHelmet = "H_Beret_blk";
_uniform = selectRandom ["LOP_U_TKA_Fatigue_01","LOP_U_TKA_Fatigue_02"];
_vest = selectRandom ["LOP_V_6B23_Rifleman_TAN","LOP_V_6B23_OLV"];
_backpack = "rhs_rd54";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_tan_big_rt1523g";
};

if(_role in ["r","lr"]) then {
	_backpack = "rhs_rpg_2";
};

if (_role in ["ag","ammg","ab"]) then {
	_backpack = "rhs_medic_bag";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "LOP_U_TKA_Fatigue_01";
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

_rifle = ["hlc_rifle_aks74", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_aks74_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_aks74", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG7_F";
_LAT_ReUsable = true;

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";