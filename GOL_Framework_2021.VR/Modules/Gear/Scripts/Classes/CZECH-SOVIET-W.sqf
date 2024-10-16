_useMineDetector = false;
_allowedNightStuff = false;

_insignia = "Roundel_Czech";
_goggles = selectRandom [""];
_helmet = selectRandom ["rhs_ssh60"];
_OfficerHelmet = "rhssaf_beret_red";
_uniform = selectRandom ["rhs_uniform_afghanka_grey"];
_vest = ["rhs_6b3","rhs_6b3_holster","rhs_6b3_AK"];
_backpack = "UK3CB_UN_B_B_ASS";
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = "UK3CB_B_O_Assault_camo_Radio";
};

if (_role in ["lr","ab","mat","amat","aa"]) then {
	_backpack = "UK3CB_KDF_B_B_Sidor_RIF_VSR";
};

if (_role in ["ag","ammg","sm"]) then {
	_backpack = "UK3CB_KDF_B_B_Sidor_MD_OLI";
	_vest = "rhs_6b3_RPK";
};

if (_role isEqualTo "r") then {
	_backpack = "rhs_rpg_6b3";
};

if (_role isEqualTo "crew") then {
	_helmet = "rhs_tsh4";
	_vest = "rhsgref_6b23_ttsko_mountain";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_zsh7a_mike_green_alt";
	_uniform = "rhs_uniform_afghanka_grey";
	_vest = "rhs_6b3_holster";
};
if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UavTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "";
	_helmet = "rhs_zsh7a_alt";
	_uniform = "UK3CB_CW_SOV_O_Early_U_J_Pilot_Uniform_01_GRY";
	_vest = "rhs_belt_AK4";
	_backpack = "B_Parachute";
};

// Attachments
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

// Primary Weapons
_rifle = ["rhs_weap_savz58p", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_savz58v", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_savz58p", _silencer, _pointer, _sight, _bipod];
_rifleL = ["UK3CB_SVD_OLD", _silencer, _pointer, "rhs_acc_pso1m2", _bipod];
_rifleMarksman = ["UK3CB_SVD_OLD", _silencer, _pointer, "rhs_acc_pso1m2", _bipod];
_rifle_mag = "rhs_30Rnd_762x39mm_Savz58";
_rifle_mag_tr = "rhs_30Rnd_762x39mm_Savz58_tracer";

_rifleC_mag = "rhs_30Rnd_762x39mm_Savz58";
_rifleC_mag_tr = "rhs_30Rnd_762x39mm_Savz58_tracer";
_rifleGL_mag = "rhs_30Rnd_762x39mm_Savz58";
_rifleGL_mag_tr = "rhs_30Rnd_762x39mm_Savz58_tracer";
_rifleL_mag = "10Rnd_762x54_Mag";
_rifleL_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";
_rifleMarksman_mag = "10Rnd_762x54_Mag";
_rifleMarksman_mag_tr = "ACE_10Rnd_762x54_Tracer_mag";

_LMG = ["Hud_UK59_F", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "100Rnd_762x54_Tracer";
_LMG_mag_tr = "100Rnd_762x54_Tracer";

_MMG = ["Hud_UK59_F", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "100Rnd_762x54_Tracer";
_MMG_mag_tr = "100Rnd_762x54_Tracer";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["rhs_weap_rpg75", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, "rhs_acc_pgo7v3", _bipod];
_MAT_mag = "rhs_rpg7_PG7VM_mag";
_MAT_mag_HE = "rhs_rpg7_TBG7V_mag";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

// Pistol
_pistol = ["rhs_weap_tt33", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_762x25_8";

// PDW
_pdw = ["rhs_weap_savz61", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhsgref_20rnd_765x17_vz61";
_pdw_mag_tr = "rhsgref_20rnd_765x17_vz61";
