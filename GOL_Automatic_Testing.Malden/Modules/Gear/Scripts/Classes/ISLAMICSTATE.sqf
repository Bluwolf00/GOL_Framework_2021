_useMineDetector = false;
_allowedNightStuff = false;

_glHE = "rhs_VOG25";
_glHEDP = "rhs_VOG25";
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

_insignia = "";
_goggles = "";
_helmet = ["H_ShemagOpen_tan","","","UK3CB_H_Shemag_blk","UK3CB_H_Shemag_grey","UK3CB_H_Shemag_tan","UK3CB_H_Shemag_white","UK3CB_ADE_O_H_Turban_01_1","UK3CB_ADE_I_H_Turban_01_2","UK3CB_H_Turban_Facewrap_03_Blk","UK3CB_H_Turban_Facewrap_01_Tan"];
_uniform = ["UK3CB_ADE_O_U_02_F","UK3CB_ADE_O_U_02_H","UK3CB_ADE_O_U_02_I","UK3CB_ADE_O_U_02_J","UK3CB_ADE_O_U_02_K","UK3CB_ADE_O_U_02_B","UK3CB_ADE_O_U_02","UK3CB_ADE_O_U_02_G","UK3CB_ADE_O_U_02_C"];
_vest = ["V_BandollierB_khk","rhs_6b2","UK3CB_TKP_I_V_6Sh92_Khk","UK3CB_TKP_I_V_6Sh92_Radio_Khk","rhs_belt_RPK","UK3CB_V_Belt_Rig_KHK","UK3CB_V_Chicom_Desert","UK3CB_V_Chestrig_OLI"];
_backpack = "UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "UK3CB_B_O_Alice_Radio_Backpack";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "UK3CB_CW_SOV_O_LATE_B_Sidor_RIF";
};
if (_role isEqualTo "p") then {
	_helmet = "UK3CB_TKC_H_Pilot_Turban_01_1";
	_uniform = "UK3CB_TKC_C_U_Pilot_B";
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

_rifle = ["rhs_weap_akm", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_akm_gp25", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_762x39mm_bakelite";
_rifle_mag_tr = "rhs_30Rnd_762x39mm_bakelite_tracer";
_rifleGL_mag = "rhs_30Rnd_762x39mm_bakelite";
_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_bakelite_tracer";
_rifleC_mag = "rhsgref_30rnd_1143x23_M1911B_SMG";

_LMG = ["rhs_weap_rpk74m", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_RPK74_60rnd_545x39_GT";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

if(random 1 > 0.5) then {
	_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg75_mag";
	_LAT_ReUsable = false;
} else {
	_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg18_mag";
	_LAT_ReUsable = false;
};

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
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_SVD_10rnd_762x54_GT";
_rifleMarksman_mag_tr = "UK3CB_SVD_10rnd_762x54_GT";
