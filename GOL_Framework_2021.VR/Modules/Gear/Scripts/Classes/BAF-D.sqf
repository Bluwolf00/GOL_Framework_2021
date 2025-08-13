_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles =  ["rhsusf_shemagh_tan","rhsusf_shemagh2_tan","rhsusf_oakley_goggles_clr"];
_helmet = ["acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_MK7_GB_DDPM_F","acp_gol_GB_DDPM_H_HelmetSpecB_GB_DDPM_insignia"];
_OfficerHelmet = "UK3CB_ANA_B_H_Beret_GRN";
_uniform =  ["acp_gol_GB_DDPM_U_I_CombatUniform_shortsleeve_GB_DDPM_insignia","acp_gol_GB_DDPM_U_I_CombatUniform_GB_DDPM_insignia"];
_vest = ["acp_gol_GB_DDPM_V_CarrierRigKBT_01_light_GB_DDPM_F","acp_gol_GB_DDPM_V_PlateCarrier2_GB_DDPM_insignia","acp_gol_GB_DDPM_V_PlateCarrier1_GB_DDPM"];
_backpack = ["acp_gol_GB_DDPM_B_TacticalPack_GB_DDPM"];
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = ["acp_gol_GB_DDPM_B_RadioBag_01_GB_DDPM_F"];
};

if (_role in ["ag","ammg","lr","ab","atab"]) then {
	_backpack = "acp_gol_GB_DDPM_B_TacticalPack_GB_DDPM";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "acp_gol_GB_DDPM_V_PlateCarrier1_GB_DDPM";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_visor_black";
	_uniform = "UK3CB_ADM_B_U_CombatUniform_01_WDL";
	_vest = "acp_gol_GB_DDPM_V_PlateCarrier1_GB_DDPM";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "Uniform_Coveralls_MTP";
	_vest = "V_Rangemaster_belt";
	_backpack = _backpackRadio;
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["UK3CB_BAF_L85A2", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_BAF_L22", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["UK3CB_BAF_L85A2_UGL_HWS", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_BAF_L86A2", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifle_mag_tr = "UK3CB_BAF_556_30Rnd_T";
_rifleGL_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleGL_mag_tr = "UK3CB_BAF_556_30Rnd_T";
_rifleC_mag = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";

_LMG = ["UK3CB_BAF_L110A2", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_556_200Rnd_T";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_100Rnd_T";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_sand_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_JHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_ACOG_RMR";
_bipod = "";

_rifleMarksman = ["UK3CB_BAF_L129A1", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_BAF_762_L42A1_20Rnd_T";
_rifleMarksman_mag_tr = "UK3CB_BAF_762_L42A1_20Rnd_T";
