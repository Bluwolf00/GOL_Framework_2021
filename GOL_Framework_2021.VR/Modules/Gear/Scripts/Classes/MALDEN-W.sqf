_useMineDetector = false;
_allowedNightStuff = true;

_glHE = "rhs_VOG25";
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

_goggles = "rhs_balaclava1_olive";
_helmet = selectRandom ["rhssaf_helmet_m97_olive_nocamo_black_ess_bare","rhssaf_helmet_m97_olive_nocamo_black_ess","rhssaf_helmet_m97_olive_nocamo"];
_OfficerHelmet = "UK3CB_MDF_B_H_Off_Beret";
_uniform = "UK3CB_B_U_CombatUniform_03_WDL";
_vest = "rhssaf_vest_md98_rifleman";
_backpack = "OLIVE_Kitbag";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};
if (_role in ["ag","ammg","sm"]) then {
	_backpack = "OLIVE_Medicpack";
};

if (_role in ["lr","ab"]) then {
	_backpack = "UK3CB_LSM_B_B_CARRYALL_OLI";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "V_BandollierB_khk";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_TacVest_blk";
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

_silencer = "rhsusf_acc_sfmb556";
_pointer = "";
_sight = "rhs_acc_ekp8_02";
_bipod = "";

_rifle = ["rhs_weap_m21a", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m21s", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m21a_pbg40", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m76", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhsgref_30rnd_556x45_m21";
_rifle_mag_tr = "rhsgref_30rnd_556x45_m21_t";
_rifleGL_mag = "rhsgref_30rnd_556x45_m21";
_rifleGL_mag_tr = "rhsgref_30rnd_556x45_m21_t";
_rifleL_mag = "rhsgref_10Rnd_792x57_m76";
_rifleL_mag_tr = "rhssaf_10Rnd_792x57_m76_tracer";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_m84", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhssaf_250Rnd_762x54R";

_sight = "";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_fim92_mag";

_pistol = ["UK3CB_CZ75", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_CZ75_9_20Rnd";

_pdw = ["rhs_weap_m92", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhssaf_30Rnd_762x39_M82_api";
_pdw_mag_tr = "rhssaf_30Rnd_762x39_M82_api";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
