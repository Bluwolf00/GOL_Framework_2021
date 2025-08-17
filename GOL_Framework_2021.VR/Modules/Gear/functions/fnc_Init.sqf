/*
	Author: GuzzenVonLidl
	Applies gear to aa soldier automaticly appon spawning it.
	Players are not affected by this
	Disable autogear by setting it to false
	
	Usage:
	[this, "sl"] call GW_Gear_Fnc_Init;
	
	Arguments:
	0: Unit <OBJECT>
	1: Role <STRING>NOTE: THIS param IS OPTIONAL and SHOULD ONLY BE USED if YOU WANT to FORCE A ROLE
	
	Return Value: NO
	
	Public: NO
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_role", "", ["", []]]
];

private _mainScope = true;

if ((_unit isKindOf "HeadlessClient_F") || !(local _unit)) exitWith {
	false
};
if (_unit getVariable ["GW_Gear_BlackList", false]) exitWith {
	false
};

if (_unit isKindOf "CAManBase") then {
	private _isPlayable = ((isPlayer _unit) || (_unit in switchableUnits));
	private _isSpawned = (_unit getVariable [QEGVAR(Common, isSpawned), false]);

		if (GVAR(Auto_Assign) isEqualTo 0) then {
		// Disable AI Gear
		_mainScope = false;
	};

		if ((GVAR(Auto_Assign) isEqualTo 2) && !_isSpawned) then {
		// Spawnlist units
		_mainScope = false;
	};

		if ((time < 1) && (GVAR(Auto_Assign) isEqualTo 3)) then {
		// Ignore Editor Placed
		_mainScope = false;
	};

	if (_isPlayable) then {
		_mainScope = true;
	};

	// _unit setVariable ["acex_headless_blacklist", true, true]; // if Auto-Gear is being applied disable HC transfer until gear is applied --- DEPRECATED

	if !(typeOf _unit isEqualTo "ace_dragging_clone") then {
		_role = (_unit getVariable [QGVAR(Loadout), ""]);// Check if specific is role assigned

		 if (_role isEqualTo "") then {
			// get role
			_role = "r";
			private _groupType = ((group _unit) getVariable [QGVAR(Loadout_Type), false]);
			private _displayName = getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");

			_role = selectRandom ["r", "mat", "amat", "g", "ag", "ar"];// random role

			if (_isPlayable || !(GVAR(randomGear)) || !_isSpawned) then {
				_role = [_unit] call FUNC(getLoadoutClass);
			};
		};

		// if Auto-Gear is being applied, add an event handler to query if the gear has been applied after a locality switch
		// This is to prevent the gear from not being applied if the unit is switched to a different locality (e.g. HC)
		_handler = _unit addEventHandler ["Local", {
            if(typeName (_this select 0) == "OBJECT") then {
                if !((_this select 0) getVariable ['GW_Gear_appliedGear', false]) then {

                    private _role = (_this select 0) getVariable [QGVAR(Loadout), "r"];
                    [
                        {
                            Params ["_Entity","_Role"];
                            if(typeName _Entity == "OBJECT" && typeName _Role == "STRING") then {
                                [_Entity, _role] call FUNC(Handler);
                                (_Entity) setVariable ['GW_Gear_appliedGear', true, true];
                            } else {
                                format ["[AUTOGEAR] Local EventHandler Param was incorrect. Values: %1",_this] spawn OKS_fnc_LogDebug;
                            };
                        },
                        [(_this select 0), _role],
                        0.5
                    ] call CBA_fnc_waitAndExecute;
                    (_this select 0) removeEventHandler ["Local",_thisEventHandler];
                };
            } else {
                format ["[AUTOGEAR] Local Handler was not an entity. Values: %1",_this] spawn OKS_fnc_LogDebug;
            };
        }];

		if (_mainScope) then {
			[{
				_this call FUNC(Handler);
				(_this select 0) setVariable ['GW_Gear_appliedGear', true, true];
			}, [_unit, _role], 0.5] call CBA_fnc_waitAndExecute;
		};
	} else {
		["Unit is ACE Clone - Bypassing Gear Settings"] remoteExec ["systemChat", 2];
	};
} else {
	if (GVAR(autoRemoveCargo)) then {
		if !(_unit isKindOf "ReammoBox_F") then {
			if !(_unit getVariable ["GW_Disable_autoRemoveCargo", false]) then {
				_mainScope = false;
				clearWeaponCargoGlobal _unit;
				clearMagazineCargoGlobal _unit;
				clearItemCargoGlobal _unit;
				clearBackpackCargoGlobal _unit;
			};
		};
	} else {
		if (_unit isKindOf "Car") then {
			_role = "car";
		} else {
			if (_unit isKindOf "Tank") then {
				_role = "tank";
			} else {
				if (_unit isKindOf "Helicopter") then {
					_role = "heli";
				} else {
					if (_unit isKindOf "Plane") then {
						_role = "plane";
					};
				};
			};
		};
	};
	if (_mainScope) then {
		[{
			_this call FUNC(Handler);
		}, [_unit, _role], 0.5] call CBA_fnc_waitAndExecute;
	};
};