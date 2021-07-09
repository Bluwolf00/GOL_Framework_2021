// Cloths
_goggles = "";
_helmet = "helmet_lwh_OLIVE";
_OfficerHelmet = "cap_OLIVE";
_uniform = SelectRandom ["Uniform_Full_OLIVE","Uniform_Rolled_OLIVE"];
_vest = "vest_spc_radio_OLIVE";
_backpack = "OLIVE_Assaultpack";
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "unv_OLIVE_big_rt1523g";
};

if (_role in ["ag","ammg","sm","lr","ab"]) then {
	_backpack = "OLIVE_Medicpack";
};

if (_role in ["ar","mmg"]) then {
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
_pointer = "";
_sight = "";
_bipod = "";

// Primary Weapon
_rifle = ["TAR21_Black", _silencer, _pointer, _sight, _bipod];
_rifleC = ["CTAR21_Black", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["GTAR21_EGLM_Black", _silencer, _pointer, _sight, _bipod];
_rifleL = ["TAR21_Black", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["rhs_weap_sr25", _silencer, _pointer, "hlc_optic_leupoldm3a", _bipod];
_rifle_mag = "hlc_30rnd_556x45_EPR_G36";
_rifle_mag_tr = "hlc_30rnd_556x45_Tracers_G36";
_rifleC_mag = "30Rnd_556x45_Stanag_Tracer_Red";
_rifleMarksman_mag = "rhsusf_20Rnd_762x51_SR25_m118_special_Mag";
_rifleMarksman_mag_tr = "rhsusf_20Rnd_762x51_SR25_m62_Mag";

_LMG = ["hlc_m249_pip4", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhsusf_200Rnd_556x45_box";
_LMG_mag_tr = "rhsusf_200Rnd_556x45_mixed_box";

_MMG = ["hlc_lmg_MG3KWS_b", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "hlc_250Rnd_762x51_B_MG3";
_MMG_mag_tr = "hlc_250Rnd_762x51_T_MG3";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_I_Titan_short_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "Titan_AT";
_MAT_mag_HE = "Titan_AP";

// Pistol
_pistol = ["rhsusf_weap_m9", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_15Rnd_9x19_FMJ";
