
_addEquipment = {

	private ["_equipment"];
	if !((_this select 0) isEqualTo "") then {
		if((typeName (_this select 0)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_this select 0);
		} else {
			_equipment = (_this select 0);
		};
		_loadout set [7, _equipment];		// Goggles
	};
	if !((_this select 1) isEqualTo "") then {
		if((typeName (_this select 1)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_this select 1);
		} else {
			_equipment = (_this select 1);
		};		
		_loadout set [6, _equipment];		// Helmet
	};
	if !((_this select 2) isEqualTo "") then {
		if((typeName (_this select 2)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_this select 2);
		} else {
			_equipment = (_this select 2);
		};
		_loadout set [3, [_equipment,[]]];	// Uniform
	};
	if !((_this select 3) isEqualTo "") then {
		if((typeName (_this select 3)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_this select 3);
		} else {
			_equipment = (_this select 3);
		};
		_loadout set [4, [_equipment,[]]];	// Vest
	};
	if !((_this select 4) isEqualTo "") then {
		if((typeName (_this select 4)) isEqualTo "ARRAY") then {
			_equipment = selectRandom (_this select 4);
		} else {
			_equipment = (_this select 4);
		};
		_loadout set [5, [_equipment,[]]];	// Backpack
	};
};

_addPrimary = {
	if(typeName ((_this select 0) select 0) == "ARRAY") then {
		_loadout set [0, [selectRandom((_this select 0) select 0),(_this select 0 select 1),(_this select 0 select 2),(_this select 0 select 3),ADD_MAG(_this select 1),ADD_MAG(_this select 2),(_this select 0 select 4)]]
	}
	else
	{
		_loadout set [0, [(_this select 0 select 0),(_this select 0 select 1),(_this select 0 select 2),(_this select 0 select 3),ADD_MAG(_this select 1),ADD_MAG(_this select 2),(_this select 0 select 4)]]
	};
};
_addLaunchers = {_loadout set [1, [(_this select 0 select 0),(_this select 0 select 1),(_this select 0 select 2),(_this select 0 select 3),ADD_MAG(_this select 1),ADD_MAG(_this select 2),(_this select 0 select 4)]]};
_addHandGun = {_loadout set [2, [(_this select 0 select 0),(_this select 0 select 1),(_this select 0 select 2),(_this select 0 select 3),ADD_MAG(_this select 1),ADD_MAG(_this select 2),(_this select 0 select 4)]]};
_addToUniform = {
	if !(count (_loadout select 3) isEqualTo 0) then {
		{
			if (ISMAG(_x select 0)) then {
				((_loadout select 3) select 1) append [COUNT_MAGS((_x select 0),(_x select 1))];
			} else {
				((_loadout select 3) select 1) append [_x];
			};
		} forEach _this;
	};
};
_addToVest = {
	if !(count (_loadout select 4) isEqualTo 0) then {
		{
			if (ISMAG(_x select 0)) then {
				((_loadout select 4) select 1) append [COUNT_MAGS((_x select 0),(_x select 1))];
			} else {
				((_loadout select 4) select 1) append [_x];
			};
		} forEach _this;
	};
};
_addToBackPack = {
	if !(count (_loadout select 5) isEqualTo 0) then {
		{
			if (ISMAG(_x select 0)) then {
				((_loadout select 5) select 1) append [COUNT_MAGS((_x select 0),(_x select 1))];
			} else {
				((_loadout select 5) select 1) append [_x];
			};
		} forEach _this;
	};
};
_addBino = {_loadout set [8, [_this,"","","",[],[],""]]};
_addNVG = {(_loadout select 9) set [5, _this]};
_addLinkedItems = {_loadout set [9, _this]};

_fnc_AddObjectsCargo = {
	params [["_unit", objNull, [objNull]],["_item", "", [""]],["_number", 1, [0]]];

	if !(_item isEqualTo "") then {
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Item") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Mine") then {
			_unit addItemCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Magazine") then {
			_unit addMagazineCargoGlobal [_item, _number];
		};
		if (([_item] call BIS_fnc_itemType select 0) isEqualTo "Weapon") then {
			if (_item isEqualTo "HandGrenade") then {
				_unit addMagazineCargoGlobal [_item, _number];
			} else {
				_unit addWeaponCargoGlobal [_item, _number];
			};

		};
	};
};
