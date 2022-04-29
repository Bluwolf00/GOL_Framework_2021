_useMineDetector = false;
_allowedNightStuff = true;

_goggles = "rhsusf_shemagh_grn";
_helmet = selectRandom ["helmet_lwh_OLIVE_2","helmet_lwh_OLIVE_3","helmet_lwh_OLIVE"];
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["U_I_E_Uniform_01_F","U_I_E_Uniform_01_sweater_F","U_I_E_Uniform_01_shortsleeve_F"];
_vest = "rhs_6b2_chicom";
_backpack = "B_AssaultPack_eaf_F";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_eaf_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_eaf_F";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_Beret_EAF_01_F";
	_vest = "rhs_6b2_AK";
	_uniform = "U_I_E_Uniform_01_tanktop_F";
	_goggles = "rhs_facewear_6m2_1";
};
if (_role isEqualTo "p") then {
	_helmet = "H_CrewHelmetHeli_I_E";
	_uniform = "U_I_E_Uniform_01_coveralls_F";
	_vest = "rhs_6b2";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_I_E_Uniform_01_coveralls_F";
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

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
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

_sight = "rhs_acc_pso1m21";
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
