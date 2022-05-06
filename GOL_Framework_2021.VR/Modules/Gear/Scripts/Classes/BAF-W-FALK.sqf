_useMineDetector = false;
_allowedNightStuff = false;

_goggles = "";
_helmet = "beret_Green";
_OfficerHelmet = "beret_Green";
_uniform = "rhsgref_uniform_dpm";
_vest = "vest_spc_rifleman_IDPM";
_backpack = "B_FieldPack_green_F";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_eaf_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "OLIVE_PB_Bergen";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_visor_black";
	_uniform = "Uniform_Coveralls_MTP";
	_vest = "vest_spc_crewman_MTP";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "Uniform_Coveralls_MTP";
	_vest = "V_Rangemaster_belt";
	_backpack = _backpackRadio;
};

_silencer = "rhsgref_acc_falMuzzle_l1a1";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_l1a1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_wp_mod733", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_Colt727_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_l1a1", _silencer, _pointer, _sight, _bipod];
_rifleGL_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifle_mag = "rhs_mag_20Rnd_762x51_m61_fnfal";
_rifle_mag_tr = "rhs_mag_20Rnd_762x51_m62_fnfal";
_rifleC_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";

_LMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_762_100Rnd_T";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_100Rnd_T";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["UK3CB_BAF_L9A1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "16Rnd_9x21_Mag";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "";

_rifleMarksman = ["UK3CB_BAF_L115A3", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_BAF_338_5Rnd";
_rifleMarksman_mag_tr = "UK3CB_BAF_338_5Rnd_Tracer";
