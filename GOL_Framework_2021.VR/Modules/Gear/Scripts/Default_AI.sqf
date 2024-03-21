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

if(isNil "_cswGunBackpack") then {
	_cswGunBackpack = "RHS_DShkM_Gun_Bag";
};

if(isNil "_cswTripodBackpack") then {
	_cswTripodBackpack = "RHS_DShkM_TripodLow_Bag";
};

switch (toLower(_role)) do {

	case "officer": {
		if(isNil '_OfficerHelmet') then {
			[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		} else {
			[_goggles,_OfficerHelmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		};
		[_rifleC, _rifleC_mag, ""] call _addPrimary;
		[[_rifleC_mag_tr,1]] call _addToVest;
		_IFAK call _addToUniform;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
	};

	case "pl": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,4]] call _addToUniform;
		[[_grenademini,2],[_rifle_mag_tr,5]] call _addToVest;
		[[_rifle_mag,7]] call _addToBackpack;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight))) then {
			//[[_glFlareW,1]] call _addToBackpack;
		};
	};

	case "sl": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_rifle, _rifle_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,4]] call _addToUniform;
		[[_grenademini,2],[_rifle_mag_tr,5]] call _addToVest;
		[[_rifle_mag,7]] call _addToBackpack;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight))) then {

		};
	};

	case "ftl": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		if ((random 1) <= GOL_UGL_Chance) then {
			[_rifleGL, _rifleGL_mag_tr, _glHE] call _addPrimary;
		} else {
			[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		};
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,13],[_glHE,1]] call _addToVest;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight))) then {
			//[[_glFlareW,1]] call _addToBackpack;
		};
	};

	case "csw_gunner": {
		[_goggles,_helmet,_uniform,_vest,_cswGunBackpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;

		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,13],[_glHE,1]] call _addToVest;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight))) then {
			//[[_glFlareW,1]] call _addToBackpack;
		};
	};	

	case "csw_tripod": {
		[_goggles,_helmet,_uniform,_vest,_cswTripodBackpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;

		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,13],[_glHE,1]] call _addToVest;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight))) then {
			//[[_glFlareW,1]] call _addToBackpack;
		};
	};		

	case "r": {
		[_goggles,_helmet,_uniform,_vest] call _addEquipment;
		if (_allowedNightStuff) then {
			_rifle set [2, "GW_X3000"];
		};
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,13]] call _addToVest;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((random 1) <= GOL_MAT_Chance) then {
			[_MAT, _MAT_mag, ""] call _addLaunchers;
			["","","","",_backpack] call _addEquipment;
			[[_MAT_mag,2]] call _addToBackpack;
		} else {
			if ((random 1) <= GOL_LAT_Chance) then {
				[_LAT, _LAT_mag, ""] call _addLaunchers;
				if (_LAT_ReUsable) then {
					["","","","",_backpack] call _addEquipment;
					[[_LAT_mag,1]] call _addToBackpack;
				};
			};		
		};	
	};

	case "g": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		if ((random 1) <= GOL_UGL_Chance) then {
			[_rifleGL, _rifleGL_mag_tr, _glHE] call _addPrimary;
		} else {
			[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		};
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,13]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
		if ((random 1) <= GOL_LAT_Chance) then {
			[_LAT, _LAT_mag, ""] call _addLaunchers;
			if (_LAT_ReUsable) then {
				["","","","",_backpack] call _addEquipment;
				[[_LAT_mag,1]] call _addToBackpack;
			};
		};
		if ((call EFUNC(Common,isNight))) then {
			//[[_glFlareW,4]] call _addToBackpack;
		};
	};

	case "ag": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_rifle_mag_tr,2],[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,14]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "ar": {
		[_goggles,_helmet,_uniform,_vest,""] call _addEquipment;
		[_LMG, _LMG_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_LMG_mag,2],[_grenademini,2]] call _addToUniform;
		[[_LMG_mag,5],[_LMG_mag_tr,5]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "lr": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleL, _rifleL_mag, ""] call _addPrimary;
		[[_grenademini,2],[_rifleL_mag,7],[_rifleL_mag_tr,7]] call _addToVest;
		_IFAK call _addToUniform;
		[[_rifleL_mag,3]] call _addToUniform;
		if ((random 1) <= GOL_LAT_Chance) then {
			[_LAT, _LAT_mag, ""] call _addLaunchers;
			if (_LAT_ReUsable) then {
				["","","","",_backpack] call _addEquipment;
				[[_LAT_mag,1]] call _addToBackpack;
			};
		};	
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
		};
	};

	case "ab": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleC, _rifleC_mag, ""] call _addPrimary;
		[[_grenademini,2],[_rifleC_mag,7],[_rifleC_mag_tr,7]] call _addToVest;
		_IFAK call _addToUniform;
		[[_rifleC_mag,4]] call _addToUniform;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
		};
	};


	case "p": {
		[_goggles,_helmet,_uniform,_vest,_backpackRadio] call _addEquipment;
		[_pdw, _pdw_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_pdw_mag_tr,12]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "crew": {
		[_goggles,_helmet,_uniform,_vest] call _addEquipment;
		[_rifleC, _rifleC_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_rifleC_mag_tr,12]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "mat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,12]] call _addToVest;
		if ((random 1) <= GOL_MAT_Chance) then {
			[_MAT, _MAT_mag, ""] call _addLaunchers;
			["","","","",_backpack] call _addEquipment;
			[[_MAT_mag,2]] call _addToBackpack;
		} else {
			if ((random 1) <= GOL_LAT_Chance) then {
				[_LAT, _LAT_mag, ""] call _addLaunchers;
				if (_LAT_ReUsable) then {
					["","","","",_backpack] call _addEquipment;
					[[_LAT_mag,1]] call _addToBackpack;
				};
			};		
		};	
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "amat": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,12]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "ammg": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifle, _rifle_mag_tr, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_rifle_mag_tr,12]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "mmg": {
		[_goggles,_helmet,_uniform,_vest,""] call _addEquipment;
		[_MMG, _MMG_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_grenademini,2]] call _addToUniform;
		[[_MMG_mag_tr,6]] call _addToVest;
		["", "", "", "", "", _nvg] call _addLinkedItems;
	};

	case "marksman": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleMarksman, _rifleMarksman_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[[_rifleMarksman_mag,3],[_grenademini,2]] call _addToVest;
		[[_rifleMarksman_mag_tr,2]] call _addToBackpack;
		[_map, "", "ItemRadio", _compass, _watch, _nvg] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
		};
	};

	case "aa": {
		[_goggles,_helmet,_uniform,_vest,_backpack] call _addEquipment;
		[_rifleC, _rifleC_mag, ""] call _addPrimary;
		_IFAK call _addToUniform;
		[_AA, _AA_mag, ""] call _addLaunchers;
		[[_rifleC_mag,4],[_smokegrenadeY,3],[_flashBang,3]] call _addToUniform;
		[[_grenade,2],[_rifleC_mag_tr,4]] call _addToVest;
		[[_AA_mag,1]] call _addToBackpack;
		[_map, _gps, "", _compass, _watch, ""] call _addLinkedItems;
		if ((call EFUNC(Common,isNight)) && _allowedNightStuff) then {
			_nvg call _addNVG;
		};
	};

	default {
		ERROR(FORMAT_2("ERROR: Unit: %1 Role does not exist: %2", _unit, _role));
		[_unit, "r"] call FUNC(Handler);
	};
};
