/*
pl			- Platoon leader
fac			- Forward Air Controller
sl			- Squad Leader
sl			- Squad Medic
ftl			- Fire Team Leader
r			- Rifleman
g			- Grenadier
ag			- Asst. Gunner
ar			- Automatic Rifleman
crew		- Crew memeber
p			- Pilot
mat			- Rifleman AT Medium
amat		- Asst. Rifleman AT
mmg			- Medium Machine Gunner
ammg		- Asst. Medium Machine Gunner
marksman	- Marksman
*/

switch (toLower(_role)) do {

	case "pl": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_microDAGR,1],[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_flashBang,3],[_smokegrenadeG,5],[_grenademini,2],[_rifle_mag_tr,5]] call _addToVest;
		[[_smokegrenadeG,5]] call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
		};
	};

	case "fac": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleGL, _rifle_mag_tr, _glsmokeR] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_microDAGR,1],[_pistol_mag,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,3],[_smokegrenadeY,6],[_smokegrenadeG,6],[_smokegrenadeB,2],[_smokegrenadeP,2]] call _addToVest;
		[[_flashBang,3],[_battery,1],[_glsmokeR,5],[_glsmokeG,2],[_smokegrenadeG,5]] call _addToBackpack;
		if (call EFUNC(Common,isNight)) then {
			[[_chemG,5],[_chemR,5],[_handFlareG,6],[_IRStrobe,3],[_glFlareR,10],[_glFlareG,10]] call _addToBackpack;
		};
		_laserDesignator call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
		};
	};

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

		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
			[[_handFlareG,3],[_handFlareR,3],[_glFlareR,5],[_glFlareG,5]] call _addToBackpack;
		};
	};

	case "sm": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, _glHE] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4]] call _addToUniform;
		[[_smokegrenadeG,3],[_grenademini,2],[_rifle_mag_tr,2]] call _addToVest;
		_FAKBig call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
		};
	};

	case "ftl": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleGL, _rifleGL_mag, _glHE] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4]] call _addToUniform;
		[[_smokegrenadeG,3],[_grenademini,2],[_grenade,2],[_rifleGL_mag_tr,4]] call _addToVest;
		[[_flashBang,3],[_rifleGL_mag,4],[_glHE,7],[_glSmokeR,5]] call _addToBackpack;
		_rangefinder call _addBino;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
			[[_handFlareG,2],[_handFlareR,2],[_glFlareR,3],[_glFlareG,3]] call _addToBackpack;
		};
	};

	case "r": {
		[_goggles,_helmet,_uniform,_vest] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_flashBang,3],[_grenademini,2],[_grenade,2],[_rifle_mag,4],[_rifle_mag_tr,4]] call _addToVest;
		["","","","",_backpack] call _addEquipment;
		[_LAT, _LAT_mag, ""] call _addLaunchers;
		[[_cables,1],[_defusalKit,1]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,1],[_handFlareR,1]] call _addToUniform;
		};
		if (_useMineDetector) then {
			[["MineDetector",1]] call _addToBackpack;
		};
		if (_LAT_ReUsable) then {
			[[_LAT_mag,1]] call _addToBackpack;
		};
	};

	case "g": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleGL, _rifleGL_mag, _glHE] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_flashBang,3],[_grenademini,2],[_grenade,2],[_rifleGL_mag,4],[_rifleGL_mag_tr,4]] call _addToVest;
		[[_glHE,7],[_glsmokeR,3],[_glsmokeY,3]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
			[[_handFlareG,2],[_handFlareR,2],[_glFlareR,4],[_glFlareG,4]] call _addToBackpack;
		};
		if (_LAT_ReUsable) then {
			[[_LAT_mag,1],[_LAT_mag_HE,1]] call _addToBackpack;
		};
	};

	case "ag": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4],[_grenademini,2]] call _addToUniform;
		[[_flashBang,3],[_grenade,1],[_rifle_mag,4],[_rifle_mag_tr,4]] call _addToVest;
		[[_clacker,1],[_demoCharge,2],[_LMG_mag_tr,COUNT_AG_MAGS(_LMG_mag_tr)]] call _addToBackpack;
		if (GVAR(extraGear)) then {
			(_FAKBig) call _addToBackpack;
		} else {
			(_FAKSmall) call _addToBackpack;
		};
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,2],[_handFlareR,2]] call _addToUniform;
		};
		_rangefinder call _addBino;
	};

	case "ar": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_LMG, _LMG_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,2]] call _addToUniform;
		[[_flashBang,3],[_grenade,2],[_grenademini,2]] call _addToVest;
		[[_LMG_mag,COUNT_AR_MAGS(_LMG_mag)],[_LMG_mag_tr,COUNT_AR_MAGS(_LMG_mag_tr)]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,1],[_handFlareR,1]] call _addToUniform;
		};
	};

	case "p": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifleC, _rifleC_mag_tr, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_smokegrenadeY,2],[_smokegrenadeP,3],[_grenademini,1]] call _addToUniform;
		[[_toolkit,1],[_rifleC_mag_tr,2]] call _addToVest;
		_FAKBig call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_handFlareG,5],[_handFlareR,3]] call _addToUniform;
		};
	};

	case "crew": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,2]] call _addToUniform;
		[[_rifle_mag,4],[_smokegrenadeP,3],[_grenademini,1]] call _addToVest;
		[[_toolkit,1]] call _addToBackPack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1],[_IRStrobe,1]] call _addToUniform;
		};
	};

	case "mat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_MAT, _MAT_mag, ""] call _addLaunchers;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_grenademini,2],[_grenade,2],[_rifle_mag_tr,5]] call _addToVest;
		[[_MAT_mag,1],[_MAT_mag_HE,2]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1]] call _addToUniform;
		};
	};

	case "amat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_grenademini,2],[_grenade,2],[_rifle_mag_tr,6]] call _addToVest;
		[[_MAT_mag,2],[_MAT_mag_HE,2]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1]] call _addToUniform;
		};
	};

	case "ammg": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,4],[_grenademini,2]] call _addToUniform;
		[[_grenade,1],[_rifle_mag_tr,7]] call _addToVest;
		(_FAKSmall + [[_MMG_mag_tr,COUNT_AG_MAGS(_MMG_mag_tr)]]) call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1]] call _addToUniform;
		};
		_rangefinder call _addBino;
	};

	case "mmg": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_MMG, _MMG_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,2],[_grenademini,2]] call _addToUniform;
		[[_grenade,2],[_MMG_mag,COUNT_AR_MAGS(_MMG_mag)]] call _addToVest;
		[[_MMG_mag_tr,COUNT_AR_MAGS(_MMG_mag_tr)]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
			[[_mapFlashLight,1]] call _addToUniform;
		};
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

	case "pj": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,3],[_smokegrenadeY,6],[_smokegrenadeG,6],[_smokegrenadeB,2],[_smokegrenadeP,2]] call _addToVest;
		[[_smokegrenadeG,5]] call _addToBackpack;
		_FAKBig call _addToBackpack;
		if (call EFUNC(Common,isNight)) then {
			[[_chemG,5],[_chemR,5],[_handFlareG,2],[_IRStrobe,3]] call _addToBackpack;
		};
		[_map, _gps, "", _compass, _watch, _nvg] call _addLinkedItems;
	};

	case "diver": {
		if (isNil "_rifle_Diver") then {
			_rifle_Diver = ["arifle_SDAR_F", "", "", "", ""];
		};
		if (isNil "_rifle_Diver_mag") then {
			_rifle_Diver_mag = "20Rnd_556x45_UW_mag";
		};
		if (isNil "_rifle_Diver_mag_tr") then {
			_rifle_Diver_mag_tr = "ACE_30Rnd_556x45_Stanag_Mk318_mag";
		};

		["G_B_Diving","","U_B_Wetsuit","V_RebreatherB","B_ViperHarness_blk_F"] call _addEquipment;
		[_rifle_Diver, _rifle_Diver_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,3]] call _addToUniform;
		[[_grenademini,2],[_grenade,2],[_rifle_Diver_mag,4],[_rifle_Diver_mag_tr,4]] call _addToVest;
		[[_cables,1],[_defusalKit,1],[_clacker,1],[_demoCharge,2],[_satchelCharge,1]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			["", "", "", "", "", _nvg] call _addLinkedItems;
			[[_mapFlashLight,1]] call _addToUniform;
		};
		if (_useMineDetector) then {
			[["MineDetector",1]] call _addToBackpack;
		};
	};

	case "uav": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
