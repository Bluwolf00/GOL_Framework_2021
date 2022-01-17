_useMineDetector = false;
_allowedNightStuff = false;

_glHE = "";
_glsmokeW = "";
_glsmokeB = "";
_glsmokeG = "";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "";
_glsmokeY = "";

_glflareG = "";
_glflareR = "";
_glflareW = "";

_allowedNightStuff = false;

_goggles = selectRandom ["","",""];
_helmet = selectRandom ["rhs_pilotka","rhs_ssh68","rhsgref_M56","rhs_ushanka","rhs_fieldcap_early","rhs_fieldcap_m88"];
_OfficerHelmet = "rhs_beret_omon";
_uniform = selectRandom ["rhs_uniform_afghanka_winter","rhs_uniform_afghanka_boots"];
_vest = selectRandom ["rhs_suspender_SKS","rhs_suspender_AK","rhs_suspender_AK4","rhs_suspender_AK"];
_backpack = "rhs_rd54";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "rhs_r148";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_rd54";
	_vest = "rhs_gear_OFF";
};

if (_role isEqualTo "p") then {
	_helmet = "rhs_ushanka";
};

if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_backpack = "B_Parachute";
	_helmet = "rhs_fieldcap_m88_back"
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m38", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_Izh18", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m38", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_kar98k", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhsgref_5Rnd_762x54_m38";
_rifleC_mag = "rhsgref_1Rnd_00Buck";
_rifleGL_mag = "rhsgref_5Rnd_762x54_m38";
_rifleL_mag = "rhsgref_5Rnd_792x57_kar98k";

_LMG = ["rhs_weap_MP44", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsgref_25Rnd_792x33_SmE_StG";

_MMG = ["hlc_lmg_MG42", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsgref_50Rnd_792x57_SmK_alltracers_drum";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhs_weap_tt33", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_762x25_8";

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifleMarksman = ["hlc_rifle_M1903A1_unertl", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_3006_1903";