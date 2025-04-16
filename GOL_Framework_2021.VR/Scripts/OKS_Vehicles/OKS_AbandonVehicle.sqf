/// [this] execVM "Scripts\OKS_Vehicles\OKS_AbandonVehicle.sqf";
/// [this] spawn OKS_AbandonVehicle;
/// [vehicle]

if(!isServer) exitWith {};

Params
[
	["_vehicle", ObjNull, [ObjNull]]
];

if(_vehicle isKindOf "StaticWeapon") exitWith {
	//systemChat "OKS_AbandonVehicle: Is Static Weapon Exiting.."
};

// Check if vehicle has any gunner turrets (occupied or empty)
private _hasGunnerSeat = {
    params ["_vehicle"];
	private _Return = false;
    _Gunner = gunner _vehicle;
	if(!isNil "_Gunner") then {
		if(!isNull _Gunner) then {
			_Return = true;
		}
	} else {
		if(_vehicle emptyPositions "Cargo" > 0) then {
			_Return = true;
		}
	};

	_Return
};
_Repetitions = 0;
waitUntil {_Repetitions = _Repetitions + 1; sleep 2; count (crew _vehicle) > 1 || _Repetitions > 10};

if(_Repetitions > 10) exitWith {
	systemChat "OKS_AbandonVehicle: Vehicle crew did not exist after 20 seconds. Exiting.. "
};

// Only proceed if vehicle has weapons
if (_vehicle call _hasGunnerSeat) exitWith {
	[_vehicle,_hasGunnerSeat] spawn {
		params ["_vehicle","_hasGunnerSeat"];
		
		while {alive _vehicle} do {
			// Re-check gunner seats in case turret gets destroyed
			if ([_vehicle] call _hasGunnerSeat && !canFire _vehicle) then {
				systemChat "_HasGunnerSeat and cannot fire. Abandon Vehicle.";
				{_x leaveVehicle _vehicle} forEach crew _vehicle;
				_vehicle lock true;
				break;
			};
			sleep 5;
		};
	};
};

//systemChat format["%1 does not have gunner. Exiting Abandon Vehicle", [configFile >> "CfgVehicles" >> typeOf _Vehicle] call BIS_fnc_displayName];