//		[[_mortarRangeCard,1]] call _addToUniform;
		[[_pistol_mag,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag,4],[_smokegrenadeY,6],[_smokegrenadeG,6],[_smokegrenadeB,2],[_smokegrenadeP,2]] call _addToVest;
		[[_smokegrenadeG,5],[_rifle_mag_tr,3]] call _addToBackpack;
		if (call EFUNC(Common,isNight)) then {
			[[_chemG,5],[_chemR,5],[_handFlareG,2],[_IRStrobe,3]] call _addToBackpack;
		};
		[_map, _gps, "", _compass, _watch, _nvg] call _addLinkedItems;
	};

	case "jetp": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_pistol_mag,2],[_smokegrenadeY,2]] call _addToUniform;
		[[_smokegrenadeP,3],[_grenademini,1]] call _addToVest;
		[[_toolkit,1]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, _nvg] call _addLinkedItems;
	};

	case "dragon": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		[_pistol, _pistol_mag, ""] call _addHandGun;
		_IFAK call _addToUniform;
		[[_mortarRangeCard,1]] call _addToUniform;
		[[_pistol_mag,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag,4],[_smokegrenadeY,6],[_smokegrenadeG,6],[_smokegrenadeB,2],[_smokegrenadeP,2]] call _addToVest;
		[[_smokegrenadeG,5],[_rifle_mag_tr,3]] call _addToBackpack;
		if (call EFUNC(Common,isNight)) then {
			[[_chemG,5],[_chemR,5],[_handFlareG,2],[_IRStrobe,3]] call _addToBackpack;
		};
		[_map, _gps, "", _compass, _watch, _nvg] call _addLinkedItems;
	};

	default {
		ERROR(FORMAT_2("ERROR: Unit: %1 Role does not exist: %2", _unit, _role));
		[_unit, "r"] call FUNC(Handler);
	};
};
