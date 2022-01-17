_useMineDetector = false;
_allowedNightStuff = false;

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

_goggles = selectRandom ["G_Bandanna_oli","G_Balaclava_oli",""];
_helmet = selectRandom ["","rhs_ssh68","rhsgref_M56"];
_OfficerHelmet = "H_Beret_blk";
_uniform = selectRandom ["LOP_U_ChDKZ_Fatigue_02","LOP_U_ChDKZ_Fatigue_03","LOP_U_ChDKZ_Fatigue_04"];
_vest = selectRandom ["rhs_6b2_chicom","rhs_6b2_lifchik","rhs_6b2_RPK"];
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_mr3000_rhs";
};

if (_role in ["ag","ammg","lr","ab"]) then {
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

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_aks74", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_aks74_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_545x39_Mag_F";
_rifleGL_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleL_mag = "rhs_30Rnd_762x39mm_bakelite_tracer";

_LMG = ["hlc_rifle_rpk", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_75Rnd_762x39mm_tracer";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG7_F";
_LAT_ReUsable = true;

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";