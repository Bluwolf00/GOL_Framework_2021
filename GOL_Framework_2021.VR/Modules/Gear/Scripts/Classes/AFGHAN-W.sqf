_useMineDetector = true;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["","rhsusf_shemagh_od","rhsusf_shemagh2_od","UK3CB_G_Tactical_Gloves_Green_Shemagh_Green_Headset","UK3CB_G_Neck_Shemag_KR_blk","UK3CB_G_Neck_Shemag_KL_blk","UK3CB_G_Neck_Shemag_KLR_blk"];
_helmet = ["H_PASGT_basic_olive_F"];
_OfficerHelmet = "UK3CB_ANA_B_H_OFF_Beret_GRN";
_uniform = ["UK3CB_ANA_B_U_CombatUniform_01_SPEC4CE","UK3CB_ANA_B_U_CombatUniform_Shortsleeve_01_SPEC4CE","UK3CB_ANA_B_U_CombatUniform_02_SPEC4CE","UK3CB_ANA_B_U_CombatUniform_Shortsleeve_02_SPEC4CE","UK3CB_ANA_B_U_CombatUniform_01_WDL","UK3CB_ANA_B_U_CombatUniform_Shortsleeve_01_WDL","UK3CB_ANA_B_U_CombatUniform_02_WDL","UK3CB_ANA_B_U_CombatUniform_Shortsleeve_02_WDL"];
_vest = ["UK3CB_ANA_B_V_MD_Vest_WDL_01","UK3CB_ANA_B_V_MK_Vest_WDL_01","UK3CB_ANA_B_V_RFL_Vest_WDL_01","UK3CB_ANA_B_V_SL_Vest_WDL_01","UK3CB_ANA_B_V_Vest_WDL_01","UK3CB_ANA_B_V_CREW_Vest_WDL","UK3CB_ANA_B_V_MG_Vest_WDL_01"];
_backpack = "rhs_rd54";
_backpackRadio = _backpack;
if (true) then {
	_backpackRadio = "UK3CB_ANA_B_B_RIF_Radio";
};
if(_role isEqualTo "r") then {
	_backpack = "rhs_rpg_2";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_cbr";
	_vest = "UK3CB_ANA_B_V_MD_Vest_WDL_01";
};

if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_HeliPilotCoveralls";
	_vest = "UK3CB_ANA_B_V_Vest_WDL_01";
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
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m4a1_carryhandle", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m4a1_carryhandle", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m4a1_carryhandle_m203S", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m4a1_carryhandle", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifle_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleGL_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifleGL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleC_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifleC_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleL_mag = "rhs_mag_30Rnd_556x45_Mk318_Stanag";
_rifleL_mag_tr = "30Rnd_556x45_Stanag_Tracer_Red";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["rhs_weap_m240G", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhsusf_100Rnd_762x51_m62_tracer";

_sight = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_m72a7_mag";
_LAT_ReUsable = false;

_MAT = ["rhs_weap_rpg7", _silencer, _pointer, "rhs_acc_pgo7v3", _bipod];
_MAT_mag = "rhs_rpg7_PG7VM_mag";
_MAT_mag_HE = "rhs_rpg7_OG7V_mag";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_JHP";

_pdw = ["UK3CB_MP5A4", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_R";
_pdw_mag_tr = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";

_silencer = "";
_pointer = "";
_sight = "rhs_acc_pso1m21_svd";
_bipod = "";

_rifleMarksman = ["rhs_weap_svdp", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "ACE_10Rnd_762x54_Tracer_mag";
