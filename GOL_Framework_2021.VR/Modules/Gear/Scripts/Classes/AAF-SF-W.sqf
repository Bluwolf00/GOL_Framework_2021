_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["rhssaf_veil_Green"];
_OfficerHelmet = "UK3CB_AAF_B_H_Beret_SF_Off";
_helmet = ["UK3CB_AAF_I_H_MKVI_Helmet_B_GRN","H_HelmetHBK_chops_F","H_HelmetHBK_ear_F","H_HelmetHBK_F"];
_uniform = ["UK3CB_AAF_B_U_CombatUniform_DIGI_GRN","UK3CB_AAF_B_U_CombatUniform_Shortsleeve_DIGI_GRN","U_I_CombatUniform_tshirt"];
_vest = ["UK3CB_AAF_I_V_Falcon_3_DIGI_GRN","UK3CB_AAF_I_V_Falcon_4_DIGI_GRN","UK3CB_AAF_I_V_Falcon_5_DIGI_GRN","UK3CB_AAF_I_V_Falcon_6_DIGI_GRN","UK3CB_AAF_I_V_Falcon_7_DIGI_GRN","UK3CB_AAF_I_V_Falcon_8_DIGI_GRN","UK3CB_AAF_I_V_Falcon_9_DIGI_GRN"];
_backpack = ["UK3CB_AAF_B_B_FIELDPACK_DIGI_GRN"];
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = ["UK3CB_AAF_B_B_FIELDPACK_DIGI_GRN_Radio"];
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_AAF_B_B_CARRYALL_DIGI_GRN";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
	_vest = "UK3CB_V_Falcon_1";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_I";
	_uniform = "UK3CB_AAF_I_U_H_Pilot_DIGI_GRN";
	_vest = "V_TacVest_oli";

};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "";
	_helmet = "RHS_jetpilot_usaf";
	_uniform = "UK3CB_AAF_I_U_J_Pilot_DIGI_GRN";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_g36kv", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_g36c", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_g36kv_ag36", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_G3SG1_RIS", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhssaf_30rnd_556x45_SOST_G36";
_rifle_mag_tr = "rhssaf_30rnd_556x45_Tracers_G36";
_rifleGL_mag = "rhssaf_30rnd_556x45_SOST_G36";
_rifleGL_mag_tr = "rhssaf_30rnd_556x45_Tracers_G36";
_rifleC_mag = "rhssaf_30rnd_556x45_SOST_G36";
_rifleC_mag_tr = "rhssaf_30rnd_556x45_Tracers_G36";
_rifleL_mag = "UK3CB_G3_50rnd_762x51_R";
_rifleL_mag_tr = "UK3CB_G3_50rnd_762x51_RT";

_LMG = ["rhs_weap_m249_light_L", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["UK3CB_MG3_KWS_B", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_MG3_250rnd_762x51_RT";


_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_olive_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["launch_I_Titan_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["hgun_ACPC2_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "9Rnd_45ACP_Mag";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_ACOG_RMR";
_bipod = "bipod_03_F_oli";

_rifleMarksman = ["srifle_DMR_03_woodland_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_762x51_Mag_Tracer";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
