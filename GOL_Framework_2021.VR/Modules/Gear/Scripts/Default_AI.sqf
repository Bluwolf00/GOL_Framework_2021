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

	case "officer": {
		if(isNil '_OfficerHelmet') then {
			[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		} else {
			[_goggles,_OfficerHelmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		};
		_IFAK call _addToUniform;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
	};


	case "sl": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleGL, _rifleGL_mag, _glHE] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4]] call _addToUniform;
		[[_smokegrenadeG,3],[_grenademini,2],[_grenade,2],[_rifleGL_mag_tr,4]] call _addToVest;
		[[_flashBang,3],[_rifleGL_mag,4],[_glHE,1],[_glsmokeR,1]] call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			[[_glFlareW,4]] call _addToBackpack;
		};
	};

	case "ftl": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleGL, _rifleGL_mag_tr, _glHE] call _addPrimary;
		_IFAK call _addToUniform;
		[[_smokegrenadeW,2],[_grenademini,2]] call _addToUniform;
		[[_rifleGL_mag_tr,8],[_glHE,1]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			[[_glFlareW,4]] call _addToBackpack;
		};
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
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			[[_glFlareW,4]] call _addToBackpack;
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

	case "lr": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleL, _rifleL_mag, ""] call _addPrimary;
		[[_flashBang,3],[_grenademini,2],[_grenade,2],[_rifleL_mag,4],[_rifleL_mag_tr,4]] call _addToVest;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;

		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,1],[_handFlareR,1]] call _addToUniform;
		};
	};

	case "ab": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleC, _rifleC_mag, ""] call _addPrimary;
		[[_flashBang,3],[_grenademini,2],[_grenade,2],[_rifleC_mag,4],[_rifleC_mag_tr,4]] call _addToVest;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_rifleGL_mag_tr,6],[_rifleC_mag_tr,6],[_rifle_mag_tr,6],[_LMG_mag_tr,3],[_glHE,6]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,1],[_handFlareR,1]] call _addToUniform;
		};
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

	case "marksman": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleMarksman, _rifleMarksman_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_rangecard,1],[_microDAGR,1],["ACE_ATragMX",1],["ACE_Kestrel4500",1]] call _addToUniform;
		[[_rifleMarksman_mag,3],[_grenademini,2],[_smokegrenadeY,6],[_smokegrenadeG,6],[_smokegrenadeB,2],[_smokegrenadeP,2]] call _addToVest;
		[[_rifleMarksman_mag_tr,2],[_smokegrenadeG,5]] call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1]] call _addToUniform;
			[[_chemG,5],[_chemR,5],[_handFlareG,2],[_IRStrobe,2]] call _addToBackpack;
		};
	};

	default {
		ERROR(FORMAT_2("ERROR: Unit: %1 Role does not exist: %2", _unit, _role));
		[_unit, "r"] call FUNC(Handler);
	};
};
