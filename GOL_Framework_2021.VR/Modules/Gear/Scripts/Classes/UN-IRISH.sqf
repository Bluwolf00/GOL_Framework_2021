_useMineDetector = true;
_allowedNightStuff = false;

_goggles = "G_Shades_Blue";
_helmet = "rhssaf_beret_blue_un";
_OfficerHelmet = "rhssaf_beret_blue_un";
_uniform = "UK3CB_ADM_B_U_CombatUniform_01_WDL";
_vest = "UK3CB_UN_B_V_6b23_ML_6sh92_radio";
_backpack = "";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_B_Backpack_Radio_Chem_OLI";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhssaf_kitbag_md2camo";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "UK3CB_ADM_B_U_CombatUniform_01_WDL";
	_vest = "UK3CB_UN_B_V_6b23_ML_6sh92_radio";
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
_pointer = "gvl_x2000_wide";
_sight = "";
_bipod = "";

_rifle = ["hlc_rifle_auga1_t", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_auga1_t", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["uk3cb_auga3_gl", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_FAL5061", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_40Rnd_556x45_M_AUG";
_rifle_mag_tr = "hlc_40Rnd_556x45_M_AUG";
_rifleC_mag = "hlc_40Rnd_556x45_M_AUG";
_rifleC_mag_tr = "hlc_40Rnd_556x45_M_AUG";
_rifleGL_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleGL_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleL_mag = "UK3CB_FNFAL_30rnd_762x51_RT";
_rifleL_mag_tr = "UK3CB_FNFAL_30rnd_762x51_RT";


_LMG = ["hlc_lmg_minimipara_long_railed", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_200rnd_556x45_M_SAW";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_Barrier_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "rhs_mag_maaws_HE";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["hlc_pistol_P226R_Combat", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "hlc_15Rnd_9x19_B_P226";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "optic_lrps";
_bipod = "";

_rifleMarksman = ["hlc_rifle_awmagnum_BL", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_300WM_FMJ_AWM";
