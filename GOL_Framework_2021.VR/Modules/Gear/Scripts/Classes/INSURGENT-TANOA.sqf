
_allowedNightStuff = false;

_goggles = "";
_helmet = selectRandom ["H_Bandanna_khk","H_Booniehat_oli","PO_H_M1_OLV_2","rhs_ssh60","rhs_tsh4","",""];
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = selectRandom ["U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_1_F","U_I_C_Soldier_Camo_F"];
_vest = selectRandom ["V_Chestrig_rgr","V_BandollierB_oli","V_TacVest_oli","V_SmershVest_01_F","LOP_V_6B23_Rifleman_OLV"];
_backpack = "rhs_sidor";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "clf_Green_prc117g_co";
};

if (_role in ["lr","ab"]) then {
	_backpack = "rhs_rd54";
};

if (_role in ["ag","ammg"]) then {
	_backpack = "rhs_medic_bag";
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "Uniform_Coveralls_VZ85";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m21a", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_MP44", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_kar98k", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhsgref_30rnd_556x45_m21";
_rifleGL_mag = "rhsgref_30Rnd_792x33_SmE_StG";
_rifleC_mag = "rhsgref_30rnd_1143x23_M1911B_SMG";
_rifleL_mag = "rhsgref_5Rnd_792x57_kar98k";


_LMG = ["hlc_rifle_rpk74n", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_60Rnd_545x39_t_rpk";

_MMG = ["rhs_weap_mg42", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsgref_50Rnd_792x57_SmK_alltracers_drum";

/*
if (GVARMAIN(mod_CUP_WEAPONS)) then {
	_LMG = ["CUP_arifle_RPK74_45", _silencer, _pointer, _sight, _bipod];
	_LMG_mag = "CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M";

	_MMG = ["CUP_lmg_Pecheneg", _silencer, _pointer, _sight, _bipod];
	_MMG_mag = "CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M";
};
*/

_LAT = ["rhs_weap_panzerfaust60", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_panzerfaust60_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_silencer = "muzzle_snds_B";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "bipod_03_F_oli";

_rifleMarksman = ["rhs_weap_m1garand_sa43", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsgref_8Rnd_762x63_M2B_M1rifle";
_rifleMarksman_mag_tr = "rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle";