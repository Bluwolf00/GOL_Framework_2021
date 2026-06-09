_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = "rhsusf_oakley_goggles_clr";
_helmet = "acp_gol_CN_Type_07_Universal_H_HelmetB_light_CN_Type_07_Universal_insignia";
_OfficerHelmet = "acp_gol_CN_Type_07_Universal_H_MilCap_CN_Type_07_Universal";
_uniform = selectRandom ["acp_gol_CN_Type_07_Universal_U_I_E_Uniform_CN_Type_07_Universal_01_F_insignia","acp_gol_CN_Type_07_Universal_U_I_E_Uniform_shortsleeve_CN_Type_07_Universal_01_F_flag","acp_gol_CN_Type_07_Universal_U_I_CombatUniform_shortsleeve_CN_Type_07_Universal_insignia"];
_vest = "acp_gol_CN_Type_07_Universal_V_CarrierRigKBT_01_light_CN_Type_07_Universal_F";
_backpack = "acp_gol_CN_Type_07_Universal_B_AssaultPackEnhanced_CN_Type_07_Universal_insignia";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "acp_gol_CN_Type_07_Universal_B_RadioBag_01_CN_Type_07_Universal_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "acp_gol_CN_Type_07_Universal_B_Carryall_CN_Type_07_Universal";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "acp_gol_CN_Type_07_Universal_U_B_HeliPilotCoveralls_CN_Type_07_Universal";
	_vest = "acp_gol_CN_Type_07_Universal_V_CarrierRigKBT_01_light_CN_Type_07_Universal_F";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "acp_gol_CN_Type_07_Universal_U_O_PilotCoveralls_CN_Type_07_Universal";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["arifle_CTAR_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_CTAR_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_CTAR_GL_blk_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["srifle_DMR_07_blk_F", _silencer, _pointer, "optic_arco_blk_f", _bipod];
_rifle_mag = "30Rnd_580x42_Mag_F";
_rifle_mag_tr = "30Rnd_580x42_Mag_Tracer_F";
_rifleGL_mag = "30Rnd_580x42_Mag_F";
_rifleGL_mag_tr = "30Rnd_580x42_Mag_Tracer_F";
_rifleC_mag = "30Rnd_580x42_Mag_F";
_rifleC_mag_tr = "30Rnd_580x42_Mag_Tracer_F";
_rifleL_mag = "ACE_20Rnd_65_Creedmor_mag";
_rifleL_mag_tr = "ACE_20Rnd_65_Creedmor_mag";

_LMG = ["arifle_CTARS_blk_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_580x42_Mag_Tracer_F";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "150Rnd_762x51_Box_Tracer";

_sight = "";

_LAT = ["rhs_weap_rpg26", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg26_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";
_MAT_mag_HE = "rhs_rpg7_OG7V_mag";

_HAT = ["launch_O_Vorona_brown_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["launch_O_Titan_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhs_weap_pya", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x19_7n31_17";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21";
_bipod = "";

_rifleMarksman = ["rhs_weap_svds", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_SVD_10rnd_762x54_GT";
_rifleMarksman_mag_tr = "UK3CB_SVD_10rnd_762x54_GT";
