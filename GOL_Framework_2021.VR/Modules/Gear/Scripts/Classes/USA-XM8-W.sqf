
_goggles = "rhsusf_oakley_goggles_clr";
_helmet = selectRandom ["rhsgref_helmet_pasgt_woodland"];
_OfficerHelmet = "rhs_8point_marpatwd";
_uniform = "rhsgref_uniform_woodland";
_vest = "V_PlateCarrier1_wdl";
_backpack = "B_FieldPack_green_F";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "rhsgref_wdl_alicepack";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhsusf_cvc_green_alt_helmet";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p";
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

_silencer = "";
_pointer = "hlc_acc_ism_pcap_laser";
_sight = "hlc_optic_ism_pcap";
_bipod = "hlc_acc_vfg_pcap";

_rifle = ["HLC_rifle_XM8_Carbine", _silencer, _pointer, _sight, _bipod];
_rifleC = ["hlc_rifle_XM8_MWSF_Compact", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["HLC_rifle_XM8_Carbine_GL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "hlc_30rnd_556x45_SOST_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleL_mag = "hlc_20Rnd_762x51_barrier_M14";
_rifleL_mag_tr = "hlc_20Rnd_762x51_T_M14";
_rifleC_mag = "30Rnd_9x21_Mag_SMG_02_Tracer_Red";

_LMG = ["rhs_weap_m249", _silencer, _pointer, _sight, ""];
_LMG_mag = "rhsusf_200rnd_556x45_mixed_box";

_MMG = ["hlc_lmg_M60E4", _silencer, _pointer, _sight, ""];
_MMG_mag = "hlc_100Rnd_762x51_T_M60E4";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_pistol = ["rhsusf_weap_m1911a1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_7x45acp_MHP";

_silencer = "";
_pointer = "hlc_acc_flashlight_pcap";
_sight = "optic_erco_blk_f";
_bipod = "hlc_acc_vfg_pcap";

_rifleMarksman = ["hlc_rifle_XM8_MWSF_DMAR", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_30rnd_556x45_SOST_G36";
_rifleMarksman_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
