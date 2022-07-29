_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhs_balaclava1_olive";
_helmet = "H_HelmetAggressor_F";
_OfficerHelmet = "H_Beret_CSAT_01_F";
_uniform = "U_O_V_Soldier_Viper_F";
_vest = selectRandom ["rhs_6b3_AK","rhs_6b3","rhs_6b3_holster","rhs_6b3_AK_2","rhs_6b3_AK_3"];
_backpack = selectRandom ["rhs_rk_sht_30_olive","rhs_rk_sht_30_olive_engineer_empty"];
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_LDF_B_B_RadioBag_OLI";
};

if (_role in ["sl","tl","fac"]) then {
	_vest = selectRandom ["rhs_6b3_R148","rhs_6b3_off"];
};

if (_role in ["g"]) then {
	_vest = selectRandom ["rhs_6b3_VOG","rhs_6b3_VOG_2"];
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhs_tortila_olive";
	_vest = "rhs_6b3_RPK";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_O_ghex_F";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_O";
	_uniform = "U_I_pilotCoveralls";
	_vest = "V_TacVest_oli";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "muzzle_snds_58_blk_f";
_pointer = "acc_pointer_ir";
_sight = "optic_yorris";
_bipod = "";

_rifle = ["arifle_CTARS_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_CTAR_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_CTAR_GL_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["arifle_ARX_blk_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_580x42_Mag_F";
_rifle_mag_tr = "30Rnd_580x42_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_580x42_Mag_F";
_rifleGL_mag_tr = "30Rnd_580x42_Mag_Tracer_F";
_rifleL_mag = "30Rnd_65x39_caseless_green_mag_Tracer";
_rifleL_mag_tr = "10Rnd_50BW_Mag_F";

_LMG = ["arifle_CTARS_blk_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_580x42_Mag_Tracer_F";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, "rhsusf_acc_eotech_552", _bipod];
_MMG_mag = "150Rnd_762x51_Box_Tracer";

_sight = "";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_RPG32_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG32_F";
_MAT_mag_HE = "RPG32_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["launch_O_Titan_ghex_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhs_weap_pp2000_folded", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19mm_7n31_44";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "acc_pointer_IR";
_sight = "optic_LRPS";
_bipod = "bipod_02_F_blk";

_rifleMarksman = ["srifle_DMR_07_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_65_Creedmor_mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_65x47_Scenar_mag";
