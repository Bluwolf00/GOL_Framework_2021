_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = selectRandom ["rhs_balaclava1_olive"];
_helmet = selectRandom ["rhs_altyn","rhs_altyn_visordown","rhs_altyn_novisor","rhs_altyn_novisor_ess"];
_OfficerHelmet = "rhssaf_beret_green";
_uniform = "rhssaf_uniform_m10_digital_summer";
_vest = selectRandom ["UK3CB_LDF_B_V_RIF_Vest_KKZ10_OLI","UK3CB_LDF_B_V_RIF_ALT_Vest_KKZ10_OLI"];
_backpack = "UK3CB_B_Backpack_Pocket_OLI";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_B_B_Backpack_Radio_Chem_OLI";
};
if(_role in ["tl","sl","pl"]) then {
	_vest = selectRandom ["UK3CB_LDF_B_V_TL_Vest_KKZ10_OLI","UK3CB_LDF_B_V_SL_Vest_KKZ10_OLI"];
};
if(_role in ["mmg","ar"]) then {
	_vest = selectRandom ["UK3CB_LDF_B_V_LMG_Vest_KKZ10_OLI","UK3CB_LDF_B_V_MG_Vest_KKZ10_OLI"];
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "UK3CB_B_Backpack_Med_OLI";
	_vest = "UK3CB_LDF_B_V_MD_Vest_KKZ10_OLI";
};
if (_role in ["mm","lr"]) then {
	_vest = "UK3CB_LDF_B_V_MK_Vest_KKZ10_OLI";
};
if (_role isEqualTo "crew") then {
	_uniform = "rhssaf_uniform_m10_digital_summer";
	_vest = "UK3CB_LDF_B_V_CREW_Vest_KKZ10_OLI";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_ihadss";
	_uniform = "rhssaf_uniform_m10_digital";
	_vest = "rhssaf_vest_md99_digital_radio";
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

_silencer = "hlc_muzzle_556nato_rotexiiic_grey";
_pointer = "rhsusf_acc_anpeq15side_bk";
_sight = "rhsusf_acc_eotech_xps3";
_bipod = "hlc_grip_pmvfg_black";

_rifle = ["hlc_rifle_ACR_SBR_black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_ACR_SBR_black", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_ACR_GL_SBR_black", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_ACR68_full_black", "hlc_muzzle_aac_762sdn6", _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_M";
_rifle_mag_tr = "hlc_30rnd_556x45_t";
_rifleC_mag = "hlc_30rnd_556x45_M";
_rifleC_mag_tr = "hlc_30rnd_556x45_t";
_rifleGL_mag = "hlc_30rnd_556x45_M";
_rifleGL_mag_tr = "hlc_30rnd_556x45_t";
_rifleL_mag = "hlc_30rnd_68x43_MFMJ";
_rifleL_mag_tr = "hlc_30rnd_68x43_Tracer";

_LMG = ["UK3CB_BAF_L110A3", "uk3cb_baf_silencer_l110", _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_556_200Rnd_T";

_MMG = ["UK3CB_BAF_L110_762", "uk3cb_baf_silencer_l110", _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_maaws", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "rhs_mag_maaws_HEAT";
_MAT_mag_HE = "rhs_mag_maaws_HE";

_HAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["launch_B_Titan_olive_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_glock17g4", "rhsusf_acc_omega9k", "hlc_acc_dbalpl", _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "rhsusf_acc_harris_bipod";

_rifleMarksman = ["srifle_DMR_06_hunter_F", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "20Rnd_762x51_Mag";
_rifleMarksman_mag_tr = "ACE_20Rnd_762x51_Mag_Tracer";
