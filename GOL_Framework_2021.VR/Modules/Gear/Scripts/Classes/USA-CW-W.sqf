_useMineDetector = false;
_allowedNightStuff = false;

_goggles = "rhsusf_oakley_goggles_clr";
_helmet = selectRandom ["rhsgref_helmet_pasgt_woodland"];
_OfficerHelmet = "rhs_8point_marpatwd";
_uniform = "rhsgref_uniform_woodland";
_vest = "V_PlateCarrier1_wdl";
_backpack = "B_FieldPack_green_F";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhsgref_wdl_alicepack";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_alt_helmet";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p";
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

_rifle = ["hlc_wp_m16a2", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_smg_mp5a2_tac", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_m203", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "ACE_30Rnd_556x45_Stanag_Mk262_mag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "hlc_20Rnd_762x51_barrier_M14";
_rifleL_mag_tr = "hlc_20Rnd_762x51_T_M14";
_rifleC_mag = "30Rnd_9x21_Mag_SMG_02_Tracer_Red";

_LMG = ["rhs_weap_m249", _silencer, _pointer, _sight, ""];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m1911a1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_7x45acp_MHP";

_silencer = "";
_pointer = "";
_sight = "rhsusf_acc_m8541_low_wd";
_bipod = "rhsusf_acc_harris_swivel";

_rifleMarksman = ["rhs_weap_m24sws_wd", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_762x51_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_5Rnd_762x51_m62_Mag";
