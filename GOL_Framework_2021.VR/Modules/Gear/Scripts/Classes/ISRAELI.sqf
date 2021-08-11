// Cloths
_goggles = SelectRandom ["dzn_G_IDF_Mitznefet_Cover","dzn_G_IDF_Mitznefet_Cover4","dzn_G_IDF_Mitznefet_Cover3","dzn_G_IDF_Mitznefet_Cover2"];
_helmet = "helmet_lwh_OLIVE";
_OfficerHelmet = "cap_OLIVE";
_uniform = SelectRandom ["Uniform_Full_OLIVE","Uniform_Rolled_OLIVE"];
_vest = selectRandom ["vest_spc_radio_OLIVE","vest_spc_rifleman_OLIVE"];
_backpack = "OLIVE_Kitbag";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["sm","ab","lr"]) then {
	_backpack = "OLIVE_PB_Bergen";
};

if (_role in ["ag","ammg","ar","mmg"]) then {
	_backpack = "OLIVE_Kitbag_MachineGunner";
};

if (_role in ["pl","sl","ftl","fac"]) then {
	_helmet = "helmet_lwh_OLIVE_3";
};
if (_role isEqualTo "crew") then {
	_helmet = "helmet_lwh_OLIVE_3";
	_vest = "vest_spc_crewman_OLIVE";
};
if (_role isEqualTo "p") then {
	_uniform = "Uniform_Coveralls_OLIVE";
	_helmet = "rhsusf_hgu56p_visor_black";
	_vest = "vest_spc_crewman_OLIVE";
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
_pointer = "uk3cb_baf_llm_ir_black";
_sight = "rhsusf_acc_t1_high";
_bipod = "";

// Primary Weapon
_rifle = ["TAR21_Black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["CTAR21_Black", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["GTAR21_EGLM_Black", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_m14_fiberglass", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["rhs_weap_sr25", _silencer, _pointer, "optic_dms", "bipod_01_f_blk"];
_rifle_mag = "hlc_30rnd_556x45_M_EMAG";
_rifle_mag_tr = "hlc_30rnd_556x45_t_EMAG";
_rifleL_mag = "rhsusf_20Rnd_762x51_m118_special_Mag";
_rifleL_mag_tr = "rhsusf_20Rnd_762x51_m62_Mag";

_rifleMarksman_mag = "rhsusf_20Rnd_762x51_SR25_m993_Mag";
_rifleMarksman_mag_tr = "rhsusf_20Rnd_762x51_SR25_m62_Mag";

_LMG = ["LMG_03_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "200Rnd_556x45_Box_Tracer_Red_F";

_MMG = ["LMG_Zafir_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "150Rnd_762x54_Box_Tracer_Red";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_M136_hp", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

// Pistol
_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";
