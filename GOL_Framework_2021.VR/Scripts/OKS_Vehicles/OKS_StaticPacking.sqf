/// [] execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";
if(isServer) then {
	["StaticWeapon", "init", {(_this select 0) enableWeaponDisassembly false}] call CBA_fnc_addClassEventHandler;
	{if(_X isKindOf "StaticWeapon") then {_X enableWeaponDisassembly false}} foreach Vehicles;
};

Private _Blacklist = [];
OKS_DroneClassnames = ["B_Crocus_AP","B_Crocus_AT","B_UAFPV_AP","B_UAFPV_RKG_AP","B_UAFPV_AT"];

if (hasInterface) then {
 //  && !((player getVariable ["OKS_PackedClassname",""]) in _Blacklist
    _conditionMG = {("GOL_Packed_HMG" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortar = {("GOL_Packed_Mortar" in (itemsWithMagazines player))}; //<only works MP
	_conditionGMG = {("GOL_Packed_GMG" in (itemsWithMagazines player))}; //<only works MP
	_conditionAT = {("GOL_Packed_AT" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneAT = {("GOL_Packed_Drone_AT" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneAP = {("GOL_Packed_Drone_AP" in (itemsWithMagazines player))}; //<only works MP

	_codeDeployHMG = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_HMG";
			private _type = GOL_Packed_HMG;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying HMG Weapon...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					//_DroneCrew = createVehicleCrew _object;
					//_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};
	_codeDeployGMG = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_GMG";
			private _type = GOL_Packed_GMG;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying GMG Weapon...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					//_DroneCrew = createVehicleCrew _object;
					//_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};
	_codeDeployMortar = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_Mortar";
			private _type = GOL_Packed_Mortar;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying Mortar Weapon...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					//_DroneCrew = createVehicleCrew _object;
					//_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};
	_codeDeployAT = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_AT";
			private _type = GOL_Packed_AT;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying AT Weapon...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					//_DroneCrew = createVehicleCrew _object;
					//_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};
	_codeDeployDrone_AP = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_Drone_AP";
			private _type = GOL_Packed_Drone_AP;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying AP Drone...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					_DroneCrew = createVehicleCrew _object;
					_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};
	_codeDeployDrone_AT = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_Drone_AT";
			private _type = GOL_Packed_Drone_AT;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying AT Drone...";
			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId","_item","_type"];
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];	
				_HasItem = [_unit, _item, true] call BIS_fnc_hasItem;

				if (_HasItem && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];
					_object setVariable ["GOL_ItemPacked",_item];
					_unit removeItem _item;
					_DroneCrew = createVehicleCrew _object;
					_unit connectTerminalToUAV _object;					
					_object setPosATL _pos;
					_object setDir _dir;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};			


	_PackCode = {
		private _actionName = "Packing...";	
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			private _item = _target getVariable ["GOL_ItemPacked",""];
			if(isNil "_item") exitWith { systemChat "Unable to find ItemPacked classname"};	
			if (_player canAdd _item) then {
				_player additem _item;
				deleteVehicle _target;
			} else {
				systemChat "Your inventory is full. Unable to pack."
			};
		},
		{
		},_this] call CBA_fnc_progressBar;
	};

	_SelectHMG = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GOL_Packed_HMG";
			if (_player canAdd _item) then {
				_player additem _item;

				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to equip Static Weapon Pack."
			};
		};
		[_player,GOL_PACKED_HMG] call _SelectWeaponPacked;
	};
	_SelectMortar = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GOL_Packed_Mortar";
			if (_player canAdd _item) then {
				_player additem _item;
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to equip Static Weapon Pack."
			};
		};		
		[_player,GOL_PACKED_MORTAR] call _SelectWeaponPacked;
	};	
	_SelectGMG = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GOL_Packed_GMG";
			if (_player canAdd _item) then {
				_player additem _item;
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to load Static GMG Pack."
			};
		};		
		[_player,GOL_PACKED_GMG] call _SelectWeaponPacked;
	};	
	_SelectAT = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GOL_Packed_AT";
			if (_player canAdd _item) then {
				_player additem _item;
				_player setVariable ["OKS_PackedClassname",_Classname,true];
				_player setVariable ["OKS_PackedMagazines",[]];
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to load Static Weapon Pack."
			};
		};
		[_player,GOL_PACKED_AT] call _SelectWeaponPacked;
	};	
	_SelectDroneAT = {
		_SelectWeaponPacked = {
				Params ["_player","_Classname"];
				private _item = "GOL_Packed_Drone_AT";
				if (_player canAdd _item) then {
					_player additem _item;
					systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
				} else {
					systemChat "Your inventory is full. Unable to load drone pack.";
				};			
		};

		[_player,GOL_PACKED_DRONE_AT] call _SelectWeaponPacked;
	};

	_SelectDroneAP = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GOL_Packed_Drone_AP";
			if (_player canAdd _item) then {
				_player additem _item;
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to load drone pack.";
			};			
		};
		[_player,GOL_PACKED_DRONE_AP] call _SelectWeaponPacked;
	};		

	_PackConditionStatic = {
		alive _target &&
		(count crew _target == 0 || ((typeOf _target) in OKS_DroneClassnames)) && 
		vehicle _player != _target && 
		_player canAdd (_target getVariable ["GOL_ItemPacked","GOL_Packed_Drone_AT"]) &&
		(typeOf _target) in GOL_PACKED_STATIC_WEAPONS
	};
	_PackConditionDrone = {
		alive _target &&
		vehicle _player != _target && 
		_player canAdd (_target getVariable ["GOL_ItemPacked","GOL_Packed_Drone_AT"]) &&
		_target isKindOf "helicopter" && 
		(typeOf _target) in OKS_DroneClassnames
	};

 	private _actionHMG = ["Pack_Weapon", "Pack Static HMG","\OKS_GOL_Misc\Data\UI\GOL_HMG_Packed.paa", _PackCode, _PackConditionStatic] call ace_interact_menu_fnc_createAction; 
 	["StaticMGWeapon", 0, ["ACE_MainActions"], _actionHMG,true] call ace_interact_menu_fnc_addActionToClass;

 	private _actionGMG = ["Pack_Weapon", "Pack Static GMG","\OKS_GOL_Misc\Data\UI\GOL_GMG_Packed.paa", _PackCode, _PackConditionStatic] call ace_interact_menu_fnc_createAction; 
	["StaticGrenadeLauncher", 0, ["ACE_MainActions"], _actionGMG,true] call ace_interact_menu_fnc_addActionToClass;

 	private _actionAT = ["Pack_Weapon", "Pack Static AT","\OKS_GOL_Misc\Data\UI\GOL_AT_Packed.paa", _PackCode, _PackConditionStatic] call ace_interact_menu_fnc_createAction; 
	["StaticATWeapon", 0, ["ACE_MainActions"], _actionAT,true] call ace_interact_menu_fnc_addActionToClass;

	private _actionMortar = ["Pack_Weapon", "Pack Mortar","\OKS_GOL_Misc\Data\UI\GOL_Mortar_Packed.paa", _PackCode, _PackConditionStatic] call ace_interact_menu_fnc_createAction; 
 	["StaticMortar", 0, ["ACE_MainActions"], _actionMortar,true] call ace_interact_menu_fnc_addActionToClass;

	private _actionDrone = ["Pack_Weapon", "Pack Drone","\OKS_GOL_Misc\Data\UI\GOL_Drone_Packed.paa", _PackCode, _PackConditionDrone] call ace_interact_menu_fnc_createAction; 
	["Helicopter", 0, ["ACE_MainActions"], _actionDrone,true] call ace_interact_menu_fnc_addActionToClass;

	_actionHMGDeploy = ["Deploy Weapon", "Deploy Static HMG","\OKS_GOL_Misc\Data\UI\GOL_HMG_Packed.paa", _codeDeployHMG, _conditionMG] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionHMGDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionMortarDeploy = ["Deploy Mortar", "Deploy Mortar","\OKS_GOL_Misc\Data\UI\GOL_Mortar_Packed.paa", _codeDeployMortar, _conditionMortar] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionMortarDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionGMGDeploy = ["Deploy Grenade Launcher", "Deploy Grenade Launcher","\OKS_GOL_Misc\Data\UI\GOL_GMG_Packed.paa", _codeDeployGMG, _conditionGMG] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionGMGDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionATDeploy = ["Deploy AT Launcher", "Deploy AT Launcher","\OKS_GOL_Misc\Data\UI\GOL_AT_Packed.paa", _codeDeployAT, _conditionAT] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionATDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionDroneATDeploy = ["Deploy Drone", "Deploy Drone (AT)","\OKS_GOL_Misc\Data\UI\GOL_Drone_Packed.paa", _codeDeployDrone_AT, _conditionDroneAT] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionDroneATDeploy] call ace_interact_menu_fnc_addActionToClass;	

    _actionDroneAPDeploy = ["Deploy Drone", "Deploy Drone (AP)","\OKS_GOL_Misc\Data\UI\GOL_Drone_Packed.paa", _codeDeployDrone_AP, _conditionDroneAP] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionDroneAPDeploy] call ace_interact_menu_fnc_addActionToClass;	

    // _actionSelectStatic = ["Select_Static", "Select Packed Weapon","\A3\ui_f\data\map\vehicleicons\iconBackpack_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions"], _actionSelectStatic] call ace_interact_menu_fnc_addActionToClass;

    // _actionSelectHMG = ["Select_HMG", "Packed HMG","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa", _SelectHMG, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectHMG] call ace_interact_menu_fnc_addActionToClass;

    // _actionSelectGMG = ["Select_GMG", "Packed GMG","\A3\ui_f\data\map\vehicleicons\iconStaticSearchlight_ca.paa", _SelectGMG, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectGMG] call ace_interact_menu_fnc_addActionToClass;	

    // _actionSelectAT = ["Select_AT", "Packed AT","\A3\ui_f\data\map\vehicleicons\iconStaticAA_ca.paa", _SelectAT, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectAT] call ace_interact_menu_fnc_addActionToClass;	

    // _actionSelectMortar = ["Select_Mortar", "Packed Mortar","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", _SelectMortar, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectMortar] call ace_interact_menu_fnc_addActionToClass;		

    // _actionSelectDroneAP = ["Select_Drone", "Packed Drones","\A3\drones_f\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectDroneAP] call ace_interact_menu_fnc_addActionToClass;		

    // _actionSelectDroneAP = ["Select_Drone_AP", "Packed Drone (AP)","\A3\drones_f\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa", _SelectDroneAP, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static","Select_Drone"], _actionSelectDroneAP] call ace_interact_menu_fnc_addActionToClass;		

    // _actionSelectDroneAT = ["Select_Drone_AT", "Packed Drone (AT)","\A3\drones_f\Air_F_Gamma\UAV_01\Data\UI\UAV_01_CA.paa", _SelectDroneAT, {true}] call ace_interact_menu_fnc_createAction;
	// ["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static","Select_Drone"], _actionSelectDroneAT] call ace_interact_menu_fnc_addActionToClass;		

};