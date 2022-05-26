_useMineDetector = false;
_allowedNightStuff = true;

_goggles = selectRandom ["rhsusf_shemagh2_tan","rhsusf_shemagh_tan","rhsusf_shemagh_gogg_tan","rhsusf_shemagh2_gogg_tan"];
_helmet = ["H_HelmetB_light_desert"] call BIS_fnc_selectRandom;
_OfficerHelmet = "rhs_fieldcap_m88";
_uniform = selectRandom ["UK3CB_ADM_B_U_CombatUniform_01_DDPM","UK3CB_ADM_B_U_CombatUniform_Shortsleeve_01_DDPM"];
_vest = selectRandom["rhsusf_spc_patchless_radio","rhsusf_spc_patchless"];
_backpack = "UK3CB_B_Alice_K";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_B_Alice_Radio_Backpack";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "B_Carryall_cbr";
};

if(_role in ["crew"]) then {
	_helmet = "H_HelmetCrew_I";
	_goggles = "";
	_vest = "rhsusf_spc"
};

if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_tan";
	_vest = "rhsusf_spc";
	_goggles = "";
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

_silencer = "";
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "optic_ERCO_blk_F";
_bipod = "";

// Primary Weapon
_rifle = ["hlc_rifle_ACR_carb_tan", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_ACR_SBR_tan", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_ACR_GL_carb_tan", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_ACR_carb_tan", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR";
_rifle_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleGL_mag = "hlc_30rnd_556x45_EPR";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleC_mag = "hlc_30rnd_556x45_EPR";
_rifleC_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleL_mag = "hlc_30rnd_556x45_EPR";
_rifleL_mag_tr = "hlc_30rnd_556x45_t_PMAG";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, "optic_hamr", _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_sand_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["launch_B_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhs_weap_pya", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19_17";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
