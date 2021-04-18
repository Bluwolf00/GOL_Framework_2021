_useMineDetector = true;


_goggles = "";
_helmet = "H_HelmetB";
_uniform = "U_B_CombatUniform_mcam";
_vest = "V_PlateCarrier2_rgr";
_backpack = "B_FieldPack_khk";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "tfar_rt1523g_big";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "B_Kitbag_rgr";
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

_silencer = "";
_pointer = "";
_sight = "optic_Aco";
_bipod = "";

_rifle = ["arifle_MX_Black_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_MXC_Black_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_MX_GL_Black_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_65x39_caseless_mag";
_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";

_LMG = ["arifle_MX_SW_Black_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_65x39_caseless_mag";
_LMG_mag_tr = "100Rnd_65x39_caseless_mag_Tracer";

_MMG = ["LMG_Mk200_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "200Rnd_65x39_cased_Box";
_MMG_mag_tr = "200Rnd_65x39_cased_Box_Tracer";

_sight = "";

_LAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "MRAWS_HEAT_F";
_LAT_ReUsable = true;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_pistol = ["hgun_Pistol_heavy_01_F", _silencer, _pointer, "optic_MRD", _bipod];
_pistol_mag = "11Rnd_45ACP_Mag";

_silencer = "muzzle_snds_338_sand";
_pointer = "acc_pointer_IR";
_sight = "optic_LRPS";
_bipod = "bipod_01_F_snd";

_rifleMarksman = ["srifle_DMR_02_sniper_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
