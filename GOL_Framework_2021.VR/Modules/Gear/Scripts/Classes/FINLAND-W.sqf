
_goggles = selectRandom ["rhsusf_shemagh_gogg_grn","rhsusf_shemagh2_gogg_grn"];
_helmet = "helmet_ACH_M05";
_OfficerHelmet = "beret_Green";
_uniform = SelectRandom ["Uniform_Rolled_M05","Uniform_Full_M05"];
_vest = "V_EOD_olive_F";
_backpack = "M05_PB_Rucksack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "M05_B_RadioBag_01";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "M05_PB_Bergen";
};

if (_role in ["ar","mmg"]) then {
	_backpack = "M05_Kitbag";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_helmet";
	_vest = "vest_spc_crewman_M05";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_M05";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "vest_spc_crewman_M05";
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

// Attachments
_silencer = "";
_pointer = "rhsusf_acc_anpeq15_bk";
_sight = "rhsusf_acc_t1_high";
_bipod = "";

// Primary Weapon
_rifle = ["arifle_AK12_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_smg_mp5a3", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_AK12_GL_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_svdp", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, "rhs_acc_pso1m21", _bipod];
_rifle_mag = "hlc_30Rnd_762x39_AP_ak_Valmet";
_rifle_mag_tr = "hlc_30Rnd_762x39_t_ak_Valmet";
_rifleGL_mag = "hlc_30Rnd_762x39_AP_ak_Valmet";
_rifleGL_mag_tr = "hlc_30Rnd_762x39_t_ak_Valmet";
_rifleC_mag = "hlc_30Rnd_9x19_B_MP5";
_rifleMarksman_mag = "rhs_10Rnd_762x54mmR_7N14";
_rifleMarksman_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_100Rnd_762x54mmR_green";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["launch_NLAW_F", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

// Pistol
_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

