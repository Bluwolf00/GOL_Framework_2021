_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = [""];
_helmet = "acp_gol_FR_CE_H_HelmetB_light_FR_CE_insignia";
_OfficerHelmet = "UK3CB_AAF_B_H_Beret_SF_Off";
_uniform = ["acp_gol_FR_CE_U_B_CombatUniform_FR_CE_insignia","acp_gol_FR_CE_U_B_CombatUniform_vest_FR_CE_insignia"];
_vest = "acp_gol_FR_CE_V_PlateCarrier2_FR_CE";
_backpack = "acp_gol_FR_CE_B_Kitbag_rgr_FR_CE";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = ["FRXA_tf_rt1523g_big_M81","acp_gol_FR_CE_B_RadioBag_01_FR_CE_F"];
};

if (_role in ["sl","tl","pl"]) then {
	_helmet = "acp_gol_FR_CE_H_HelmetB_light_FR_CE_insignia";
	_vest = "acp_gol_FR_CE_V_PlateCarrier2_FR_CE_insignia";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "acp_gol_FR_CE_B_Kitbag_rgr_FR_CE";
	_vest = "acp_gol_FR_CE_V_PlateCarrier2_FR_CE_insignia"
};

if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "acp_gol_FR_CE_V_PlateCarrier1_FR_CE_insignia";
	_uniform = "acp_gol_FR_CE_U_B_CombatUniform_tshirt_FR_CE";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_vest = "acp_gol_FR_CE_V_PlateCarrier1_FR_CE_insignia";
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

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["arifle_SPAR_01_snd_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_SPAR_01_snd_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_SPAR_01_GL_snd_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["arifle_SPAR_02_snd_F", _silencer, _pointer, _sight, "JCA_bipod_04_sand"];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleC_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleC_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";

_LMG = ["rhs_weap_m249_light_L", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

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
_sight = "uk3cb_optic_STANAGZF2D_G3";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["UK3CB_PSG1A1", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_762x51_Mag_Tracer";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
