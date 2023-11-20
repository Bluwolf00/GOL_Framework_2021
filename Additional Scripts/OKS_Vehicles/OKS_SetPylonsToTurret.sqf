// [vehicle player,3] execVM "Scripts\OKS_Vehicles\OKS_SetPylonsToTurret.sqf"
Params ["_Vehicle","_TurretIndex"];

_Pylons = getPylonMagazines _Vehicle;
_i = 1;
{
	//systemChat _X;
	_Pylon = _X;
	if ({[_X, _Pylon,false] call BIS_fnc_inString} count ["AGM","PG","APKWS","HOT"] > 0) then {
		_Vehicle setPylonLoadout [_i, _X, true,[_TurretIndex]];	
	};
	_i = _i + 1;
} foreach _Pylons;