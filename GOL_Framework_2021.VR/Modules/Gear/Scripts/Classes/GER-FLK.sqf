_useMineDetector = false;
_allowedNightStuff = true;

// Cloths
_goggles = "G_Balaclava_TI_blk_F";
_helmet = "rhsgref_helmet_pasgt_flecktarn";
_OfficerHelmet = "UK3CB_LNM_B_H_BoonieHat_FLK_03";
_uniform = SelectRandom ["UK3CB_LNM_B_U_CombatSmock_01","UK3CB_LNM_B_U_CombatSmock_03"];
_vest = "UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI";
_backpack = "UK3CB_TKA_O_B_RIF_Khk";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "TFAR_rt1523g_big_bwmod";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_LSM_B_B_CARRYALL_KHK";
};

if (_role isEqualTo "crew") then {
	_vest = "UK3CB_LDF_B_V_Vest_KKZ10_OLI";
	_backpack = "UK3CB_TKA_O_B_RIF_Khk";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_visor";
	_vest = "UK3CB_LDF_B_V_Vest_KKZ10_OLI";
};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "optic_Hamr";
_bipod = "";

// Primary Weapon
_rifle = ["hlc_rifle_G36V", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_G36C", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_G36VAG36", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3sg1ris", _silencer, _pointer, "optic_hamr", _bipod];
_rifle_mag = "hlc_30rnd_556x45_M_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleGL_mag = "hlc_30rnd_556x45_M_G36";
_rifleGL_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleL_mag = "hlc_20rnd_762x51_b_G3";
_rifleL_mag_tr = "hlc_20rnd_762x51_T_G3";
_rifleC_mag = "hlc_30rnd_556x45_M_G36";
_rifleC_mag_tr = "hlc_30rnd_556x45_Tracers_G36";

_LMG = ["hlc_lmg_minimipara_railed", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_200rnd_556x45_T_SAW";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_MG3";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_JHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";