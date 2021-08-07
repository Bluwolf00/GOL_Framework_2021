_useMineDetector = true;
_allowedNightStuff = false;

_goggles = "rhsusf_shemagh_grn";
_helmet = "H_HelmetHBK_F";
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["U_I_E_Uniform_01_F","U_I_E_Uniform_01_sweater_F","U_I_E_Uniform_01_shortsleeve_F"];
_vest = "rhs_6b2_chicom";
_backpack = "B_AssaultPack_eaf_F";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_eaf_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_eaf_F";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_Tank_eaf_F";
	_vest = "rhs_6b2_AK";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "rhs_6b2";
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
_sight = "";
_bipod = "";

_rifle = ["hlc_wp_xm4", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_wp_xm4", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_A1m203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_STG58F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_556x45_Stanag_Tracer_Yellow";
_rifleL_mag = "hlc_20Rnd_762x51_T_fal";

_LMG = ["hlc_lmg_M249E2", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_F";

_MMG = ["rhs_weap_mg42", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_792x57_T_MG42";

_sight = "";

_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = true;

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_pistol = ["hgun_Pistol_heavy_01_F", _silencer, _pointer, "optic_MRD", _bipod];
_pistol_mag = "11Rnd_45ACP_Mag";

_sight = "rhs_acc_pso1m21";

_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
