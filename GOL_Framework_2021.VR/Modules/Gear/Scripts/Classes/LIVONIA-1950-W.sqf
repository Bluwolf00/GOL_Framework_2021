_glHE = "";
_glsmokeW = "";
_glsmokeB = "";
_glsmokeG = "";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "";
_glsmokeY = "";
_glflareG = "";
_glflareR = "";
_glflareW = "";

_flashbang = "rhs_grenade_m1939e_mag";

_goggles = "rhsusf_shemagh_grn";
_helmet = selectRandom ["PO_H_M1_OLV_2","rhsgref_helmet_M1_liner","rhsgref_helmet_M1_bare","rhsgref_helmet_M1_bare_alt01","PO_H_M1_OLV_1"];
_OfficerHelmet = "H_Beret_EAF_01_F";
_uniform = selectRandom ["U_I_E_Uniform_01_F","U_I_E_Uniform_01_shortsleeve_F"];
_vest = "rhs_chicom_khk";
_backpack = "OLIVE_PB_Rucksack";
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "OLIVE_B_RadioBag_01";
};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "OLIVE_PB_Bergen";
};

if (_role isEqualTo "crew") then {
	_helmet ="rhsgref_hat_m1941cap";
};
if (_role isEqualTo "p") then {
	_helmet ="rhsgref_hat_M1951";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_helmet = "rhsgref_hat_m1941cap";
	_uniform = "rhsgref_uniform_olive";
	_backpack = "B_Parachute";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_m1garand_sa43", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_m3a1", _silencer, _pointer, _sight, _bipod];
_rifleL = ["hlc_rifle_M1903A1_unertl", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhsgref_8Rnd_762x63_M2B_M1rifle";
_rifle_mag_tr = "rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle";
_rifleGL_mag = "rhsgref_30rnd_1143x23_M1911B_SMG";
_rifleGL_mag_tr = "rhsgref_30rnd_1143x23_M1T_2mag_SMG";
_rifleL_mag = "hlc_5rnd_3006_1903";
_rifleC_mag = "rhsgref_30rnd_1143x23_M1T_2mag_SMG";

_LMG = ["hlc_lmg_MG42", _silencer, _pointer, _sight, ""];
_LMG_mag = "hlc_100Rnd_792x57_AP_MG42";

_MMG = ["hlc_lmg_MG42", _silencer, _pointer, _sight, ""];
_MMG_mag = "rhsgref_296Rnd_792x57_SmK_alltracers_belt";

_LAT = ["rhs_weap_m72a7", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_MRAWS_green_rail_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "MRAWS_HEAT_F";
_MAT_mag_HE = "MRAWS_HE_F";

_AA = ["rhs_weap_fim92", _silencer, _pointer, _sight, _bipod];
_AA_mag = "Titan_AA";

_pistol = ["rhsusf_weap_m1911a1", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhsusf_mag_7x45acp_MHP";

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifleMarksman = ["hlc_rifle_M1903A1_unertl", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "hlc_5rnd_3006_1903";