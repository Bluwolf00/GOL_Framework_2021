/// [] execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";
if(isServer) then {
	["StaticWeapon", "init", {(_this select 0) enableWeaponDisassembly false}] call CBA_fnc_addClassEventHandler;
	{if(_X isKindOf "StaticWeapon") then {_X enableWeaponDisassembly false}} foreach Vehicles;
};

Private _Blacklist = [];
OKS_DronePackedClassnames = [
	"GOL_Packed_Drone_AT",
	"GOL_Packed_Drone_AP",
	"GOL_Packed_Drone_Recon",
	"GOL_Packed_Drone_Supply"
];

if (hasInterface) then {
 //  && !((player getVariable ["OKS_PackedClassname",""]) in _Blacklist
    _conditionMG = {("GOL_Packed_HMG" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortar = {("GOL_Packed_Mortar" in (itemsWithMagazines player))}; //<only works MP
	_conditionGMG = {("GOL_Packed_GMG" in (itemsWithMagazines player))}; //<only works MP
	_conditionAT = {("GOL_Packed_AT" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneAT = {("GOL_Packed_Drone_AT" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneAP = {("GOL_Packed_Drone_AP" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneRecon = {("GOL_Packed_Drone_Recon" in (itemsWithMagazines player))}; //<only works MP
	_conditionDroneSupply = {("GOL_Packed_Drone_Supply" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortarHE = {("GOL_Packed_60mm_HE" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortarHEAB = {("GOL_Packed_60mm_HEAB" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortarSmoke = {("GOL_Packed_60mm_Smoke" in (itemsWithMagazines player))}; //<only works MP
	_conditionMortarFlare = {("GOL_Packed_60mm_Flare" in (itemsWithMagazines player))}; //<only works MP

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

	_codeDeployDrone_Recon = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_Drone_Recon";
			private _type = GOL_Packed_Drone_Recon;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying Recon Drone...";
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

	_codeDeployDrone_Supply = {	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			private _item = "GOL_Packed_Drone_Supply";
			private _type = GOL_Packed_Drone_Supply;
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			private _actionName = "Deploying Supply Drone...";
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
					[_object, "drone_box", toLower str (side _caller)] call GW_Gear_Fnc_Handler;
				}
			},{},[_target, _caller, _actionId,_item,_type]] call CBA_fnc_progressBar;	
		}
	};	

	_UnpackMortarHE = {
		private _actionName = "Unpacking HE Rounds...";	
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			_item = "UK3CB_BAF_1Rnd_60mm_Mo_Shells";
			_Position = _player getPos [1.4,(getDir _player)];
			_GroundWeaponHolder = createVehicle  ["GroundWeaponHolder", _Position, [], 0, "CAN_COLLIDE"];
			for "_i" from 1 to 4 do {
				if (_player canAdd _item) then {
					_player addMagazineGlobal _item;
				} else {
					_GroundWeaponHolder addMagazineCargoGlobal [_item,1];
					systemChat "Your inventory is full. Unpacked on ground."
				};
			};
		},
		{
		},_this] call CBA_fnc_progressBar;
	};
	_UnpackMortarHEAB = {
		private _actionName = "Unpacking HE Airburst Rounds...";	
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			_item = "UK3CB_BAF_1Rnd_60mm_Mo_AB_Shells";
			_Position = _player getPos [1.4,(getDir _player)];
			_GroundWeaponHolder = createVehicle  ["GroundWeaponHolder", _Position, [], 0, "CAN_COLLIDE"];
			for "_i" from 1 to 4 do {
				if (_player canAdd _item) then {
					_player addMagazineGlobal _item;
				} else {
					_GroundWeaponHolder addMagazineCargoGlobal [_item,1];
					systemChat "Your inventory is full. Unpacked on ground."
				};
			};
		},
		{
		},_this] call CBA_fnc_progressBar;
	};
	_UnpackMortarSmoke = {
		private _actionName = "Unpacking Smoke Rounds...";	
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			_item = "UK3CB_BAF_1Rnd_60mm_Mo_Smoke_White";
			_Position = _player getPos [1.4,(getDir _player)];
			_GroundWeaponHolder = createVehicle  ["GroundWeaponHolder", _Position, [], 0, "CAN_COLLIDE"];
			for "_i" from 1 to 4 do {
				if (_player canAdd _item) then {
					_player addMagazineGlobal _item;
				} else {
					_GroundWeaponHolder addMagazineCargoGlobal [_item,1];
					systemChat "Your inventory is full. Unpacked on ground."
				};
			};
		},
		{
		},_this] call CBA_fnc_progressBar;
	};	
	_UnpackMortarFlare = {
		private _actionName = "Unpacking Flare Rounds...";	
		if (primaryWeapon player != "") then {
			player playMoveNow "AmovPknlMstpSlowWrflDnon";
		};
		[_actionName, 3, {true}, {
			(_this select 0) params ["_target", "_player", "_actionId"];
			_item = "UK3CB_BAF_1Rnd_60mm_Mo_Flare_White";
			_Position = _player getPos [1.4,(getDir _player)];
			_GroundWeaponHolder = createVehicle  ["GroundWeaponHolder", _Position, [], 0, "CAN_COLLIDE"];
			for "_i" from 1 to 4 do {
				if (_player canAdd _item) then {
					_player addMagazineGlobal _item;
				} else {
					_GroundWeaponHolder addMagazineCargoGlobal [_item,1];
					systemChat "Your inventory is full. Unpacked on ground."
				};
			};
		},
		{
		},_this] call CBA_fnc_progressBar;
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

    _actionDroneReconDeploy = ["Deploy Drone", "Deploy Drone (Recon)","\OKS_GOL_Misc\Data\UI\GOL_Drone_Packed.paa", _codeDeployDrone_Recon, _conditionDroneRecon] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionDroneReconDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionDroneSupplyDeploy = ["Deploy Drone", "Deploy Drone (Supply)","\OKS_GOL_Misc\Data\UI\GOL_Drone_Packed.paa", _codeDeployDrone_Supply, _conditionDroneSupply] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionDroneSupplyDeploy] call ace_interact_menu_fnc_addActionToClass;

    _actionUnpackHE = ["Unpack 60mm HE", "Unpack 60mm HE","\OKS_GOL_Misc\Data\UI\60mm_HE.paa", _UnpackMortarHE, _conditionMortarHE] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionUnpackHE] call ace_interact_menu_fnc_addActionToClass;

    _actionUnpackHEAB = ["Unpack 60mm HEAB Airburst", "Unpack 60mm HEAB Airburst","\OKS_GOL_Misc\Data\UI\60mm_HEAB.paa", _UnpackMortarHEAB, _conditionMortarHEAB] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionUnpackHEAB] call ace_interact_menu_fnc_addActionToClass;

    _actionUnpackSmoke = ["Unpack 60mm Smoke", "Unpack 60mm Smoke","\OKS_GOL_Misc\Data\UI\60mm_Smoke.paa", _UnpackMortarSmoke, _conditionMortarSmoke] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionUnpackSmoke] call ace_interact_menu_fnc_addActionToClass;

    _actionUnpackFlare = ["Unpack 60mm Flare", "Unpack 60mm Flare","\OKS_GOL_Misc\Data\UI\60mm_Flare.paa", _UnpackMortarFlare, _conditionMortarFlare] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _actionUnpackFlare] call ace_interact_menu_fnc_addActionToClass;

	player addEventHandler ["Put", {
		params ["_unit", "_container", "_item"];
		if(
			(_item in OKS_DronePackedClassnames) &&
			(_item in (itemCargo _container)) &&
			({_X == _item} count (itemCargo _container)) == count (itemCargo _container)
		) then {
			_Position = _unit getPos [1.3,getDir _unit];
			_container setVectorDirAndUp [[0,0,1], [0,1,0]];
			_container setPosATL [_Position select 0, _Position select 1, 0];
		};
	}];
};