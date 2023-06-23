_useMineDetector = true;
_allowedNightStuff = false;

_insignia = "";
_goggles = "G_CBRN_A";
_helmet = "";
_OfficerHelmet = "";
_uniform = "acp_gol_CN_Type_07_Universal_U_C_CBRN_Suit_01_CN_Type_07_Universal_F";
_vest = "acp_gol_CN_Type_07_Universal_V_PlateCarrier1_CN_Type_07_Universal";
_backpack = "acp_gol_CN_Type_07_Universal_B_Kitbag_rgr_CN_Type_07_Universal";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "acp_gol_CN_Type_07_Universal_B_RadioBag_01_CN_Type_07_Universal_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "acp_gol_CN_Type_07_Universal_B_Carryall_CN_Type_07_Universal";
};

if(_role isEqualTo "crew") then {
	_uniform = "acp_gol_CN_Type_07_Universal_U_C_CBRN_Suit_01_CN_Type_07_Universal_F";
	_vest = "acp_gol_CN_Type_07_Universal_V_PlateCarrier1_CN_Type_07_Universal";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetFighter_O";
	_uniform = "acp_gol_CN_Type_07_Universal_U_O_PilotCoveralls_CN_Type_07_Universal";
	_vest = "acp_gol_CN_Type_07_Universal_V_PlateCarrier1_CN_Type_07_Universal";
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
_pointer = "";
_sight = "rhs_acc_rakurspm";
_bipod = "";

_rifle = ["hlc_rifle_SG550_TAC", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_SG550_TAC", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["hlc_rifle_SG550_TAC_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_SG550_TAC", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30Rnd_556x45_T_sg550";
_rifle_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleC_mag = "hlc_30Rnd_556x45_T_sg550";
_rifleC_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleGL_mag = "hlc_30Rnd_556x45_T_sg550";
_rifleGL_mag_tr = "hlc_30Rnd_556x45_T_sg550";
_rifleL_mag = "hlc_30Rnd_556x45_T_sg550";
_rifleL_mag_tr = "hlc_30Rnd_556x45_T_sg550";


_LMG = ["LMG_Mk200_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_65x39_cased_Box_Tracer_Red";

_MMG = ["rhs_weap_m240G", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";
_MAT_mag_HE = "rhs_rpg7_TBG7V_mag";

_HAT = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "rhs_fgm148_magazine_AT";

_AA = ["rhs_weap_fgm148", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["UK3CB_BHP", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "UK3CB_BHP_9_13Rnd";

_pdw = ["rhs_weap_pp2000_folded", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n21_20";
_pdw_mag_tr = "rhs_mag_9x19mm_7n21_20";

_silencer = "";
_pointer = "";
_sight = "optic_lrps";
_bipod = "";

_rifleMarksman = ["hlc_rifle_awmagnum_BL", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_300WM_FMJ_AWM";
