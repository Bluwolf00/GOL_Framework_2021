_useMineDetector = true;
_allowedNightStuff = false;

_goggles = "rhsusf_shemagh_grn";
_helmet = selectRandom ["helmet_lwh_OLIVE_2","helmet_lwh_OLIVE_3","helmet_lwh_OLIVE"];
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["U_I_E_Uniform_01_F","U_I_E_Uniform_01_sweater_F","U_I_E_Uniform_01_shortsleeve_F"];
_vest = "rhs_6b2_chicom";
_backpack = "B_AssaultPack_eaf_F";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_eaf_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_eaf_F";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_Beret_EAF_01_F";
	_vest = "rhs_6b2_AK";
};
if (_role isEqualTo "p") then {
	_helmet = "H_CrewHelmetHeli_I_E";
	_uniform = "U_B_PilotCoveralls";
	_vest = "rhs_6b2";
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

_silencer = "rhs_acc_dtk1983";
_pointer = "";
_sight = "rhsusf_acc_eotech_552";
_bipod = "rhsusf_acc_grip1";

_rifle = ["rhs_weap_ak74mr", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_aku12", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74mr_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_BAF_L128A1", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_60Rnd_545X39_7N22_AK";
_rifle_mag_tr = "rhs_60Rnd_545X39_AK_Green";
_rifleC_mag = "hlc_30Rnd_545x39_t_ak_Black";
_rifleGL_mag = "rhs_60Rnd_545X39_7N22_AK";
_rifleGL_mag_tr = "rhs_60Rnd_545X39_AK_Green";
_rifleL_mag = "UK3CB_BAF_12G_Pellets";

_LMG = ["arifle_RPK12_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "hlc_75Rnd_762x39_t_rpk";

_MMG = ["rhs_weap_fnmag", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT55_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_FMJ";

_sight = "rhs_acc_pso1m21";
_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "10Rnd_338_Mag";
_rifleMarksman_mag_tr = "10Rnd_338_Mag";
