_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["G_Balaclava_TI_G_tna_F","G_Balaclava_TI_tna_F"];
_helmet = ["H_HelmetB_TI_tna_F"];
_OfficerHelmet = "UK3CB_ANA_B_H_Beret_MAR";
_uniform = ["U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_3_F","U_B_CTRG_Soldier_2_F"];
_vest = "acp_gol_GB_DPM95_V_PlateCarrier2_GB_DPM95_insignia";
_backpack = "acp_gol_GB_DPM95_B_Kitbag_rgr_GB_DPM95";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_GB_DPM95_B_RadioBag_01_GB_DPM95_F";
};

if (_role isEqualTo "sl") then {

};

if(_role isEqualTo "ftl") then {

};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "acp_gol_GB_DPM95_B_TacticalPack_GB_DPM95";
};
if (_role in ["ar","mmg"]) then {

};

if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
};
if (_role isEqualTo "p") then {
	_helmet = "H_CrewHelmetHeli_B";
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
_pointer = "";
_sight = "";
_bipod = "";

// Primary Weapon
_rifle = [["UK3CB_ACR_Rifle","UK3CB_ACR_Carbine"], _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_ACR_Crew", _silencer, _pointer, _sight, _bipod];
_rifleGL = [["UK3CB_ACR_Carbine_UGL"], _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_ACR_Rifle_Long", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifle_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleGL_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleGL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleC_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleC_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";
_rifleL_mag = "rhs_mag_30Rnd_556x45_Mk262_Stanag";
_rifleL_mag_tr = "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red";

_LMG = ["UK3CB_BAF_L110A3", _silencer, _pointer, _sight, ""];
_LMG_mag = "UK3CB_BAF_556_200Rnd_T";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, ""];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["UK3CB_P320_BLK", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_P320_9x19_17Rnd";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "uk3cb_baf_silencer_l115a3";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "uk3cb_underbarrel_acc_bipod";

_rifleMarksman = ["UK3CB_BAF_L118A1_Covert_BL", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_BAF_338_5Rnd";
_rifleMarksman_mag_tr = "UK3CB_BAF_762_L42A1_10Rnd_T";
