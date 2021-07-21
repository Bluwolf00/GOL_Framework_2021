
_goggles = selectRandom ["rhsusf_shemagh2_grn","rhsusf_shemagh_grn"];
_helmet = ["helmet_ACH_VZ95_2","helmet_ACH_VZ95_4","helmet_ACH_VZ95_3","helmet_ACH_VZ95"] call BIS_fnc_selectRandom;
_OfficerHelmet = "cap_VZ95";
_uniform = selectRandom ["Uniform_Rolled_VZ95","Uniform_Full_VZ95"];
_vest = selectRandom ["vest_spc_radio_VZ95","vest_spc_rifleman_VZ95"];
_backpack = "VZ95_PB_Rucksack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_VZ95_big_rt1523g";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "VZ95_PB_Bergen";
};

if (_role isEqualTo "p") then {
	_helmet = "helmet_lwh_VZ95";
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

_silencer = "hlc_muzzle_SF3P_556";
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "optic_ERCO_blk_F";
_bipod = "";

// Primary Weapon
_rifle = ["hlc_rifle_ACR_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_smg_mp5a3", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_ACR_GL_carb_black", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_ACR_carb_black", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR";
_rifle_mag_tr = "hlc_30rnd_556x45_t_PMAG";
_rifleC_mag = "hlc_30Rnd_9x19_B_MP5";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_pistol = ["rhs_weap_pya", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19_17";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";
