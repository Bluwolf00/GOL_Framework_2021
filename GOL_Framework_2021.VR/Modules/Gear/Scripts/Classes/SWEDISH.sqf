_useMineDetector = false;
_allowedNightStuff = true;

_goggles = "G_Balaclava_TI_blk_F";
_helmet = selectRandom ["rhsusf_opscore_fg_pelt","rhsusf_opscore_fg","rhsusf_opscore_fg_pelt_cam"];
_OfficerHelmet = "UK3CB_ANA_B_H_Beret_GRN";
_uniform = SelectRandom ["UK3CB_LNM_B_U_CombatSmock_21"];
_vest = selectRandom["UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI","UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI","UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_TL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_GREN_Vest_KKZ10_OLI"];
_backpack = "B_Kitbag_rgr";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_LDF_I_B_RadioBag_GEO";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "UK3CB_B_Hiker";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "UK3CB_B_Hiker";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "rhsusf_opscore_fg_pelt_nsw";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
	_vest = "UK3CB_LDF_B_V_Vest_KKZ10_OLI";
	_uniform = "UK3CB_LNM_B_U_CombatSmock_21";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_M90";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI";
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

// Attachments
_silencer = "rhsusf_acc_sfmb556";
_pointer = "";
_sight = "optic_erco_blk_f";
_bipod = "rhsusf_acc_grip3";

// Primary Weapon
_rifle = ["hlc_rifle_SG551SB_TAC", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_SG553SB_TAC", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_SG551SB_TAC_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3a3ris", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["hlc_rifle_g3a3", _silencer, _pointer, "hlc_optic_zf95_g3", _bipod];
_rifle_mag = "hlc_30Rnd_556x45_EPR_sg550";
_rifle_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleGL_mag = "hlc_30Rnd_556x45_EPR_sg550";
_rifleGL_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleC_mag = "hlc_30Rnd_556x45_EPR_sg550";
_rifleC_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleL_mag = "hlc_20rnd_762x51_barrier_G3";
_rifleL_mag_tr = "hlc_20rnd_762x51_T_G3";
_rifleMarksman_mag = "hlc_20Rnd_762x51_b_G3";
_rifleMarksman_mag_tr = "hlc_20rnd_762x51_T_G3";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, ""];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "MRAWS_HEAT55_F";
_LAT_ReUsable = true;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";
