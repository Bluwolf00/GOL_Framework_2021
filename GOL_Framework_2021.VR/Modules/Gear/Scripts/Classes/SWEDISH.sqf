_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","rhsusf_shemagh2_gogg_grn","rhsusf_shemagh_gogg_grn","rhsusf_shemagh_grn","rhsusf_shemagh2_grn","rhsusf_oakley_goggles_blk","UK3CB_G_Tactical_Clear_Shemagh_Green","acp_gol_SE_M90_G_Bandanna_SE_M90","acp_gol_SE_M90_G_Balaclava_lowprofile_SE_M90"];
_helmet = ["acp_gol_SE_M90_H_HelmetSpecter_cover_SE_M90_F","acp_gol_SE_M90_H_HelmetSpecter_headset_SE_M90_F","acp_gol_SE_M90_H_HelmetSpecter_SE_M90_F","acp_gol_SE_M90_H_HelmetSpecB_SE_M90_insignia","acp_gol_SE_M90_H_HelmetB_light_SE_M90_insignia"];
_OfficerHelmet = "acp_gol_SE_M90_H_MilCap_SE_M90";
_uniform = ["acp_gol_SE_M90_U_B_CombatUniform_SE_M90_insignia","acp_gol_SE_M90_U_B_CombatUniform_vest_SE_M90_insignia","acp_gol_SE_M90_U_B_CombatUniform_tshirt_SE_M90","acp_gol_SE_M90_U_I_E_Uniform_tanktop_SE_M90_01_F","acp_gol_SE_M90_U_I_E_Uniform_shortsleeve_SE_M90_01_F_flag","acp_gol_SE_M90_U_I_E_Uniform_SE_M90_01_F_insignia"];
_vest = ["acp_gol_SE_M90_V_PlateCarrier2_SE_M90_insignia","acp_gol_SE_M90_V_PlateCarrierSpec_SE_M90_insignia","acp_gol_SE_M90_V_PlateCarrier1_SE_M90_insignia","acp_gol_SE_M90_V_PlateCarrierIA2_SE_M90"];
_backpack = "acp_gol_SE_M90_B_Kitbag_rgr_SE_M90";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_SE_M90_B_RadioBag_01_SE_M90_F";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "acp_gol_SE_M90_B_Carryall_SE_M90";
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
_silencer = "rhsusf_acc_sfmb556";
_pointer = "";
_sight = "optic_erco_blk_f";
_bipod = "rhsusf_acc_grip3";

// Primary Weapon
_rifle = [["hlc_rifle_416D145","hlc_rifle_416D165","hlc_rifle_416D10","hlc_rifle_416D10_st6","hlc_rifle_416N"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_416D10C", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["hlc_rifle_416D145_gl","hlc_rifle_416D10_gl","hlc_rifle_416D165_gl","hlc_rifle_416N_gl"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3a3vris", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["hlc_rifle_awcovert", _silencer, _pointer, "hlc_optic_zf95base", _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifle_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleGL_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleGL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleC_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleC_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleL_mag = "hlc_20rnd_762x51_barrier_G3";
_rifleL_mag_tr = "hlc_20rnd_762x51_T_G3";
_rifleMarksman_mag = "hlc_20Rnd_762x51_b_G3";
_rifleMarksman_mag_tr = "hlc_20rnd_762x51_T_G3";

_LMG = [["LMG_03_F","UK3CB_BAF_L110A3"], _silencer, _pointer, _sight, ""];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

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
