// [player,1] spawn OKS_Support_SpawnModule;

Params [
	["_Caller",objNull,[objNull,[]]],
	["_Side",west,[sideUnknown]],
	["_Type",1,[0]],
	["_Direction",-1,[0]]
];
Private ["_Laser","_Pos","_AircraftClass","_WeaponText"];
_AircraftClass = [_Side] call OKS_Support_Settings;

if(_Caller isEqualType player) then {
	_Laser = laserTarget _Caller;
	if(isNil "_Laser") exitWith { SystemChat "Laser not found. Exiting.."};
	_Pos = getPos _Laser;
};
if(_Caller isEqualType []) then {
	_Pos = _Caller;
};

private _logic = createSimpleObject ["Building", _Pos, true];
_logic hideObjectGlobal true;
_logic setVariable ["Type", _Type];
_logic setVariable ["Vehicle", _AircraftClass];
if(_Direction == -1) then {
	_logic setDir (player getDir (laserTarget player));
} else {
	_logic setDir _Direction;
};
[_logic, [], true] spawn BIS_fnc_moduleCAS;

switch (_Type) do
{
	case 2:
	{
		_WeaponText = "guns & missiles";
	};
	case 3:
	{
		_WeaponText = "bombs";
	};
	default
	{
		_WeaponText = "guns & missiles";
	};
};

if !(isNil "OKS_Chat") then {
	["HQ","side",format["Phantom callsign is inbound with %1, out.",_WeaponText]] execVM "Scripts\OKS_Ambience\OKS_Chat.sqf";
};

/// PAA portrait = "\a3\Modules_F_Curator\Data\portraitCAS_ca.paa";