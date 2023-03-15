_useMineDetector = false;
_allowedNightStuff = false;

_insignia = "";
_goggles = ["rhsusf_shemagh_od","rhsusf_shemagh2_od","rhsusf_shemagh_gogg_od","rhsusf_shemagh2_gogg_od","rhsusf_oakley_goggles_blk","UK3CB_G_Tactical_Clear_Gloves_Green","UK3CB_G_Tactical_Gloves_Green","UK3CB_G_Tactical_Gloves_Green_Shemagh_Green","UK3CB_G_KLR_BLK","UK3CB_G_Gloves_Green"];
_helmet = ["UK3CB_CW_US_B_LATE_H_PASGT_02_WDL","UK3CB_CW_US_B_LATE_H_PASGT_01_WDL"];
_OfficerHelmet = "UK3CB_AAF_B_H_Beret_Army_Off";
_uniform = ["UK3CB_B_U_CombatUniform_03_WDL","UK3CB_CW_US_B_LATE_U_CombatUniform_01_WDL","UK3CB_CW_US_B_LATE_U_CombatUniform_02_WDL","UK3CB_CW_US_B_LATE_U_CombatUniform_03_WDL","UK3CB_CW_US_B_LATE_U_CombatUniform_04_WDL"];
_vest = ["UK3CB_CW_US_B_LATE_V_PASGT_Crew_Vest","UK3CB_CW_US_B_LATE_V_PASGT_Medic_Vest","UK3CB_CW_US_B_LATE_V_PASGT_MG_Vest","UK3CB_CW_US_B_LATE_V_PASGT_Rif_Vest"];
_backpack = "UK3CB_B_Kitbag_WDL_01";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_ION_B_B_RadioBag_OLI";
};

if(_role in ["sl","pl"]) then {
	_uniform = "UK3CB_CW_US_B_LATE_U_JNR_OFFICER_Uniform_01_WDL";
};

if (_role in ["ag","ammg","lr","ab","hat","ahat"]) then {
	_backpack = "rhsgref_hidf_alicepack";
	_vest = "UK3CB_CW_US_B_LATE_V_PASGT_Medic_Vest";
};

if (_role isEqualTo "crew") then {
	_vest = "UK3CB_CW_US_B_LATE_V_PASGT_Crew_Vest";
};
if (_role isEqualTo "p") then {
	_helmet = "UK3CB_H_Pilot_Helmet";
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
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["hlc_wp_m16A1", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_wp_m16A1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_A1m203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "hlc_20Rnd_762x51_barrier_M14";
_rifleL_mag_tr = "hlc_20Rnd_762x51_T_M14";
_rifleC_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleC_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";

_LMG = ["hlc_lmg_m60", _silencer, _pointer, _sight, ""];
_LMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_MMG = ["hlc_lmg_m60", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";
_HAT_mag_HE = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m1911a1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_7x45acp_MHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_m8541_low_wd";
_bipod = "rhsusf_acc_harris_swivel";

_rifleMarksman = ["rhs_weap_m24sws_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_762x51_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_5Rnd_762x51_m62_Mag";
