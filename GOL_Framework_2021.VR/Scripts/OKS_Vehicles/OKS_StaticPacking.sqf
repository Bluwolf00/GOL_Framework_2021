/// [] execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";
if(isServer) then {
	["StaticWeapon", "init", {(_this select 0) enableWeaponDisassembly false}] call CBA_fnc_addClassEventHandler;
	{if(_X isKindOf "StaticWeapon") then {_X enableWeaponDisassembly false}} foreach Vehicles;
};

if (hasInterface) then {

    _conditionMG = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMGWeapon"}; //<only works MP
	_conditionMortar = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "") && (player getVariable ["OKS_PackedClassname",""]) isKindOf "StaticMortar"}; //<only works MP

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
					_object setVehicleAmmo 0;
					_ammoArray = (_unit getVariable ["OKS_PackedMagazines", []]);
					
					{
						_X params ["_Classname","_AmmoCount"];
						_object addMagazineTurret [_Classname, [0],_AmmoCount];
					} foreach _ammoArray;
					
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
			_player setVariable ["OKS_PackedMagazines",magazinesAmmo _target];
			deleteVehicle _target;
			systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName];
		},
		{
		},_this] call CBA_fnc_progressBar;
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

};


