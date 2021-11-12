/* [this,false] execVM "Scripts\OKS_Ambience\GW_DoParadrop.sqf"; */

params ["_unit","_HALO"];
private _backpack = (unitBackpack _unit);
_unit setVariable ["BACKPACK_INVENTORY", ((getUnitLoadout _unit) select 5)];
if(isNil "_HALO") then {_HALO = false};
if(_HALO) then {
		removeBackPack _unit;
		_unit addBackpack "B_Parachute";
	} else {
		systemChat "Static Drop";
		[{(((getPosATL player) select 2) <= 150)}, {
		params ["_unit"];
		private _pos = (getPos _unit);
		private _chute = createVehicle ["NonSteerable_Parachute_F", _pos, [], 0, "NONE"];
		_chute setDir (getDir _unit);
		_chute setPos _pos;
		_unit moveInDriver _chute;
		_chute setVelocity [0,0,-15];
		_chute spawn { waitUntil {GetPos _this select 2 < 0.5}; (driver _this) action ["Eject",_this]};
	}, [_unit]] call CBA_fnc_waitUntilAndExecute;
};


[{((((getPos player) select 2) < 1) && (alive player)) || !(alive player)}, {
	params ["_unit"];
	if (alive player) then {
		_loadout = (_unit getVariable ["BACKPACK_INVENTORY", nil]);
		if !((_loadout select 0) isEqualTo "") then {
			_currentLoadout = (getUnitLoadout _unit);
			_currentLoadout set [5, (_unit getVariable ["BACKPACK_INVENTORY",nil])];
			_unit setUnitLoadout _currentLoadout;
		};
	} else {
		[{(alive player)}, {
			[{
				params ["_unit"];
				_unit setVariable (_unit getVariable ["BACKPACK_INVENTORY",nil]);
			}, _this, 1] call CBA_fnc_waitAndExecute;
		}, _this] call CBA_fnc_waitUntilAndExecute;
	};
}, [_unit]] call CBA_fnc_waitUntilAndExecute;

/*
[{(isTouchingGround player) || (((getPos player) select 2) < 1) && (alive player)}, {
	params ["_unit"];
	_loadout = (_unit getVariable [QGVAR(getUnitLoadout), nil]);
	if !((_loadout select 0) isEqualTo "") then {
		_currentLoadout = (getUnitLoadout _unit);
		_currentLoadout set [5, (_unit getVariable QGVAR(getUnitLoadout))];
		_unit setUnitLoadout _currentLoadout;
	};
}, [_unit]] call CBA_fnc_waitUntilAndExecute;
/*
