_useMineDetector = false;
_allowedNightStuff = true;

_glHE = "rhs_VOG25P";
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

_goggles = "Armband_Yellow_XL";
_helmet = ["UK3CB_ADA_B_H_6b27m_OLI","UK3CB_ADA_B_H_6b27m_ESS_OLI","UK3CB_ADA_B_H_6b27m_ml_ESS_OLI","UK3CB_ADA_B_H_6b27m_ESS_OLI"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_ushanka";
_uniform = selectRandom ["UK3CB_LNM_B_U_Crew_CombatSmock_05","UK3CB_LNM_B_U_Crew_CombatSmock_04","UK3CB_LNM_B_U_Crew_CombatSmock_13","UK3CB_LNM_B_U_CombatSmock_27","UK3CB_LNM_B_U_CombatSmock_36","UK3CB_LSM_B_U_CombatSmock_08","UK3CB_LSM_B_U_CombatSmock_02"];
_vest = selectRandom ["UK3CB_TKA_O_V_6b23_ml_Oli_02","UK3CB_TKA_O_V_6b23_ml_sniper_Oli"];
_backpack = "UK3CB_CHC_C_B_HIKER";
_backpackRadio = _backpack;

if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};

if(_role in ["ag","ammg"]) then {
	_backpack = "B_Carryall_green_F";
};
if (_role isEqualTo "p") then {
	_goggles = "";
	_helmet = "H_PilotHelmetHeli_O";
	_uniform = "UK3CB_LNM_B_U_CombatUniform_12";
	_vest = "UK3CB_TKA_O_V_6b23_ml_crew_Oli";
};

if(_role isEqualTo "crew") then {
	_goggles = "";
	_vest = "UK3CB_TKA_O_V_6b23_ml_crew_Oli";
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


_silencer = "rhs_acc_dtk2";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_ak74n", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74n_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_akmn", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleGL_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "hlc_75Rnd_762x39_t_rpk";

_LMG = ["hlc_rifle_rpk74n", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_t_rpk";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "RPG7_F";
_LAT_ReUsable = true;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhs_weap_pp2000_folded", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19mm_7n31_20";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";