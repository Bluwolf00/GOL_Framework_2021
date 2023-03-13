_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = [""];
_helmet = ["acp_gol_CZ_vz95_H_HelmetB_light_CZ_vz95_insignia"];
_OfficerHelmet = "rhsgref_fieldcap_ttsko_digi";
_uniform = ["acp_gol_CZ_vz95_U_I_E_Uniform_shortsleeve_CZ_vz95_01_F_flag","acp_gol_CZ_vz95_U_I_E_Uniform_CZ_vz95_01_F_insignia"];
_vest = ["acp_gol_CZ_vz95_V_PlateCarrierIA2_CZ_vz95"];
_backpack = "acp_gol_CZ_vz95_B_AssaultPackEnhanced_CZ_vz95_insignia";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_CZ_vz95_B_RadioBag_01_CZ_vz95_F";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "acp_gol_CZ_vz95_B_Carryall_CZ_vz95";
};

if(_role in ["crew"]) then {
	_helmet = "H_HelmetCrew_I";
	_goggles = "";
	_vest = "acp_gol_CZ_vz95_V_PlateCarrier1_CZ_vz95_insignia";
	_uniform = "acp_gol_CZ_vz95_U_O_officer_noInsignia_CZ_vz95_F_insignia";
};

if (_role isEqualTo "p") then {
	_helmet = "UK3CB_H_Pilot_Helmet";
	_vest = "acp_gol_CZ_vz95_V_PlateCarrierIA1_CZ_vz95";
	_goggles = "";
	_uniform = "acp_gol_CZ_vz95_U_O_PilotCoveralls_CZ_vz95";
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

_silencer = "rhsusf_acc_sfmb556";
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "";
_bipod = "rhsusf_acc_grip1";

// Primary Weapon
_rifle = ["hlc_rifle_ACR_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_ACR_SBR_black", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_ACR_GL_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_ACR_Full_black", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR";
_rifle_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleGL_mag = "hlc_30rnd_556x45_EPR";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleC_mag = "hlc_30rnd_556x45_EPR";
_rifleC_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleL_mag = "hlc_30rnd_556x45_EPR";
_rifleL_mag_tr = "hlc_30rnd_556x45_t_PMAG";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhs_weap_pya", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19_17";

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
