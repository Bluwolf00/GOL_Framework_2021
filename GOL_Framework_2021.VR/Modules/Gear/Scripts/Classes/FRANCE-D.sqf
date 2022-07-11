_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "UK3CB_UN_Insignia_Peacekeepers";

_goggles = selectRandom ["UK3CB_G_Balaclava_DES"];
_helmet = "H_HelmetB_light_desert";
_OfficerHelmet = "UK3CB_AAF_B_H_Beret_SF_Off";
_uniform = "UK3CB_ADM_B_U_CombatUniform_01_DDPM";
_vest = "UK3CB_AAF_I_V_Falcon_7_DIGI_BRN";
_backpack = "UK3CB_B_Alice_K";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_B_Alice_Radio_Backpack";
};

if (_role in ["sl","tl","pl"]) then {
	_helmet = "H_HelmetB_light_desert";
	_vest = "UK3CB_AAF_I_V_Falcon_3_DIGI_BRN";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "B_Carryall_cbr";
	_vest = "UK3CB_AAF_I_V_Falcon_3_DIGI_BRN"
};

if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "UK3CB_AAF_I_V_Falcon_1_DIGI_BRN";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_zsh7a_mike_green";
	_vest = "UK3CB_AAF_I_V_Falcon_1_DIGI_BRN";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "rhsusf_acc_sf3p556";
_pointer = "rhsusf_acc_wmx_bk";
_sight = "optic_mrco";
_bipod = "rhs_acc_grip_ffg2";

_rifle = ["UK3CB_FAMAS_F1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_FAMAS_F1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["UK3CB_FAMAS_F1_GLM203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_hk416d145", _silencer, _pointer, _sight, "rhsusf_acc_harris_bipod"];
_rifle_mag = "UK3CB_FAMAS_25rnd_556x45_R";
_rifle_mag_tr = "UK3CB_FAMAS_25rnd_556x45_RT";
_rifleC_mag_tr = "UK3CB_FAMAS_25rnd_556x45_RT";
_rifleC_mag = "UK3CB_FAMAS_25rnd_556x45_R";
_rifleGL_mag_tr = "UK3CB_FAMAS_25rnd_556x45_RT";
_rifleGL_mag = "UK3CB_FAMAS_25rnd_556x45_R";
_rifleL_mag = "hlc_30rnd_556x45_SOST_PMAG";
_rifleL_mag_tr = "hlc_30rnd_556x45_t_PMAG";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["UK3CB_BAF_L110_762", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_sight = "";

_LAT = ["rhs_weap_M136", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_olive_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pdw = ["UK3CB_MP5K_PDW", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "30Rnd_9x21_Mag_SMG_02_Tracer_Red";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_pistol = ["UK3CB_USP", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_USP_9_15Rnd";

_silencer = "";
_pointer = "";
_sight = "hlc_optic_leupoldm3a";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["hlc_rifle_PSG1A1_RIS", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_762x51_Mk316_Mod_0_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
