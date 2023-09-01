
if (hasInterface) then {
    _condition = {(player getVariable ["OKS_PackedClassname",""] isNotEqualTo "")}; //<only works MP
	// NEKY EDIT START
	_code =
	{	
		params ["_target", "_caller", "_actionId"];	
		[_target, _caller, _actionId] spawn {
			_this params ["_target", "_caller", "_actionId"];
			if (primaryWeapon player != "") then {
				player playMoveNow "AmovPknlMstpSlowWrflDnon";
			};
			["Deploying Mortar..", 3, {true}, {
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
					_object setPosATL _pos;
					_object setDir _dir;
					_unit setVariable ["OKS_PackedClassname", ""];
					_object enableWeaponDisassembly false;
					[_object,
					[
						"<t color='#09F249'>Pack Weapon</t>",
						{
							params ["_target", "_caller", "_actionId", "_arguments"];
							
							if (primaryWeapon player != "") then {
								player playMoveNow "AmovPknlMstpSlowWrflDnon";
							};
							["Packing Mortar..", 3, {true}, {
								(_this select 0) params ["_target", "_caller", "_actionId"];
								_caller setVariable ["OKS_PackedClassname",typeOf _target,true];
								deleteVehicle _target;
								systemChat format["%1 packed.",[configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName];
							},
							{

							},[_target, _caller, _actionId]] call CBA_fnc_progressBar;

						},
						nil,
						1.5,
						true,
						true,
						"",
						"alive _target && (_this getVariable ['OKS_PackedClassname',''] isEqualTo '') && count crew _target == 0 && vehicle _this != _target", // _target, _this, _originalTarget
						5,
						false,
						"",
						""
					]] remoteExec ["AddAction",0];
				};
			},
			{
				
			},[_target, _caller, _actionId]] call CBA_fnc_progressBar;	
		}
	};

    _action = ["Deploy Mortar", "Deploy Mortar","\A3\ui_f\data\map\vehicleicons\iconStaticMortar_ca.paa", _code, _condition] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;

};

