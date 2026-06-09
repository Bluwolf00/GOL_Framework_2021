_useMineDetector = false;
_allowedNightStuff = true;

// Cloths
_insignia = "";
_goggles = "UK3CB_G_KLR_TAN";
_helmet = selectRandom ["rhsusf_mich_bare_norotos_arc_alt_tan_headset","rhsusf_mich_bare_norotos_arc_alt_tan","rhsusf_mich_bare_norotos_arc_tan"];
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = "UK3CB_ADM_B_U_CombatUniform_01_TCC";
_vest = "rhsusf_spc_patchless";
_backpack = "UK3CB_TKA_O_B_RIF_Tan";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "UK3CB_TKA_O_B_RIF_Tan_Radio";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Kitbag_tan";
};

if (_role in ["ag","ammg","sm"]) then {
	_vest = "rhsusf_spc_corpsman";
};

if (_role isEqualTo "crew") then {
	_vest = "rhsusf_spc";
	_backpack = "B_AssaultPack_cbr";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_visor";
	_vest = "rhsusf_spc";
};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};


// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "rhsusf_acc_grip2";

_rifle = ["uk3cb_auga3_blk", _silencer, _pointer, _sight, _bipod];
_rifleC = ["uk3cb_auga2_carb_blk", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["uk3cb_auga3_gl_blk", _silencer, _pointer, _sight, _bipod];
_rifleL = ["uk3cb_auga2_sr_hbar_blk", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifle_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_RT";
_rifleC_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleC_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_RT";
_rifleGL_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleGL_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_RT";
_rifleL_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleL_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_RT";

_LMG = ["UK3CB_M60", _silencer, _pointer, "optic_Hamr", _bipod];
_LMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_MMG = ["UK3CB_MG3_KWS_B", _silencer, _pointer, "optic_Hamr", _bipod];
_MMG_mag = "UK3CB_MG3_250rnd_762x51_RT";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "UK3CB_BAF_AT4_CS_AT_Mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_HAT = ["launch_B_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_JHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

// Marksman
_rifleMarksman = ["UK3CB_PSG1A1_RIS", _silencer, _pointer, "rhsusf_acc_ACOG_RMR", "JCA_bipod_04_black"];
_rifleMarksman_mag = "UK3CB_G3_20rnd_762x51_RT";
_rifleMarksman_mag_tr = "UK3CB_G3_20rnd_762x51_RT";