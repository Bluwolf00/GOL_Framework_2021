_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["JCA_G_FaceMask_01_olive_F","JCA_G_balaclava_01_olive_F","rhsusf_shemagh_grn","rhsusf_oakley_goggles_clr"];
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
_silencer = "JCA_muzzle_snds_556_enhanced_olive";
_pointer = "";
_sight = "JCA_arifle_SCAR_L_short_olive_F";
_bipod = "JCA_bipod_04_olive";

_rifle = ["JCA_arifle_SCAR_L_olive_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["JCA_arifle_SCAR_L_short_olive_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["JCA_arifle_SCAR_L_GL_olive_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["JCA_arifle_SCAR_H_olive_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "GOL_30Rnd_556x45_AP45_Mixed_Red";
_rifle_mag_tr = "GOL_30Rnd_556x45_AP45_Tracer_Red";
_rifleGL_mag = "GOL_30Rnd_556x45_AP45_Mixed_Red";
_rifleGL_mag_tr = "GOL_30Rnd_556x45_AP45_Tracer_Red";
_rifleC_mag = "GOL_30Rnd_556x45_AP45_Mixed_Red";
_rifleC_mag_tr = "GOL_30Rnd_556x45_AP45_Tracer_Red";
_rifleL_mag = "JCA_20Rnd_762x51_SCAR_Red_Mag";
_rifleL_mag_tr = "JCA_20Rnd_762x51_SCAR_Tracer_Red_Mag";

_LMG = ["GOL_LMG_Mk200_F", "muzzle_snds_65_TI_blk_F", _pointer, _sight, "bipod_03_F_blk"];
_LMG_mag = "GOL_200Rnd_65x39_cased_Box_Tracer_Red";

_MMG = ["GOL_MG3_KWS_B", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "GOL_MG3_250Rnd_762x51_M993_SLAP_Tracer_Red";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_olive_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "GOL_mag_MRAWS_HEDP_F";

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
