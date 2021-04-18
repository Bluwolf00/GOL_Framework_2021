
_goggles = "";
_helmet = "helmet_plain_MTP";
_uniform = "Uniform_Full_MTP";
_vest = "vest_spc_rifleman_MTP";
_backpack = "MTP_Kitbag";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_mtp_big_rt1523g";
};

if (_role isEqualTo "sl") then {
	_vest = "vest_spc_radio_MTP";
};
if (_role in ["ag","ammg"]) then {
	_backpack = "BRITISH_Assaultpack_Medic";
};
if (_role isEqualTo "crew") then {
	_helmet = "H_HelmetCrew_I";
	_vest = "vest_spc_crewman_MTP";
};
if (_role isEqualTo "p") then {
	_helmet = "rhsusf_hgu56p_visor_black";
	_uniform = "Uniform_Coveralls_MTP";
	_vest = "vest_spc_crewman_MTP";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "Uniform_Coveralls_MTP";
	_vest = "V_Rangemaster_belt";
	_backpack = _backpackRadio;
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["L85A3_LDS_Flashlight", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_BAF_L22A2", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["L85A3UGL_EOT552_Flashlight", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_BAF_556_30Rnd";
_rifle_mag_tr = "UK3CB_BAF_556_30Rnd_T";
_rifleC_mag = "UK3CB_BAF_556_30Rnd";

_LMG = ["UK3CB_BAF_L110A2RIS", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_BAF_556_200Rnd_T";

_MMG = ["UK3CB_BAF_L7A2", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "UK3CB_BAF_762_100Rnd_T";

_LAT = ["rhs_weap_M136_hedp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";

_pistol = ["rhsusf_weap_glock17g4", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_17Rnd_9x19_JHP";

_silencer = "uk3cb_baf_silencer_l115a3";
_pointer = "";
_sight = "optic_LRPS";
_bipod = "";

_rifleMarksman = ["UK3CB_BAF_L115A3", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_BAF_338_5Rnd";
_rifleMarksman_mag_tr = "UK3CB_BAF_338_5Rnd_Tracer";
