_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_shemagh_grn";
_helmet = ["UK3CB_LDF_B_H_HB97_GEO","UK3CB_LDF_B_H_HB97_ESS_GEO","UK3CB_LDF_B_H_HB97_ESS_Cover_GEO"];
_OfficerHelmet = "UK3CB_AAF_B_H_Beret_Army_Off";
_uniform = ["UK3CB_LDF_B_U_CombatUniform_WDL_01","UK3CB_LDF_B_U_CombatUniform_Shortsleeve_WDL_01"];
_vest = "UK3CB_LDF_B_V_TacVest_GEO";
_backpack = "UK3CB_B_TacticalPack_Oli";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_LDF_I_B_RadioBag_GEO";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_B_TacticalPack_Med_Oli";
};
if (_role isEqualTo "crew") then {
	_helmet = "UK3CB_LDF_B_H_CP04_GEO";
	_vest = "UK3CB_LDF_B_V_TacVest_GEO";
	_uniform = "UK3CB_LDF_B_U_Tank_Uniform_GEO";
	_goggles = "rhs_facewear_6m2_1";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_I_E";
	_uniform = "UK3CB_LDF_B_U_H_Pilot_GEO";
	_vest = "UK3CB_LDF_B_V_TacVest_GEO";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "UK3CB_LDF_B_U_J_Pilot_GEO";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "uk3cb_baf_sffh";
_pointer = "";
_sight = "rhsusf_acc_compm4";
_bipod = "rhsusf_acc_grip1";

_rifle = ["UK3CB_BAF_L119A1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_BAF_L119A1_CQB", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["UK3CB_BAF_L119A1_UKUGL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_BAF_L129A1", _silencer, _pointer, "optic_mrco", "uk3cb_underbarrel_acc_fgrip_bipod"];
_rifle_mag = "hlc_30rnd_556x45_SOST";
_rifle_mag_tr = "hlc_30rnd_556x45_t";
_rifleC_mag = "hlc_30rnd_556x45_EPR_EMAG";
_rifleGL_mag = "hlc_30rnd_556x45_SOST";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t";
_rifleL_mag = "UK3CB_BAF_762_L42A1_20Rnd_T";

_LMG = ["LMG_Mk200_black_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_65x39_cased_Box_Tracer_Red";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_200Rnd_T";

_sight = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";


_pistol = ["UK3CB_BAF_L117A2", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "16Rnd_9x21_red_Mag";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_sight = "rhs_acc_pso1m21";
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
