_useMineDetector = false;
_allowedNightStuff = false;

_insignia = "";
_goggles = "";
_helmet = [
	"H_Bandanna_khk","H_Booniehat_oli","UK3CB_ADA_I_H_M1_DPP","rhs_ssh60","rhs_tsh4","","",
	"H_Bandanna_surfer_grn","H_Cap_tan","","H_Hat_Safari_sand_F","H_Cap_oli_hs","H_Bandanna_cbr","H_Cap_blk","H_Bandanna_gry","H_Watchcap_cbr"
];
_OfficerHelmet = "rhs_beret_vdv3";
_uniform = [
	"UK3CB_FIA_B_U_M10_CombatUniform_DPM01_DPM02_02","UK3CB_FIA_B_U_M10_CombatUniform_DPM01_DPM02_01","UK3CB_FIA_B_U_M10_CombatUniform_DPM01_TRK01_02",
	"UK3CB_FIA_B_U_M10_CombatUniform_DPM01_TRK01_01","UK3CB_FIA_B_U_M10_CombatUniform_DPM01_VEG01_01","UK3CB_FIA_B_U_M10_CombatUniform_DPM01_WDL02_02",
	"UK3CB_FIA_B_U_M10_CombatUniform_DPM01_WDL02_01","UK3CB_FIA_B_U_M10_CombatUniform_MAR01_DPM01_01",
	"U_BG_Guerilla1_1","U_BG_leader","U_BG_Guerilla1_2_F","U_I_G_resistanceLeader_F","U_BG_Guerilla2_1",
	"U_BG_Guerilla3_1","U_BG_Guerrilla_6_1","U_BG_Guerilla2_3","U_BG_Guerilla2_2"
];
_vest = [
	"rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2","rhsgref_alice_webbing","UK3CB_V_CW_Chestrig_2_Small",
	"UK3CB_V_Belt_Rig_KHK","V_Chestrig_rgr","rhsgref_chestrig","rhsgref_chicom","UK3CB_V_Invisible","V_SmershVest_01_F","UK3CB_V_Chestrig_2_Small_OLI","V_Pocketed_coyote_F",
	"V_Rangemaster_belt","V_BandollierB_rgr","UK3CB_TKP_I_V_6Sh92_Khk","UK3CB_TKA_I_V_6Sh92_Khk","UK3CB_TKA_I_V_6Sh92_Oli","rhs_belt_AK_GL","rhs_belt_RPK","rhs_lifchik_NCO",
	"rhs_lifchik_vog","rhs_suspender_AK8_chestrig","rhs_suspender_AK","rhs_suspender_AK4","V_TacVest_camo","UK3CB_ADA_B_V_TacVest_DPM","V_TacVest_oli",
	"rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2","rhs_6b2_chicom","rhs_6b2_holster","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b2_SVD","rhs_6b2"
];
_backpack = [
	"rhs_sidor","UK3CB_B_Alice_Bedroll_K","UK3CB_B_Alice_Bedroll_2_K","UK3CB_B_Alice_K","UK3CB_CHC_C_B_HIKER","UK3CB_FIA_B_B_ASS_OLI","UK3CB_B_US_Backpack","UK3CB_B_Bedroll_Backpack",
	"UK3CB_B_Fieldpack","UK3CB_B_Hiker","UK3CB_ION_B_B_RIF_OLI_01","UK3CB_B_Largepack","UK3CB_KDF_B_B_Sidor_RIF_OLI","B_CivilianBackpack_01_Everyday_Black_F","B_Messenger_Olive_F","rhs_rd54"
];
_backpackRadio = _backpack;
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "UK3CB_CW_SOV_O_LATE_B_ASS_BERGEN_Radio";
};

if (_role in ["lr","ab"]) then {
	_backpack = "rhs_rd54";
};

if (_role in ["ag","ammg"]) then {
	_backpack = ["rhs_medic_bag","UK3CB_KDF_B_B_Sidor_MD_OLI","UK3CB_B_Largepack_Med"];
};
if (_role isEqualTo "p") then {
	_helmet = "H_Booniehat_khk_hs";
	_uniform = "UK3CB_MDF_B_U_CombatUniform_01_LIZ";
};
if (_role isEqualTo "uav") then {
	_backpack = "B_UAV_01_backpack_F";
	_gps = "B_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

_silencer = "rhs_acc_dtk1983";
_pointer = "acc_flashlight";
_sight = "";
_bipod = "";

_rifle = ["UK3CB_G3A3_RIS", _silencer, _pointer, _sight, _bipod];
_rifleC = ["UK3CB_HK33KA2_RIS", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["UK3CB_MP5N_UGL", _silencer, _pointer, _sight, _bipod];
_rifleL = ["uk3cb_sks_01_sling", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "UK3CB_G3_20rnd_762x51_RT";
_rifleGL_mag = "UK3CB_MP5_30Rnd_9x19_Magazine_RT";
_rifleC_mag = "UK3CB_HK33_30rnd_556x45_RT";
_rifleL_mag = "uk3cb_10rnd_magazine_sks_RT";

_LMG = ["UK3CB_Bren", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "UK3CB_Bren_30Rnd_762x51_Magazine_RT";

_MMG = ["uk3cb_ppsh41", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "uk3cb_PPSH_71rnd_magazine_RT";

if(random 1 > 0.5) then {
	_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg75_mag";
	_LAT_ReUsable = false;
} else {
	_LAT = ["rhs_weap_rpg18", _silencer, _pointer, _sight, _bipod];
	_LAT_mag = "rhs_rpg18_mag";
	_LAT_ReUsable = false;
};

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "RPG7_F";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["hgun_Pistol_01_F", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "10Rnd_9x21_Mag";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_rifleMarksman = ["rhs_weap_m1garand_sa43", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "rhsgref_8Rnd_762x63_M2B_M1rifle";
_rifleMarksman_mag_tr = "rhsgref_8Rnd_762x63_Tracer_M1T_M1rifle";
