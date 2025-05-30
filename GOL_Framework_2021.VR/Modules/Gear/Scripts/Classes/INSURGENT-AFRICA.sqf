_useMineDetector = false;
_allowedNightStuff = false;

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

_allowedNightStuff = false;

_insignia = "";
_goggles = ["G_Squares_Tinted","","G_Bandanna_blk","G_Bandanna_shades",""];
_helmet = ["H_Bandanna_cbr","","","H_Beret_blk","H_Booniehat_oli","H_Cap_Oli","rhsgref_helmet_M1_painted","UK3CB_TKA_I_H_Shemag_Des","UK3CB_H_Shemag_oli","UK3CB_ARD_B_H_SSh68","H_Cap_red","UK3CB_H_Profiteer_Cap_01"];
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = ["UK3CB_ADM_B_U_Tshirt_01_TCC","UK3CB_ADM_B_U_Tshirt_01_DPM","UK3CB_ADM_B_U_Tshirt_01_WDL_03","UK3CB_ADM_B_U_Tshirt_01_WDL_02","UK3CB_ADE_O_U_02_I","UK3CB_ADE_O_U_02_J","UK3CB_ADE_O_U_02_F","UK3CB_ADE_O_U_02_K","UK3CB_ADE_O_U_02_E","UK3CB_ADE_O_U_02_H","UK3CB_ADE_O_U_02_G","UK3CB_ADE_O_U_02_B","UK3CB_ADE_O_U_02_C","UK3CB_ADE_O_U_02_D","UK3CB_ADE_O_U_02","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_5_F"];
_vest = ["rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2","UK3CB_TKP_I_V_6Sh92_Des","UK3CB_TKP_I_V_6Sh92_Radio_Des","UK3CB_TKA_I_V_6Sh92_Khk","UK3CB_TKA_I_V_6Sh92_Radio_Khk","UK3CB_V_CW_Chestrig_2_Small","UK3CB_V_Belt_Rig_Lite_KHK","UK3CB_V_Chestrig_2_Small_OLI","UK3CB_V_Chestrig_Lite_2_Small_KHK","UK3CB_V_Chestrig_OLI","UK3CB_V_Chestrig_Tan","UK3CB_TKA_I_V_vydra_3m_Tan"];
_backpack = ["rhs_sidor","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_2_K","UK3CB_B_Alice_Med_K","UK3CB_B_Fieldpack","UK3CB_UN_B_B_ASS","UK3CB_B_Bedroll_Backpack"];
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "UK3CB_B_I_Alice_Radio_Backpack";
};


if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = selectRandom ["rhs_sidor","UK3CB_CHC_C_B_HIKER","UK3CB_B_Largepack","UK3CB_B_Largepack_Med"];
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "UK3CB_CW_SOV_O_LATE_U_H_Pilot_Uniform_01_TTSKO";
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

_silencer = "rhs_acc_dtk1983";
_pointer = "rhs_acc_2dpZenit";
_sight = "";
_bipod = "";

_rifle = [["rhs_weap_akm","rhs_weap_akmn","rhs_weap_akms"], _silencer, _pointer, _sight, _bipod];
_rifleGL = [["rhs_weap_akmn_gp25","rhs_weap_akms_gp25"], _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_AK47_30Rnd_Magazine_RT";
_rifle_mag_tr = "UK3CB_AK47_30Rnd_Magazine_RT";
_rifleGL_mag = "UK3CB_AK47_30Rnd_Magazine_RT";
_rifleGL_mag_tr = "UK3CB_AK47_30Rnd_Magazine_RT";


_silencer = "rhs_acc_dtkakm";
_pointer = "rhs_acc_2dpZenit";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleL = ["UK3CB_SVD_OLD", _silencer, _pointer, _sight, _bipod];
_rifleL_mag = "UK3CB_SVD_10rnd_762x54_RT";

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifleC = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleC_mag = "rhsgref_30rnd_1143x23_M1T_2mag_SMG";


_LMG = ["rhs_weap_rpk74m", _silencer, "rhs_acc_2dpZenit", _sight, _bipod];
_LMG_mag = "UK3CB_RPK74_60rnd_545x39_RT";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "150Rnd_762x54_Box_Tracer_Red";

if(random 1 > 0.5) then {
	_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg75_mag";
	_LAT_ReUsable = false;
} else {
	_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg18_mag";
	_LAT_ReUsable = false;
};

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m2";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N1";
_rifleMarksman_mag_tr = "rhs_10Rnd_762x54mmR_7N14";