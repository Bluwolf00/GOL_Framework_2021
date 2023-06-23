_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["rhsusf_shemagh2_tan","rhsusf_shemagh_tan","G_Bandanna_khk","UK3CB_G_KLR_TAN","rhsusf_shemagh_gogg_tan","rhsusf_shemagh2_gogg_tan","acp_gol_TUR_TLF_G_Balaclava_TI_G_TUR_TLF_F","acp_gol_TUR_TLF_G_Balaclava_TI_TUR_TLF_F"];
_helmet = ["acp_gol_TUR_TLF_H_HelmetB_TUR_TLF","acp_gol_TUR_TLF_H_HelmetB_camo_TUR_TLF","acp_gol_TUR_TLF_H_HelmetSpecB_TUR_TLF_insignia","acp_gol_TUR_TLF_H_HelmetB_light_TUR_TLF_insignia"];
_OfficerHelmet = "UK3CB_TKP_B_H_Beret";
_uniform = ["acp_gol_TUR_TLF_U_I_E_Uniform_shortsleeve_TUR_TLF_01_F_flag","acp_gol_TUR_TLF_U_I_E_Uniform_TUR_TLF_01_F_insignia","acp_gol_TUR_TLF_U_BG_Guerrilla_6_TUR_TLF_insignia","acp_gol_TUR_TLF_U_B_CTRG_Soldier_TUR_TLF_F_insignia","UK3CB_FIA_B_U_M10_CombatUniform_TRK01_01","UK3CB_FIA_B_U_M10_CombatUniform_TRK01_02","acp_gol_TUR_TLF_U_I_CombatUniform_TUR_TLF_insignia","acp_gol_TUR_TLF_U_I_CombatUniform_shortsleeve_TUR_TLF_insignia"];
_vest = ["acp_gol_TUR_TLF_V_PlateCarrier1_TUR_TLF_insignia","acp_gol_TUR_TLF_V_PlateCarrier2_TUR_TLF_insignia","acp_gol_TUR_TLF_V_CarrierRigKBT_01_light_TUR_TLF_F","acp_gol_TUR_TLF_V_PlateCarrierIA1_TUR_TLF"];
_backpack = "acp_gol_TUR_TLF_B_FieldPack_TUR_TLF";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_TUR_TLF_B_RadioBag_01_TUR_TLF_F";
};

if (_role in ["sl","tl","pl"]) then {
	_helmet = "acp_gol_TUR_TLF_H_HelmetSpecB_TUR_TLF_insignia";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "acp_gol_TUR_TLF_B_Kitbag_rgr_TUR_TLF";
};

if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "acp_gol_TUR_TLF_V_CarrierRigKBT_01_TUR_TLF_F";
};
if (_role isEqualTo "p") then {
	_helmet = "acp_gol_TUR_TLF_H_HelmetSpecter_headset_TUR_TLF_F";
	_uniform = "acp_gol_TUR_TLF_U_B_HeliPilotCoveralls_TUR_TLF";
	_vest = "acp_gol_TUR_TLF_V_TacVestIR_TUR_TLF";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_gol_TUR_TLF_U_O_PilotCoveralls_TUR_TLF";
	_vest = "acp_gol_TUR_TLF_V_TacVestIR_TUR_TLF";
	_backpack = "acp_gol_TUR_TLF_B_RadioBag_01_TUR_TLF_F";
};

_silencer = "rhsusf_acc_sfmb556";
_pointer = "uk3cb_baf_llm_flashlight_black";
_sight = "";
_bipod = "rhs_acc_grip_ffg2";

_rifle = ["hlc_rifle_416N", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_416C", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_416N_gl", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_416D20", _silencer, _pointer, "optic_erco_blk_f", "rhsusf_acc_harris_bipod"];
_rifle_mag = "hlc_30rnd_556x45_SOST_EMAG";
_rifleC_mag_tr = "hlc_30rnd_556x45_t_EMAG";
_rifleL_mag_tr = "hlc_30rnd_556x45_t_EMAG";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t_EMAG";
_rifle_mag_tr = "hlc_30rnd_556x45_t_EMAG";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, "rhs_acc_pgo7v3", _bipod];
_MAT_mag = "rhs_rpg7_PG7VM_mag";
_MAT_mag_HE = "rhs_rpg7_TBG7V_mag";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pdw = ["UK3CB_MP5K_PDW", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "30Rnd_9x21_Mag_SMG_02_Tracer_Red";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_pistol = ["hgun_P07_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "16Rnd_9x21_Mag";

_silencer = "";
_pointer = "";
_sight = "hlc_optic_leupoldm3a";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["hlc_rifle_PSG1A1_RIS", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_762x51_Mk316_Mod_0_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
