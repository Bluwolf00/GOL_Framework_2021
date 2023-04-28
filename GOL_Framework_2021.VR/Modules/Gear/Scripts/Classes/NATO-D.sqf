_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "111thID";
_goggles = ["G_Tactical_Clear","G_Balaclava_TI_blk_F","G_Balaclava_TI_G_blk_F","rhsusf_oakley_goggles_clr","rhsusf_shemagh2_gogg_od","rhsusf_shemagh_gogg_od","rhsusf_shemagh2_od","rhsusf_shemagh_od","UK3CB_G_KLR_Oli","G_Combat","UK3CB_G_Tactical_Clear"];
_helmet = ["H_HelmetB_camo","H_HelmetB","H_HelmetSpecB"];
_OfficerHelmet = "H_Beret_02";
_uniform = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"];
_vest = ["V_PlateCarrier2_rgr","V_PlateCarrierGL_mtp","V_PlateCarrierSpec_mtp","V_PlateCarrier1_rgr"];
_backpack = "B_Kitbag_mcamo";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "B_RadioBag_01_mtp_F";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "B_Carryall_mcamo";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_B";
	_vest = "V_BandollierB_khk";
};
if (_role isEqualTo "p") then {
	_helmet = "H_PilotHelmetHeli_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_TacVest_blk";
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

_silencer = "ace_muzzle_mzls_h";
_pointer = "";
_sight = "optic_hamr";
_bipod = "bipod_01_f_blk";

_rifle = ["arifle_MX_F", _silencer, _pointer, _sight, _bipod];
_rifleC = ["arifle_MXC_F", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["arifle_MX_GL_F", _silencer, _pointer, _sight, _bipod];
_rifleL = ["arifle_MXM_F", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "30Rnd_65x39_caseless_mag";
_rifle_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_rifleGL_mag = "30Rnd_65x39_caseless_mag";
_rifleGL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";
_rifleL_mag = "30Rnd_65x39_caseless_mag";
_rifleL_mag_tr = "30Rnd_65x39_caseless_mag_Tracer";

_LMG = ["arifle_MX_SW_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_65x39_caseless_mag_Tracer";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_200Rnd_762x51_T_M60E4";

_sight = "";

_LAT = ["UK3CB_BAF_AT4_CS_AT_Launcher", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_HAT = ["launch_B_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Titan_AT";

_AA = ["launch_B_Titan_F", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["hgun_Pistol_heavy_01_F", _silencer, _pointer, "optic_MRD", _bipod];
_pistol_mag = "11Rnd_45ACP_Mag";

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
