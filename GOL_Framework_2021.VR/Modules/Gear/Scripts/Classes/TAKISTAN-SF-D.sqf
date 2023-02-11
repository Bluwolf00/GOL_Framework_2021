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

_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_oakley_goggles_clr";
_helmet = selectRandom ["UK3CB_TKA_O_H_6b7_1m_bala2_DES"];
_OfficerHelmet = "H_Beret_blk";
_uniform = selectRandom ["UK3CB_TKA_O_U_CombatUniform_01_ADPM","UK3CB_TKA_O_U_CombatUniform_02_ADPM","UK3CB_TKA_O_U_CombatUniform_03_ADPM"];
_vest = selectRandom ["UK3CB_ARD_B_V_6b5_Rifleman_Desert","UK3CB_ARD_B_V_6b5_Sniper_Desert","UK3CB_ARD_B_V_6b5_Desert"];
_backpack = "UK3CB_B_Alice_K";
_backpackRadio = _backpack;

if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_O_Alice_Radio_Backpack";
};

if(_role in ["pl","sl","fac"]) then {
	_vest = "UK3CB_ARD_B_V_6b5_Officer_Desert";
};

if(_role in ["r","lr"]) then {
	_backpack = "rhs_rpg_2";
};

if (_role in ["ag","ammg","sm"]) then {
	_backpack = "UK3CB_B_Alice_Med_K";
	_vest = "UK3CB_ARD_B_V_6b5_Medic_Desert";
};

if (_role isEqualTo "p") then {
	_helmet = "UK3CB_H_Pilot_Helmet";
	_uniform = "UK3CB_TKA_B_U_H_Pilot_DES";
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

_silencer = "rhs_acc_uuk";
_pointer = "rhsusf_acc_anpeq16a";
_sight = "";
_bipod = "rhs_acc_grip_ffg2";

_rifle = ["rhs_weap_ak74mr", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_aku12", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74mr_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svds", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleGL_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "rhs_10Rnd_762x54mmR_7N14";
_rifleL_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["UK3CB_BAF_L110_762", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_762_200Rnd_T";

_MMG = ["hlc_lmg_MG3KWS_b_100rnd", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_M136_hedp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_sand_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hlc_pistol_P226R_Stainless", _silencer, _pointer, "hlc_optic_docter_cadex", _bipod];
_pistol_mag = "hlc_12Rnd_357SIG_JHP_P226";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "rhsusf_acc_m24_muzzlehider_black";
_pointer = "";
_sight = "rhsusf_acc_m8541_low";
_bipod = "rhsusf_acc_harris_swivel";

_rifleMarksman = ["rhs_weap_m24sws", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_762x51_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_5Rnd_762x51_m62_Mag";