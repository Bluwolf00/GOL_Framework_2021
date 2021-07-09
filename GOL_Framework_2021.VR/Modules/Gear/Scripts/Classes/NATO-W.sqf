_useMineDetector = true;

_goggles = "G_Balaclava_TI_blk_F";
_helmet = "rhsusf_opscore_fg_pelt";
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = "U_B_T_Soldier_F";
_vest = "V_PlateCarrier2_tna_F";
_backpack = "B_FieldPack_oli";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_M05_big_rt1523g";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_oli";
};
if (_role isEqualTo "crew") then {
	_uniform = "U_B_T_Soldier_SL_F";
	_vest = "V_BandollierB_oli";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_HeliPilotCoveralls";
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

_silencer = "";
_pointer = "acc_pointer_IR";
_sight = "optic_hamr";
_bipod = "";

_rifle = ["arifle_MX_khk_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_MXC_khk_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_MX_GL_khk_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["arifle_MX_khk_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_65x39_caseless_khaki_mag";
_rifle_mag_tr = "30Rnd_65x39_caseless_khaki_mag_Tracer";
_rifleL_mag = "30Rnd_65x39_caseless_khaki_mag";
_rifleL_mag_tr = "30Rnd_65x39_caseless_khaki_mag_Tracer";

_LMG = ["arifle_MX_SW_khk_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_65x39_caseless_khaki_mag";
_LMG_mag_tr = "100Rnd_65x39_caseless_khaki_mag_Tracer";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_M_M60E4";
_MMG_mag_tr = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "MRAWS_HEAT_F";
_LAT_ReUsable = true;

_MAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "Titan_AT";
_MAT_mag_HE = "Titan_AP";

_pistol = ["hgun_P07_khk_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "16Rnd_9x21_Mag";

_silencer = "muzzle_snds_338_green";
_pointer = "acc_pointer_IR";
_sight = "optic_LRPS";
_bipod = "bipod_01_F_mtp";

_rifleMarksman = ["srifle_DMR_02_camo_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
