_useMineDetector = false;
_allowedNightStuff = false;

_goggles = ["UK3CB_G_KLR_GRN"];
_helmet = ["acp_gol_SE_M90_H_HelmetSpecB_SE_M90_insignia","acp_gol_SE_M90_H_HelmetSpecB_SE_M90","acp_gol_SE_M90_H_HelmetB_camo_SE_M90","acp_gol_SE_M90_H_HelmetB_camo_SE_M90"];
_OfficerHelmet = "acp_gol_SE_M90_H_MilCap_SE_M90";
_uniform = ["acp_gol_SE_M90_U_I_CombatUniform_SE_M90_insignia","acp_gol_SE_M90_U_I_CombatUniform_shortsleeve_SE_M90_insignia"];
_vest = ["acp_gol_SE_M90_V_PlateCarrierSpec_SE_M90_insignia","acp_gol_SE_M90_V_PlateCarrier2_SE_M90_insignia"];
_backpack = "UK3CB_B_I_Backpack_Radio_Chem_OLI";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "UK3CB_B_B_Backpack_Radio_Chem_OLI";
};

if (_role in ["ag","ammg","sm","lr"]) then {
	_backpack = "acp_gol_SE_M90_B_Carryall_SE_M90";
};

if(_role in ["ab","aa"]) then {
	_backpack = "acp_gol_SE_M90_B_Bergen_SE_M90_F";
	_vest = "acp_gol_SE_M90_V_TacVestIR_SE_M90";
	_helmet = "acp_gol_SE_M90_H_HelmetB_light_SE_M90_insignia";
	_uniform = "acp_gol_SE_M90_U_BG_Guerrilla_6_SE_M90_insignia";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "acp_gol_SE_M90_B_Kitbag_rgr_SE_M90";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "acp_gol_SE_M90_H_HelmetSpecter_headset_SE_M90_F";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
	_vest = "acp_gol_SE_M90_V_PlateCarrier1_SE_M90_insignia";
	_uniform = "UK3CB_LNM_B_U_CombatSmock_21";
};
if (_role isEqualTo "p") then {
	_uniform = "acp_gol_SE_M90_U_B_HeliPilotCoveralls_SE_M90";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "acp_gol_SE_M90_V_PlateCarrier1_SE_M90_insignia";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_gol_SE_M90_U_O_PilotCoveralls_SE_M90";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "JCA_optic_ICO_black";
_bipod = "JCA_bipod_04_black";

// Primary Weapon
_rifle = [["arifle_SPAR_02_blk_F"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_SPAR_01_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["arifle_SPAR_01_GL_blk_F"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_G3SG1_RIS", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["UK3CB_G3SG1_RIS", _silencer, _pointer, "rhsusf_acc_LEUPOLDMK4_2", _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifle_mag_tr = "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red";
_rifleGL_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleGL_mag_tr = "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red";
_rifleC_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleC_mag_tr = "rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red";
_rifleL_mag = "UK3CB_G3_20rnd_762x51_R";
_rifleL_mag_tr = "UK3CB_G3_20rnd_762x51_RT";
_rifleMarksman_mag = "UK3CB_G3_20rnd_762x51_R";
_rifleMarksman_mag_tr = "UK3CB_G3_20rnd_762x51_RT";

_LMG = ["UK3CB_BAF_L110A3", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_556_200Rnd_T";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, ""];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

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
