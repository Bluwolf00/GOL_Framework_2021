_useMineDetector = false;
_allowedNightStuff = true;

// Cloths
_goggles = SelectRandom ["G_Balaclava_TI_blk_F"];
_helmet = "rhsusf_opscore_bk_pelt";
_OfficerHelmet = "UK3CB_LSM_B_H_M88_Field_Cap_OLI";
_uniform = SelectRandom ["UK3CB_LSM_B_U_CombatSmock_07"];
_vest = selectRandom["UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI","UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI","UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_TL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_GREN_Vest_KKZ10_OLI"];
_backpack = "UK3CB_CHC_C_B_HIKER";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "rhssaf_alice_smb";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "B_Kitbag_rgr";
};

if (_role isEqualTo "crew") then {
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI";
};
if (_role isEqualTo "p") then {
	_uniform = "UK3CB_LSM_B_U_CombatSmock_07";
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
_silencer = "";
_pointer = "uk3cb_baf_llm_ir_black";
_sight = "rhsusf_acc_t1_high";
_bipod = "";

// Primary Weapon
_rifle = ["arifle_TRG21_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_TRG20_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_TRG21_GL_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14_fiberglass", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["rhs_weap_sr25", _silencer, _pointer, "optic_dms", "bipod_01_f_blk"];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "rhsusf_20Rnd_762x51_m118_special_Mag";
_rifleL_mag_tr = "rhsusf_20Rnd_762x51_m62_Mag";

_rifleMarksman_mag = "rhsusf_20Rnd_762x51_SR25_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_20Rnd_762x51_SR25_m62_Mag";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "150Rnd_762x54_Box_Tracer_Red";

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
_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";
