_useMineDetector = false;
_allowedNightStuff = true;

_glHE = "rhs_VOG25";
_glHEDP = "rhs_VOG25";
_glsmokeW = "rhs_GRD40_White";
_glsmokeB = "";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "rhs_GRD40_Red";
_glsmokeY = "";

_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";
_glflareW = "rhs_VG40OP_white";

_insignia = "";
_goggles = [
	"UK3CB_G_KLR_Oli","UK3CB_G_Gloves_Black_Shemagh_Green","UK3CB_G_Gloves_Green","UK3CB_G_Gloves_Green_Shemagh_Green_Headset",
	"G_Bandanna_oli","G_Balaclava_oli","rhs_balaclava","rhs_balaclava1_olive","rhsusf_shemagh_od","rhsusf_shemagh2_od"
];
_helmet = [
	"UK3CB_MDF_I_H_M1","UK3CB_MDF_B_H_M1_ALT","rhsgref_helmet_M1_bare",
	"rhsgref_helmet_M1_bare_alt01","rhsgref_helmet_M1_painted","rhsgref_helmet_M1_painted_alt01",
	"rhsgref_hat_m1941cap","UK3CB_ADA_I_H_M1_DPP","UK3CB_ADA_I_H_M1_Liner_DPP","rhsgref_hat_M1951",
	"UK3CB_TKA_I_H_Patrolcap_OLI","rhssaf_bandana_smb","H_Bandanna_khk"];
_OfficerHelmet = "UK3CB_MDF_B_H_Off_Beret";
_uniform = [
	"UK3CB_MDF_B_U_CombatUniform_02_LIZ_OD","UK3CB_MDF_B_U_Crew_Uniform_01","UK3CB_MDF_B_U_CombatUniform_01_LIZ",
	"rhsgref_uniform_altis_lizard","rhsgref_uniform_altis_lizard_olive","rhsgref_uniform_og107","rhsgref_uniform_og107_erdl"
];
_vest = [
	"UK3CB_MDF_B_V_TacVest_LIZ","V_TacVest_oli","rhs_vydra_3m","V_TacChestrig_oli_F","rhs_suspender_AK8_chestrig",
	"V_BandollierB_oli","rhsgref_otv_khaki","UK3CB_V_Chestrig_OLI","rhs_lifchik","rhs_lifchik_light",
	"UK3CB_V_Chestrig_Lite_2_Small_KHK","V_SmershVest_01_F","rhsgref_alice_webbing","UK3CB_V_CW_Chestrig_2_Small",
	"rhs_6sh117_rifleman","rhs_6sh117_svd","rhs_6b3","rhs_6b23_engineer","rhs_6b23_rifleman","rhs_6b23_sniper"
];

_backpack = ["UK3CB_UN_B_B_ASS","UK3CB_B_Largepack"];
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = "UK3CB_B_O_Radio_Backpack";
};

if (_role in ["ag","ammg","sm"]) then {
	_backpack = "rhs_medic_bag";
};

if(_role in ["sl","tl"]) then {
	_goggles = "Armband_Red_XL";
	_vest = "rhs_lifchik_NCO";
};

if (_role in ["lr","ab"]) then {
	_backpack = "B_Carryall_oli";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "V_BandollierB_khk";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_TacVest_blk";
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

_rifle = ["rhs_weap_m21a", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m21s", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m21a_pbg40", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m76", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhsgref_30rnd_556x45_m21";
_rifle_mag_tr = "rhsgref_30rnd_556x45_m21_t";
_rifleGL_mag = "rhsgref_30rnd_556x45_m21";
_rifleGL_mag_tr = "rhsgref_30rnd_556x45_m21_t";
_rifleL_mag = "rhsgref_10Rnd_792x57_m76";
_rifleL_mag_tr = "rhssaf_10Rnd_792x57_m76_tracer";

_LMG = ["rhs_weap_m249_pip", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["rhs_weap_m84", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhssaf_250Rnd_762x54R";

_sight = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_fim92_mag";

_pistol = ["UK3CB_CZ75", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_CZ75_9_20Rnd";

_pdw = ["rhs_weap_m92", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhssaf_30Rnd_762x39_M82_api";
_pdw_mag_tr = "rhssaf_30Rnd_762x39_M82_api";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
