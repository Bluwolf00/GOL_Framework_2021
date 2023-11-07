_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["UK3CB_G_Neck_Shemag_Tan","rhsusf_shemagh_od","UK3CB_G_Tactical_Clear_Shemagh_Green_Gloves_Green","UK3CB_G_Tactical_Gloves_Green_Shemagh_Green","UK3CB_G_Tactical_Gloves_Green_Shemagh_Green_Headset","UK3CB_G_Tactical_Gloves_Green","UK3CB_G_Gloves_Green_Shemagh_Green","UK3CB_G_Gloves_Green"];
_helmet = ["rhs_ssh60"];
_OfficerHelmet = "rhssaf_beret_green";
_uniform = ["UK3CB_LNM_B_U_CombatUniform_13","UK3CB_LNM_B_U_CombatUniform_14","UK3CB_LNM_B_U_CombatUniform_15"];
_vest = ["UK3CB_MD12_VEST_OLI"];
_backpack = "UK3CB_ION_B_B_RIF_OLI_01";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_ION_B_B_RadioBag_OLI";
};

if(_role in ["sl","tl"]) then {
	_goggles = "Armband_Green_medium";
};

if(_role in ["r","g"]) then {
	_goggles = "Armband_Red_medium";
};

if(_role in ["ag","ammg","ar","mmg"]) then {
	_goggles = "Armband_Blue_medium";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_LSM_B_B_CARRYALL_OLI";
};

if (_role isEqualTo "crew") then {
	_uniform = "UK3CB_LNM_B_U_CombatUniform_13";
	_goggles = "Armband_Yellow_medium";
	_helmet = "H_Tank_black_F";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_ihadss";
	_uniform = "rhssaf_uniform_m10_digital";
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
_sight = "HLC_Optic_G36Export15x";
_bipod = "HLC_Bipod_G36";

_rifle = [["hlc_rifle_G36A1","hlc_rifle_G36E1"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_G36KE1", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["hlc_rifle_G36A1AG36","hlc_rifle_G36E1AG36"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3sg1", _silencer, _pointer, "HLC_Optic_ZFSG1", _bipod];
_rifle_mag = "hlc_30rnd_556x45_SPR_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleC_mag = "hlc_30rnd_556x45_SPR_G36";
_rifleC_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleGL_mag = "hlc_30rnd_556x45_SPR_G36";
_rifleGL_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleL_mag = "hlc_20rnd_762x51_Mk316_G3";
_rifleL_mag_tr = "hlc_20rnd_762x51_T_G3";

_LMG = ["LMG_03_F", _silencer, _pointer, "optic_MRCO", _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_MG3_optic", _silencer, _pointer, "optic_MRCO", _bipod];
_MMG_mag = "hlc_250Rnd_762x51_T_MG3";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_maaws", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_mag_maaws_HEAT";
_MAT_mag_HE = "rhs_mag_maaws_HE";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["launch_B_Titan_olive_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_glock17g4", _silencer, "hlc_acc_dbalpl", _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "hlc_optic_accupoint_g3";
_bipod = "";

_rifleMarksman = ["hlc_rifle_g3sg1", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_20rnd_762x51_Mk316_G3";
_rifleMarksman_mag_tr = "hlc_20rnd_762x51_T_G3";
