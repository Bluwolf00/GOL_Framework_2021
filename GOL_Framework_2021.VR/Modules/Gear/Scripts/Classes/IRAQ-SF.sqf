_useMineDetector = true;

_goggles = "G_Balaclava_TI_blk_F";
_helmet = "PO_H_mich_bare_isof_3_nortos_alt_blk";
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = "LOP_U_IA_Fatigue_SF_01";
_vest = "V_PlateCarrier2_blk";
_backpack = "B_ViperLightHarness_blk_F";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_black_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_ViperHarness_blk_F";
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
_pointer = "";
_sight = "rhsusf_acc_compm4";
_bipod = "rhsusf_acc_rvg_blk";

_rifle = ["rhs_weap_vhsd2", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_vhsk2", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_vhsd2_bg", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svdp_npz", _silencer, _pointer, "optic_arco_ak_blk_f", _bipod];
_rifle_mag = "rhsgref_30rnd_556x45_vhs2";
_rifle_mag_tr = "rhsgref_30rnd_556x45_vhs2_t";
_rifleL_mag = "10Rnd_762x54_Mag";
_rifleL_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["rhs_weap_m249", _silencer, _pointer, _sight, "rhsusf_acc_saw_bipod"];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_rpg7_PG7VL_mag";
_MAT_mag_HE = "rhs_rpg7_PG7VL_mag";

_pistol = ["hlc_Pistol_P228", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "ACE_16Rnd_9x19_mag";

_silencer = "muzzle_snds_338_green";
_pointer = "acc_pointer_IR";
_sight = "optic_LRPS";
_bipod = "bipod_01_F_mtp";

_rifleMarksman = ["srifle_DMR_02_camo_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
