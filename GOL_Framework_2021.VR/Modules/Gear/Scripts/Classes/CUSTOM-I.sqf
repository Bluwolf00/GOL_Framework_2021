/*
	Best way to get classnames of things you want is using the ACE Arsenal.
	If you select anything in the ACE Arsenal you will get the classname string which can be pasted into the code below.
	If you don't get a simple string and a huge list of things, the copy did not work, so give it another select and copy again.
	Any questions ask #Editing on Discord!
*/

_useMineDetector = false;
_allowedNightStuff = true;

// Cloths
/*
	If you want more than 1 type of uniform/vest/goggles/helmets you can add more into the arrays below that looks like this:
	selectRandom["Type1","Type2","Type3"];
*/
_insignia = "";
_goggles = selectRandom [""];
_helmet = selectRandom [""];
_OfficerHelmet = "";
_uniform = selectRandom [""];
_vest = selectRandom [""];
_backpack = "";
_backpackRadio = _backpack;

if (GVARMAIN(mod_TFAR)) then {
	/* Make sure the radio is a proper radio backpack by TFAR or we will have issues. If you don't know, ask we will help you. */
	_backpackRadio = "";
};
if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "";
};
if (_role isEqualTo "crew") then {
	_helmet = "";
	_vest = "";
};
if (_role isEqualTo "p") then {
	_helmet = "";
	_uniform = "";
	_vest = "";
};
if (_role isEqualTo "uav") then {
	_backpack = "I_UAV_01_backpack_F";
	_gps = "I_UAVTerminal";

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

// Primary Weapons
_rifle = ["", _silencer, _pointer, _sight, _bipod];
_rifleC = ["", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["", _silencer, _pointer, _sight, _bipod];
_rifleL = ["", _silencer, _pointer, _sight, _bipod];
_rifleMarksman = ["", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "";
_rifle_mag_tr = "";
/*
	Remove ammo beblow if you want it to fallback to the two mags above.
	Not recommended, define the ammo types for each rifle. If they are the same caliber just copy paste
 */
_rifleC_mag = "";
_rifleC_mag_tr = "";
_rifleGL_mag = "";
_rifleGL_mag_tr = "";
_rifleL_mag = "";
_rifleL_mag_tr = "";
_rifleMarksman_mag = "";
_rifleMarksman_mag_tr = "";

_LMG = ["", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "";
_LMG_mag_tr = "";

_MMG = ["", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "";
_MMG_mag_tr = "";

// Launchers
_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_LAT = ["", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "";
_MAT_mag_HE = "";

// Pistol
_pistol = ["", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "";

// PDW
_pdw = ["", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "";
_pdw_mag_tr = "";
