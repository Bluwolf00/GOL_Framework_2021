/*
pl		- Platoon leader
fac		- Forward Air Controller
sl		- Squad leader
ftl		- Fire team leader
r		- Rifleman
mat		- Rifleman AT Medium
amat	- Asst. Rifleman AT
g		- Grenadier
ag		- Asst. Gunner
ar		- Automatic Rifleman
mmg		- Medium Machine Gunner
ammg	- Asst. Medium Machine Gunner
crew	- Crew memeber
p		- Pilot
*/

switch (toLower(_role)) do {

	case "sl": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleGL, _rifleGL_mag, _glHE] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4]] call _addToUniform;
		[[_smokegrenadeG,3],[_grenademini,2],[_grenade,2],[_rifleGL_mag_tr,4]] call _addToVest;
		[[_flashBang,3],[_rifleGL_mag,4],[_glHE,7],[_glsmokeR,5]] call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
	};

	case "ftl": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleGL, _rifleGL_mag_tr, _glHE] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifleGL_mag_tr,8],[_glHE,1]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "r": {
		[_goggles,_helmet,_uniform,_vest] call _addEquipment;
		if (_allowedNightStuff) then {
			_rifle set [2, "GW_X3000"];
		};
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,8]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
		if ((random 1) >= 0.6) then {
			[_LAT, _LAT_mag, ""] call _addLaunchers;
			if (_LAT_ReUsable) then {
				["","","","",_backpack] call _addEquipment;
				[[_LAT_mag,2]] call _addToBackpack;
			};
		};
	};

	case "g": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleGL, _rifleGL_mag_tr, _glHE] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifleGL_mag_tr,8],[_glHE,1],[_glsmokeR,2]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
		if (_LAT_ReUsable) then {
			[[_LAT_mag,1],[_LAT_mag_HE,1]] call _addToBackpack;
		};
	};

	case "ag": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,8]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "ar": {
		[_goggles,_helmet,_uniform,_vest,""] call _addEquipment;
		[_LMG, _LMG_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_LMG_mag,COUNT_AR_MAGS(_LMG_mag)],[_LMG_mag_tr,COUNT_AR_MAGS(_LMG_mag_tr)]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "p": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleC, _rifleC_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,1],[_smokegrenadeP,1],[_grenademini,2]] call _addToUniform;
		[[_rifleC_mag_tr,2]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "crew": {
		[_goggles,_helmet,_uniform,_vest] call _addEquipment;
		[_rifleC, _rifleC_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeG,2],[_grenademini,2]] call _addToUniform;
		[[_rifleC_mag_tr,4]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "mat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		[_MAT, _MAT_mag, ""] call _addLaunchers;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,8]] call _addToVest;
		[[_MAT_mag,1],[_MAT_mag_HE,2]] call _addToBackpack;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "amat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,8]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "ammg": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,8]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "mmg": {
		[_goggles,_helmet,_uniform,_vest,""] call _addEquipment;
		[_MMG, _MMG_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_MMG_mag_tr,COUNT_AR_MAGS(_MMG_mag_tr)]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	default {
		ERROR(FORMAT_2("ERROR: Unit: %1 Role does not exist: %2", _unit, _role));
		[_unit, "r"] call FUNC(Handler);
	};
};
