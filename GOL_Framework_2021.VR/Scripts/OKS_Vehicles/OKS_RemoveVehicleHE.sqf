Params ["_Vehicle"];
if({_Vehicle isKindOf _X} count ["TrackedAPC","Tank","WheeledAPC","Car","StaticWeapon"] > 0) then {

	// Soviet Vehicles and Weapons
	if(["BMP", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		if(GOL_Remove_ATGM_FromVehicles) then {
			_Vehicle removeMagazinesTurret ["rhs_mag_9m14m",[0]];
			_Vehicle removeMagazinesTurret ["rhs_mag_9m113M",[0]];	
			[_Vehicle,nil,["maljutka_hide_source",1,"9p135_hide_source",1,"konkurs_hide_source",1]] call BIS_fnc_initVehicle;
			// [_Vehicle,nil,["9p135_hide_source",1]] call BIS_fnc_initVehicle;
			// [_Vehicle,nil,["konkurs_hide_source",1]] call BIS_fnc_initVehicle;
		};
		_Vehicle removeMagazinesTurret ["rhs_mag_og15v_16",[0]]; // 3CB BMP1
		_Vehicle removeMagazinesTurret ["rhs_mag_og15v_16",[1]]; // 3CB MTLB BMP1
		_Vehicle removeMagazinesTurret ["rhs_mag_og15v_20",[0]]; // RHS BMP1
	};
	if(["T34", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["UK3CB_O365K_RED",[0]]; // 3CB T34 BLUFOR
		_Vehicle removeMagazinesTurret ["UK3CB_O365K_GREEN",[0]]; // 3CB T34 OPFOR
		_Vehicle removeMagazinesTurret ["UK3CB_O365K_YELLOW",[0]]; // 3CB T34 INDEP
	};
	if(["T55", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["UK3CB_OF412_GREEN",[0]]; // 3CB T55 BLUFOR
		_Vehicle removeMagazinesTurret ["UK3CB_OF412_RED",[0]]; // 3CB T55 OPFOR
		_Vehicle removeMagazinesTurret ["UK3CB_OF412_YELLOW",[0]]; // 3CB T55 INDEP
	};
	if(["T72", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["UK3CB_3OF26_RED",[0]]; // 3CB T72 BLUFOR
		_Vehicle removeMagazinesTurret ["UK3CB_3OF26_GREEN",[0]]; // 3CB T72 OPFOR
		_Vehicle removeMagazinesTurret ["UK3CB_3OF26_YELLOW",[0]]; // 3CB T72 INDEP
		_Vehicle removeMagazinesTurret ["rhs_mag_3of26_5",[0]]; // RHS T72
	};
	if(["T80", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["rhs_mag_3of26_6",[0]]; // 3CB & RHS T80
	};
	if(["T90", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["rhs_mag_3of26_7",[0]]; // RHS T90
	};
	if(["SPG", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["rhs_mag_og9v",[0]]; // SPG
		_Vehicle removeMagazinesTurret ["rhs_mag_og9v",[1]]; // SPG
		_Vehicle removeMagazinesTurret ["rhs_mag_og9vm",[0]]; // SPG-9M
	};
	if(["BRM", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["rhs_mag_og15v_8",[0]]; // BRM-1K
	};
	if(["D30", typeOf _Vehicle, false] call BIS_fnc_inString) then {
		_Vehicle removeMagazinesTurret ["rhs_mag_of462_direct",[0]]; // D-30 AT HE Rounds
	};

	// US Vehicles and Weapons
	if(["M60", typeOf _Vehicle, false] call BIS_fnc_inString) then {
        _Vehicle removeMagazinesTurret ["UK3CB_20_HE",[0]];
        _Vehicle removeMagazinesTurret ["UK3CB_20_HE_G",[0]];
        _Vehicle removeMagazinesTurret ["UK3CB_20_HE_Y",[0]];
    };

};