

_goggles = selectRandom ["rhs_facewear_6m2","rhsusf_shemagh_od","rhsusf_shemagh2_od","rhsusf_shemagh_gogg_od","rhsusf_shemagh2_gogg_od"];
_helmet = "PO_H_PASGT_TUB";
_OfficerHelmet = "PO_H_cap_tub";
_uniform = "LOP_U_Fatigue_BDU_TURK_TUBITAK_01";
_vest = "PO_V_SPCS_TUB_RIF2";
_backpack = "LOP_B_FP_MG42_tub";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["sl","tl","pl"]) then {
	_goggles = "rhs_facewear_6m2_1";
	_vest = "PO_V_SPCS_TUB_SL";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "LOP_B_KB_Med_tub";
	_vest = "PO_V_SPCS_TUB_MED";
};

if (_role in ["lr","ab"]) then {
	_backpack = "LOP_B_CA_EOD_tub";
	_vest = "PO_V_SPCS_TUB_MG";
};

if (_role in ["ar","mmg"]) then {
	_vest = "PO_V_SPCS_TUB_MG";
};

if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "PO_V_SPCS_TUB_CREW";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_zsh7a_mike_green";
	_vest = "PO_V_SPCS_TUB_CREW";
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
_bipod = "rhs_acc_grip_ffg2";

_rifle = ["hlc_rifle_hk33a2RIS", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_wp_mod733", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_hk33a2RIS_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_g3ka4", _silencer, _pointer, _sight, "rhsusf_acc_harris_bipod"];
_rifle_mag = "hlc_30rnd_556x45_SOST_HK33";
_rifle_mag_tr = "hlc_30rnd_556x45_t_HK33";
_rifleC_mag = "hlc_30rnd_556x45_SOST_EMAG";
_rifleC_mag_tr = "hlc_30rnd_556x45_t_EMAG";
_rifleL_mag = "hlc_50Rnd_762x51_B_G3";
_rifleL_mag_tr = "hlc_50Rnd_762x51_T_G3";

_LMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_250Rnd_762x51_T_MG3";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "Vorona_HEAT";
_MAT_mag_HE = "Vorona_HE";

_pistol = ["hgun_P07_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "16Rnd_9x21_Mag";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["hlc_rifle_g3ka4", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_20Rnd_762x51_Mk316_Mod_0_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
