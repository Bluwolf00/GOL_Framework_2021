_useMineDetector = false;
_allowedNightStuff = true;

_goggles = "rhsusf_shemagh_grn";
_OfficerHelmet = "H_MilCap_dgtl";
_helmet = selectRandom ["H_HelmetHBK_headset_F","H_HelmetHBK_chops_F","H_HelmetHBK_ear_F","H_HelmetHBK_F"];
_uniform = selectRandom ["U_I_CombatUniform","U_I_CombatUniform_shortsleeve","U_I_CombatUniform_tshirt"];
_vest = selectRandom ["V_PlateCarrierIA2_dgtl","V_PlateCarrierIA1_dgtl"];
_backpack = "B_TacticalPack_oli";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_digi_F";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_oli";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
	_vest = "V_TacVest_oli";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_I";
	_uniform = "U_I_HeliPilotCoveralls";
	_vest = "V_TacVest_oli";

};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "UK3CB_BAF_LLM_Flashlight_Black";
_sight = "rksl_optic_eot552x";
_bipod = "rhsusf_acc_grip1";

_rifle = ["hlc_rifle_g3ka4", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_hk51", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["HLC_Rifle_g3ka4_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3sg1ris", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_20rnd_762x51_barrier_G3";
_rifle_mag_tr = "hlc_20rnd_762x51_T_G3";
_rifleGL_mag = "hlc_20rnd_762x51_barrier_G3";
_rifleGL_mag_tr = "hlc_20rnd_762x51_T_G3";


_LMG = ["hlc_lmg_mk46mod1_grip", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_200rnd_556x45_M_SAW";
_LMG_mag_tr = "hlc_200rnd_556x45_T_SAW";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_100Rnd";
_MMG_mag_tr = "UK3CB_BAF_762_100Rnd_T";


_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
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
_sight = "optic_LRPS_tna_F";
_bipod = "bipod_03_F_oli";

_rifleMarksman = ["srifle_DMR_03_woodland_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "20Rnd_762x51_Mag";
