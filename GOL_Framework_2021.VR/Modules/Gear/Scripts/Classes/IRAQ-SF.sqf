_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "G_Balaclava_TI_blk_F";
_helmet = "rhsusf_opscore_bk_pelt";
_OfficerHelmet = "UK3CB_TKP_O_H_Patrolcap_Off_Blk";
_uniform = "UK3CB_LSM_B_U_Crew_CombatSmock_01";
_vest = "V_PlateCarrier2_blk";
_backpack = "B_ViperLightHarness_blk_F";
_backpackRadio = _backpack;

if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_black_F";
};

if (_role in ["ag","ammg","lr"]) then {
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
_sight = "rhsusf_acc_eotech_xps3";
_bipod = "rhsusf_acc_rvg_blk";

_rifle = ["rhs_weap_vhsd2", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_vhsk2", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_vhsd2_bg", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_M14dmr_Rail", _silencer, _pointer, _sight, _bipod];
_rifleC_mag = "hlc_30rnd_556x45_SOST_G36";
_rifleC_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifle_mag = "hlc_30rnd_556x45_SOST_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleGL_mag = "hlc_30rnd_556x45_SOST_G36";
_rifleGL_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleL_mag = "hlc_20Rnd_762x51_barrier_M14";
_rifleL_mag_tr = "hlc_20Rnd_762x51_T_M14";

_LMG = ["rhs_weap_m249", _silencer, _pointer, _sight, "rhsusf_acc_saw_bipod"];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_pkp", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_rpg7_PG7VL_mag";
_MAT_mag_HE = "rhs_rpg7_PG7VL_mag";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hlc_Pistol_P228", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "ACE_16Rnd_9x19_mag";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";