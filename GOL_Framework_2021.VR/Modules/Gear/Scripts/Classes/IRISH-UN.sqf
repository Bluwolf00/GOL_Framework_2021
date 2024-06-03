_useMineDetector = true;
_allowedNightStuff = false;

_insignia = "UK3CB_UN_Insignia_Peacekeepers";
_goggles = "";
_helmet = "rhsgref_helmet_pasgt_un";
_OfficerHelmet = "UK3CB_UN_B_H_Beret_Off";
_uniform = "acp_gol_IE_DPM_U_I_CombatUniform_IE_DPM_insignia";
_vest = "acp_gol_IE_DPM_V_PlateCarrier2_IE_DPM_insignia";
_backpack = "acp_gol_IE_DPM_B_AssaultPackEnhanced_IE_DPM_insignia";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_IE_DPM_B_RadioBag_01_IE_DPM_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "acp_gol_IE_DPM_B_Kitbag_rgr_IE_DPM";
};

if(_role isEqualTo "crew") then {
	_uniform = "acp_gol_IE_DPM_U_O_officer_noInsignia_IE_DPM_F_insignia";
	_vest = "acp_gol_IE_DPM_V_CarrierRigKBT_01_IE_DPM_F";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "acp_gol_IE_DPM_U_B_HeliPilotCoveralls_IE_DPM";
	_vest = "acp_gol_IE_DPM_V_CarrierRigKBT_01_IE_DPM_F";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_gol_IE_DPM_U_O_PilotCoveralls_IE_DPM";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "gvl_x2000_wide";
_sight = "";
_bipod = "";

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


_LMG = ["rhs_weap_m249_pip_S_para", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["UK3CB_M60", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";
_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "rhs_mag_maaws_HE";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["UK3CB_USP", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_USP_9_15Rnd";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "optic_lrps";
_bipod = "";

_rifleMarksman = ["rhs_weap_m24sws", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsusf_5Rnd_762x51_m993_Mag";
