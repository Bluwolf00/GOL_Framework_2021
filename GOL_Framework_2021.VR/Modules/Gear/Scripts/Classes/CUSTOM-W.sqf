/*
	Best way to get classnames of things you want is using the ACE Arsenal.
	If you select anything in the ACE Arsenal you will get the classname string which can be pasted into the code below.
	If you don't get a simple string and a huge list of things, the copy did not work, so give it another select and copy again.
	Any questions ask #Editing on Discord!
*/

_useMineDetector = false;
_allowedNightStuff = true;

_insignia = "";
_goggles = ["",""];
_helmet = [""];
_OfficerHelmet = "";
_uniform = ["","",""];
_vest = [""];
_backpack = [""];
if (GVARMAIN(mod_TFAR)) then {
	_backpackRadio = "";
};

if (_role isEqualTo "sl") then {

};

if(_role isEqualTo "ftl") then {

};

if (_role in ["ag","ammg","lr","ab"]) then {
	_backpack = "";
};
if (_role in ["ar","mmg"]) then {

};

if (_role isEqualTo "crew") then {
	_helmet = "";
};
if (_role isEqualTo "p") then {
	_helmet = "";
};
if (_role isEqualTo "uav") then {
	_backpack = "";
	_gps = "";
};
if (_role isEqualTo "jetp") then {
	_goggles = "";
	_helmet = "";
	_uniform = "";
	_vest = "";
	_backpack = "";
};

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = [[""], _silencer, _pointer, _sight, _bipod];
_rifleC = ["", _silencer, _pointer, _sight, _bipod];
_rifleGL = [[""], _silencer, _pointer, _sight, _bipod];
_rifleL = ["", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "";
_rifle_mag_tr = "";
_rifleGL_mag = "";
_rifleGL_mag_tr = "";
_rifleC_mag = "";
_rifleC_mag_tr = "";
_rifleL_mag = "";
_rifleL_mag_tr = "";


_LMG = ["", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "";

_MMG = ["", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "";

_LAT = ["", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "";
_LAT_ReUsable = false;

_MAT = ["", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "";
_MAT_mag_HE = "";

_HAT = ["", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "";

_AA = ["", _silencer, _pointer, _sight, _bipod];
_AA_mag = "";

_pistol = ["", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "";

_pdw = ["", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "";
_pdw_mag_tr = "";

_silencer = "";
_pointer = "";
_sight = "";
_bipod = "";

_rifleMarksman = ["", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "";
_rifleMarksman_mag_tr = "";
