/// [] execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";
if(isServer) then {
	["StaticWeapon", "init", {(_this select 0) enableWeaponDisassembly false}] call CBA_fnc_addClassEventHandler;
	{if(_X isKindOf "StaticWeapon") then {_X enableWeaponDisassembly false}} foreach Vehicles;
};

if (hasInterface) then {

    _conditionMG = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMGWeapon" && ("GW_Item_StaticDummy" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortar = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMortar" && ("GW_Item_StaticDummy" in (itemsWithMagazines player))}; //<only works MP
	_conditionGMG = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticGrenadeLauncher" && ("GW_Item_StaticDummy" in (itemsWithMagazines player))}; //<only works MP
	_conditionAT = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticATWeapon" && ("GW_Item_StaticDummy" in (itemsWithMagazines player))}; //<only works MP


	_codeDeploy = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};

			private _actionName = "Deploying Static Weapon...";
			if ((_caller getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMortar") then {
				_actionName = "Deploying Mortar.."
			};

			[_actionName, 3, {true}, {
				(_this select 0) params ["_target", "_unit", "_actionId"];
				private _type = (_unit getVariable ["OKS_PackedClassname", ""]);
				private _objectRemoved = true;
				private _dir = (getDir _unit);
				private _pos = (player getRelPos [2, 0]);
				_pos set [2, ((getPosATL player) select 2)];

				{
					if !(_x isEqualTo "GW_Item_StaticDummy") exitWith {
						_unit removeItem "GW_Item_StaticDummy";
						_objectRemoved = true;
					};
				} count (itemsWithMagazines _unit);

				if (_objectRemoved && !(_type isEqualTo "")) then {
					private _object = createVehicle [_type, [0,0,0], [], 0, "NONE"];			
					_ammoArray = (_unit getVariable ["OKS_PackedMagazines", []]);
					
					if(_ammoArray isNotEqualTo []) then {
						_object setVehicleAmmo 0;
						{
							_X params ["_Classname","_AmmoCount"];
							_object addMagazineTurret [_Classname, [0],_AmmoCount];
						} foreach _ammoArray;
					};
					
					_object setPosATL _pos;
					_object setDir _dir;
					_unit setVariable ["OKS_PackedClassname", ""];
				};
			},
			{
				
			},[_target, _caller, _actionId]] call CBA_fnc_progressBar;	
		}
	};

	_PackCode = {
		private _actionName = "Packing Static Weapon..";
		if ((_Player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMortar") then {
			_actionName = "Packing Mortar.."
		};
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			_player setVariable ["OKS_PackedClassname",typeOf _target,true];
			_player setVariable ["OKS_PackedMagazines",magazinesAmmo _target,true];
			
			systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName];

			private _item = "GW_Item_StaticDummy";
			if (_player canAdd _item) then {
				_player additem _item;
			} else {
				private _pos = (getPosATL _target);
				private _weaponHolder = "WeaponHolderSimulated" createVehicle _pos;
				_weaponHolder setPosATL _pos;
				_weaponHolder addItemCargoGlobal [_item, 1];
			};
			deleteVehicle _target;
		},
		{
		},_this] call CBA_fnc_progressBar;
	};

	_SelectHMG = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GW_Item_StaticDummy";
			if (_player canAdd _item) then {
				_player additem _item;
				_player setVariable ["OKS_PackedClassname",_Classname,true];
				_player setVariable ["OKS_PackedMagazines",[]];
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
			private _item = "GW_Item_StaticDummy";
			if (_player canAdd _item) then {
				_player additem _item;
				_player setVariable ["OKS_PackedClassname",_Classname,true];
				_player setVariable ["OKS_PackedMagazines",[]];
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
			private _item = "GW_Item_StaticDummy";
			if (_player canAdd _item) then {
				_player additem _item;
				_player setVariable ["OKS_PackedClassname",_Classname,true];
				_player setVariable ["OKS_PackedMagazines",[]];
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to equip Static Weapon Pack."
			};
		};		
		[_player,GOL_PACKED_GMG] call _SelectWeaponPacked;
	};	
	_SelectAT = {
		_SelectWeaponPacked = {
			Params ["_player","_Classname"];
			private _item = "GW_Item_StaticDummy";
			if (_player canAdd _item) then {
				_player additem _item;
				_player setVariable ["OKS_PackedClassname",_Classname,true];
				_player setVariable ["OKS_PackedMagazines",[]];
				systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> _Classname] call BIS_fnc_displayName];
			} else {
				systemChat "Your inventory is full. Unable to equip Static Weapon Pack."
			};
		};
		[_player,GOL_PACKED_AT] call _SelectWeaponPacked;
	};	
		
	_PackCondition = { alive _target && (_player getVariable ['OKS_PackedClassname',''] isEqualTo '') && count crew _target == 0 && vehicle _player != _target };
 	private _actionMG = ["Pack_Weapon", "Pack Static Weapon","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa", _PackCode, _PackCondition] call ace_interact_menu_fnc_createAction; 
 	["StaticMGWeapon", 0, ["ACE_MainActions"], _actionMG,true] call ace_interact_menu_fnc_addActionToClass;
	["StaticGrenadeLauncher", 0, ["ACE_MainActions"], _actionMG,true] call ace_interact_menu_fnc_addActionToClass;

	private _actionMortar = ["Pack_Weapon", "Pack Mortar","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", _PackCode, _PackCondition] call ace_interact_menu_fnc_createAction; 
 	["StaticMortar", 0, ["ACE_MainActions"], _actionMortar,true] call ace_interact_menu_fnc_addActionToClass;

	_actionMGDeploy = ["Deploy Weapon", "Deploy Static Weapon","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa", _codeDeploy, _conditionMG] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionMGDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionMortarDeploy = ["Deploy Mortar", "Deploy Mortar","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", _codeDeploy, _conditionMortar] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionMortarDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionGMGDeploy = ["Deploy Grenade Launcher", "Deploy Grenade Launcher","\A3\ui_f\data\map\vehicleicons\iconStaticSearchlight_ca.paa", _codeDeploy, _conditionGMG] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionGMGDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionATDeploy = ["Deploy AT Launcher", "Deploy AT Launcher","\A3\ui_f\data\map\vehicleicons\iconStaticAA_ca.paa", _codeDeploy, _conditionAT] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionATDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionSelectStatic = ["Select_Static", "Select Packed Static Weapon","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", {}, {true}] call ace_interact_menu_fnc_createAction;
	["Box_NATO_Equip_F", 0, ["ACE_MainActions"], _actionSelectStatic] call ace_interact_menu_fnc_addActionToClass;

    _actionSelectHMG = ["Select_HMG", "Packed HMG","\A3\ui_f\data\map\vehicleicons\iconStaticMG_ca.paa", _SelectHMG, {true}] call ace_interact_menu_fnc_createAction;
	["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectHMG] call ace_interact_menu_fnc_addActionToClass;

    _actionSelectGMG = ["Select_GMG", "Packed GMG","\A3\ui_f\data\map\vehicleicons\iconStaticSearchlight_ca.paa", _SelectGMG, {true}] call ace_interact_menu_fnc_createAction;
	["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectGMG] call ace_interact_menu_fnc_addActionToClass;	

    _actionSelectAT = ["Select_AT", "Packed AT","\A3\ui_f\data\map\vehicleicons\iconStaticAA_ca.paa", _SelectAT, {true}] call ace_interact_menu_fnc_createAction;
	["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectAT] call ace_interact_menu_fnc_addActionToClass;	

    _actionSelectMortar = ["Select_Mortar", "Packed Mortar","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", _SelectMortar, {true}] call ace_interact_menu_fnc_createAction;
	["Box_NATO_Equip_F", 0, ["ACE_MainActions","Select_Static"], _actionSelectMortar] call ace_interact_menu_fnc_addActionToClass;		
};


