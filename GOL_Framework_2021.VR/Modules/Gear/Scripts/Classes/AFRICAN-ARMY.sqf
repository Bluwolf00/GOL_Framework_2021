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

_goggles =  ["Armband_Red_large"];
_helmet =  ["UK3CB_ADA_O_H_6b27m_ml_DPP_01","UK3CB_ADA_B_H_6b27m_ml_ESS_DPP_01","UK3CB_ADA_B_H_6b27m_ml_ESS_DPP_02","UK3CB_ADA_B_H_6b27m_ml_DPP_02","UK3CB_ABP_B_H_6b27m_DES","UK3CB_ABP_B_H_6b27m_ess_DES"];
_OfficerHelmet = "UK3CB_ADA_B_H_Off_Beret";
_uniform =  ["UK3CB_ADA_O_U_CombatUniform_01_DPP","UK3CB_ADA_B_U_CombatUniform_DPP_OLI","UK3CB_ADA_B_U_JNR_Officer_Uniform_01_DPP","UK3CB_ADA_B_U_JNR_Officer_Uniform_DPP_OLI"];
_vest =  ["rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2"];
_backpack =  ["UK3CB_ADA_O_B_ASS","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_2_K","UK3CB_B_Alice_Med_K","UK3CB_B_Fieldpack","UK3CB_UN_B_B_ASS","UK3CB_B_Bedroll_Backpack"];
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = ["UK3CB_B_I_Alice_Radio_Backpack"];
};

if(_role isEqualTo "officer") then {
	_vest = "UK3CB_ARD_B_V_6b5_Officer_Desert";
	_uniform = "UK3CB_ADA_B_U_Officer_Uniform_01_DPP";
	_backpackRadio = "rhs_r148";
};
if(_role isEqualTo "crew") then {
	_helmet = selectRandom ["UK3CB_ARD_B_H_Crew_Cap_Ess","UK3CB_H_Crew_Cap"];
	_vest = "rhs_6b2_holster";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = selectRandom ["rhs_sidor","UK3CB_CHC_C_B_HIKER","UK3CB_B_Largepack","UK3CB_B_Largepack_Med"];
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "UK3CB_ADA_B_U_SF_CombatUniform_03_TTC";
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
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_aks74", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_aks74_gp25", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_545x39_Mag_F";
_rifle_mag_tr = "30Rnd_545x39_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_545x39_Mag_F";
_rifleGL_mag_tr = "30Rnd_545x39_Mag_Tracer_F";


_silencer = "rhs_acc_dtkakm";
_pointer = "";
_sight = "";
_bipod = "";

_rifleL = ["rhs_weap_akms", _silencer, _pointer, _sight, _bipod];
_rifleL_mag = "rhs_30Rnd_762x39mm_bakelite_tracer";

_silencer = "rhs_acc_pgs64_74u";
_pointer = "";
_sight = "";
_bipod = "";

_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];

_LMG = ["rhs_weap_rpk74m", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_RPK74_60rnd_545x39_GT";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg18_mag";
_LAT_ReUsable = false;

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