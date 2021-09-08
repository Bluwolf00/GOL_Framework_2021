_glHE = "rhs_VOG25P";
_glsmokeW = "rhs_GRD40_White";
_glsmokeB = "";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "rhs_GRD40_Red";
_glsmokeY = "";

_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";
_glflareW = "rhs_VG40OP_white";

_allowedNightStuff = false;

_goggles = "";
_helmet = selectRandom ["PO_H_M1_OLV_2","PO_H_M1_TAN","LOP_H_SSh68Helmet_TAN","rhs_ssh60","rhs_ssh68_2","LOP_H_Beanie_m81"];
_OfficerHelmet = "H_Beret_blk";
_uniform = selectRandom ["LOP_U_SYR_M93_leaf_02","LOP_U_SYR_M93_leaf_01","LOP_U_SYR_M93_m81_04","LOP_U_SYR_M93_m81_01","LOP_U_SYR_M93_m81_03","LOP_U_SYR_M93_m81_02","LOP_U_SYR_M93_marpat_02","LOP_U_SYR_M93_marpat_01"];
_vest = selectRandom ["LOP_V_6Sh92_Radio_WDL","rhs_chicom_khk","rhs_lifchik","V_TacVest_oli","LOP_V_Carrier_TAN","rhs_6b2","LOP_V_CarrierRig_WDL"];
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "CADPATAR_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_rd54_vest";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_zsh7a_mike_green";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "rhs_zsh7a";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_aks74", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_aks74_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleL_mag = "rhs_30Rnd_762x39mm_bakelite_tracer";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

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

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";