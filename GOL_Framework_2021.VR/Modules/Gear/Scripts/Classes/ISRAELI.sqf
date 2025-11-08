_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["G_Balaclava_TI_blk_F"];
_helmet = ["acp_gol_IL_IDF_H_HelmetB_light_IL_IDF_insignia","acp_gol_IL_IDF_H_HelmetB_light_IL_IDF","acp_gol_IL_IDF_H_HelmetB_light_basic_IL_IDF"];
_OfficerHelmet = "acp_gol_IL_IDF_H_Cap_IL_IDF_hs";
_uniform = ["acp_gol_IL_IDF_U_I_CombatUniform_IL_IDF_insignia","acp_gol_IL_IDF_U_I_CombatUniform_shortsleeve_IL_IDF_insignia"];
_vest = ["acp_gol_IL_IDF_V_PlateCarrier2_IL_IDF_insignia"];
_backpack = "acp_gol_IL_IDF_B_AssaultPackEnhanced_IL_IDF_insignia";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "acp_gol_IL_IDF_B_RadioBag_01_IL_IDF_F";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "acp_gol_IL_IDF_B_Kitbag_rgr_IL_IDF";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "acp_gol_IL_IDF_B_Kitbag_rgr_IL_IDF";
};

if (_role isEqualTo "crew") then {
	_vest = "acp_gol_IL_IDF_V_PlateCarrier1_IL_IDF_insignia";
	_uniform = "acp_gol_IL_IDF_U_O_officer_noInsignia_IL_IDF_F_insignia";
};
if (_role isEqualTo "p") then {
	_uniform = "acp_gol_IL_IDF_U_B_HeliPilotCoveralls_IL_IDF";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "acp_gol_IL_IDF_V_PlateCarrier1_IL_IDF_insignia";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_gol_IL_IDF_U_O_PilotCoveralls_IL_IDF";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

// Primary Weapon
_rifle = ["arifle_TRG21_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_TRG20_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_TRG21_GL_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14_fiberglass", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "rhsusf_20Rnd_762x51_m118_special_Mag";
_rifleL_mag_tr = "rhsusf_20Rnd_762x51_m62_Mag";



_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "150Rnd_762x54_Box_Tracer_Red";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
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

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_su230a";
_bipod = "bipod_01_f_blk";

_rifleMarksman = ["rhs_weap_sr25", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_AR10_20rnd_762x51_RT";
_rifleMarksman_mag_tr = "UK3CB_AR10_20rnd_762x51_RT";