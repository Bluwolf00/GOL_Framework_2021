/// [this] execVM "Scripts\OKS_Vehicles\OKS_AbandonVehicle.sqf";
/// [this] spawn OKS_AbandonVehicle;
/// [vehicle]

if(!isServer) exitWith {};

Params
[
	["_vehicle", ObjNull, [ObjNull]]
];

// Check if vehicle has any gunner turrets (occupied or empty)
private _hasGunnerSeat = {
    params ["_vehicle"];
    private _gunnerTurrets = [];
    
    // Get all turrets and check their roles
    {
        _turretConfig = [_vehicle, _x] call BIS_fnc_turretConfig;
        _isGunner = getNumber (_turretConfig >> "primaryGunner") > 0;
        if (_isGunner) then {_gunnerTurrets pushBack _x};
    } forEach allTurrets [_vehicle, false];;
    
    count _gunnerTurrets > 0
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

systemChat format["%1 does not have gunner. Exiting Abandon Vehicle", [configFile >> "CfgVehicles" >> typeOf _Vehicle] call BIS_fnc_displayName];
