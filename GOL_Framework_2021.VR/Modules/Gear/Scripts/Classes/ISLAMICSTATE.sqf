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
_goggles = ["UK3CB_G_Balaclava","UK3CB_G_Balaclava2_BLK","UK3CB_G_Balaclava2_MEE","G_Armband_tak2_F","G_Armband_tak2_F","","",""];
_helmet = ["UK3CB_H_Turban_Facewrap_02_Blk","","","UK3CB_H_Turban_Facewrap_03_Blk","UK3CB_H_Turban_Neckwrap_01_Blk","UK3CB_H_Turban_Neckwrap_02_Blk","UK3CB_H_Turban_Neckwrap_03_Blk","UK3CB_H_Shemag_blk","UK3CB_TKP_I_H_SSh68_BLK","rhsusf_opscore_bk","rhssaf_helmet_m97_black_nocamo"];
_uniform = ["UK3CB_MEE_O_U_07_C","UK3CB_MEE_O_U_07","UK3CB_MEE_O_U_05","UK3CB_MEE_O_U_01","UK3CB_MEE_O_U_07","UK3CB_MEE_O_U_07_B","UK3CB_MEE_O_U_08","UK3CB_CHC_C_U_Overall_01"];
_vest = ["UK3CB_V_MBAV_RIFLEMAN_BLK","UK3CB_V_MBAV_MEDIC_BLK","UK3CB_V_MBAV_MG_BLK","UK3CB_V_MBAV_LIGHT_BLK","UK3CB_ION_B_V_RIF_ALT_BLK_01","UK3CB_V_MBAV_BLK","UK3CB_ANP_B_V_TacVest_BLK"];
_backpack = "UK3CB_CSAT_U_O_B_UMBTS";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "TFAR_rt1523g_black";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "UK3CB_CSAT_O_B_TACPACK_BLK";
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

_rifle = ["UK3CB_M16A1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_akm_gp25", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_M16_30rnd_556x45_G";
_rifle_mag_tr = "UK3CB_M16_30rnd_556x45_GT";
_rifleGL_mag = "rhs_30Rnd_762x39mm_bakelite";
_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_bakelite_tracer";
_rifleC_mag = "rhs_30Rnd_545x39_AK_green";

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
