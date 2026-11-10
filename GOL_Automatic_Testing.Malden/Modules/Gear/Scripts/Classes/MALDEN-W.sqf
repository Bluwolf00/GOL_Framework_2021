_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["rhs_balaclava1_olive","rhs_balaclava","UK3CB_G_KLR_BLK","UK3CB_G_KR_BLK","UK3CB_G_KL_BLK"];
_helmet = ["rhsgref_helmet_pasgt_altis_lizard"];
_OfficerHelmet = "UK3CB_MDF_B_H_Off_Beret";
_uniform = [
	"rhsgref_uniform_altis_lizard"
];
_vest = [
	"UK3CB_LDF_B_V_TL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI",
	"UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI"
];
_backpack = ["UK3CB_ION_B_B_RIF_OLI_01"];
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "FRXA_tf_rt1523g_big_Ranger_Green";
};
if (_role in ["ag","ammg","sm"]) then {
	_backpack = "B_Carryall_oli";
	_vest = "UK3CB_LDF_B_V_MD_Vest_KKZ10_OLI"
};

if (_role in ["lr","ab"]) then {
	_backpack = "B_Carryall_oli";
	_vest = "UK3CB_LDF_B_V_MK_Vest_KKZ10_OLI"
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI"
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

_LMG = ["rhs_weap_m249_light_L", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["UK3CB_M60", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_sight = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_fim92_mag";

_pistol = ["UK3CB_CZ75", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_CZ75_9_20Rnd";

_pdw = ["rhs_weap_m92", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhssaf_30Rnd_762x39_M82_api";
_pdw_mag_tr = "rhssaf_30Rnd_762x39_M82_api";

_sight = "rhs_acc_pso1m21";
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_SVD_10rnd_762x54_RT";
_rifleMarksman_mag_tr = "UK3CB_SVD_10rnd_762x54_RT";