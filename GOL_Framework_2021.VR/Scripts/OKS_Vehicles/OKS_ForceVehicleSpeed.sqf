// Example
// [_Vehicle] spawn OKS_ForceVehicleSpeed;    
// [_Vehicle] execVM "Scripts\OKS_Spawn\OKS_ForceVehicleSpeed.sqf";

if(!isServer) exitWith { false };

Params ["_Vehicle"];

if(_Vehicle isKindOf "StaticWeapon" || _Vehicle isKindOf "Air") exitWith {
	//systemChat "OKS_AbandonVehicle: Is Static Weapon/Air Exiting.."
};

Private _Speed = 10;
private _VehicleType = (_Vehicle call BIS_fnc_objectType)#1;

switch (toLower (_VehicleType)) do {
     case "wheeledapc": { 
        _Speed = 12;
    };   
     case "trackedapc": { 
        _Speed = 8;
    };   
    case "tank": { 
        _Speed = 8;
    };
    case "car": { 
        _Speed = 12;
    };   
};

[_Vehicle,_Speed] remoteExec ["forceSpeed",0];
//systemChat format ["%1 forced speed to %2.",typeOf _Vehicle,_Speed];