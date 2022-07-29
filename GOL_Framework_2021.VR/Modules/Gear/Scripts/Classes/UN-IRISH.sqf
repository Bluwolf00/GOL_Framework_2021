_useMineDetector = true;
_allowedNightStuff = false;

_insignia = "UK3CB_UN_Insignia_Peacekeepers";
_goggles = "";
_helmet = "rhsgref_helmet_pasgt_un";
_OfficerHelmet = "UK3CB_UN_B_H_Beret_Off";
_uniform = "acp_IE_DPM_U_I_CombatUniform_IE_DPM_insignia";
_vest = "acp_IE_DPM_V_PlateCarrier2_IE_DPM_insignia";
_backpack = "acp_IE_DPM_B_AssaultPackEnhanced_IE_DPM_insignia";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_IE_DPM_B_RadioBag_01_IE_DPM_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "acp_IE_DPM_B_Kitbag_rgr_IE_DPM";
};

if(_role isEqualTo "crew") then {
	_uniform = "acp_IE_DPM_U_O_officer_noInsignia_IE_DPM_F_insignia";
	_vest = "acp_IE_DPM_V_CarrierRigKBT_01_IE_DPM_F";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "acp_IE_DPM_U_B_HeliPilotCoveralls_IE_DPM";
	_vest = "acp_IE_DPM_V_CarrierRigKBT_01_IE_DPM_F";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_IE_DPM_U_O_PilotCoveralls_IE_DPM";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "gvl_x2000_wide";
_sight = "";
_bipod = "";

_rifle = ["hlc_rifle_auga1_t", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_auga1_t", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["uk3cb_auga3_gl", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_FAL5061", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_40Rnd_556x45_M_AUG";
_rifle_mag_tr = "hlc_40Rnd_556x45_M_AUG";
_rifleC_mag = "hlc_40Rnd_556x45_M_AUG";
_rifleC_mag_tr = "hlc_40Rnd_556x45_M_AUG";
_rifleGL_mag = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleGL_mag_tr = "UK3CB_AUG_42Rnd_556x45_Magazine_R";
_rifleL_mag = "UK3CB_FNFAL_30rnd_762x51_RT";
_rifleL_mag_tr = "UK3CB_FNFAL_30rnd_762x51_RT";


_LMG = ["hlc_lmg_minimipara_long_railed", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_200rnd_556x45_M_SAW";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_Barrier_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "rhs_mag_maaws_HE";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["hlc_pistol_P226R_Combat", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "hlc_15Rnd_9x19_B_P226";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "optic_lrps";
_bipod = "";

_rifleMarksman = ["hlc_rifle_awmagnum_BL", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_300WM_FMJ_AWM";
