Params ["_Vehicle","_TurretIndex"];

_Pylons = getPylonMagazines _Vehicle;
_i = 1;
{
	_Vehicle setPylonLoadout [_i, _X, true,[_TurretIndex]];
	_i = _i + 1;
} foreach _Pylons;