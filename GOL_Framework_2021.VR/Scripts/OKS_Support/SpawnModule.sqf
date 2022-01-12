// [player,1] spawn OKS_Support_SpawnModule;

Params [
	["_Caller",objNull,[objNull,[]]],
	["_Side",west,[sideUnknown]],
	["_Type",1,[0]],
	["_Direction",-1,[0]],
	["_ShouldChat",false,[false]]
];
Private ["_Laser","_Pos","_AircraftClass","_WeaponText"];
_Settings = [_Side] call OKS_Support_Settings;
_Settings Params ["_AircraftClass","_Timer"];

if(_Caller isEqualType player) then {
	_Laser = laserTarget _Caller;
	if(isNil "_Laser") exitWith { SystemChat "Laser not found. Exiting.."};
	_Pos = getPos _Laser;
};
if(_Caller isEqualType []) then {
	_Pos = _Caller;
};

_marker = createMarker [format["CAS_Marker_%1",random 9999],_Pos];
_marker setMarkerType "Contact_arrowSmall1";
_marker setMarkerShape "ICON";
_marker setMarkerSize [1.5,1.5];
_marker setMarkerColor "colorRed";
_marker setMarkerText format["Airstrike: %1",name player];
if(_Caller isEqualType player) then {
	_marker setMarkerText format["Airstrike: %1",name _Caller];
};

private _logic = createSimpleObject ["Building", _Pos, true];
_logic hideObjectGlobal true;
_logic setVariable ["Type", _Type];
_logic setVariable ["Vehicle", _AircraftClass];
if(_Direction == -1) then {
	_logic setDir ((player getDir (laserTarget player)) + selectRandom [45,-45]);
	_marker setMarkerDir ((player getDir (laserTarget player)) + selectRandom [45,-45]);
} else {
	_logic setDir _Direction;
	_marker setMarkerDir _Direction;
};
[_logic, [], true] spawn BIS_fnc_moduleCAS;

switch (_Type) do
{
	case 0:
	{
		_WeaponText = "guns";
	};
	case 1:
	{
		_WeaponText = "rockets";
	};
	case 2:
	{
		_WeaponText = "guns & rockets";
	};
	case 3:
	{
		_WeaponText = "bombs";
	};
	default
	{
		_WeaponText = "guns";
	};
};

if (!isNil "OKS_Chat" && _ShouldChat) then {
	["HQ","side",format["Phantom callsign is inbound with %1, out.",_WeaponText]] RemoteExec ["OKS_Chat",0];
};
sleep 30;
deleteMarker _marker;
/// PAA portrait = "\a3\Modules_F_Curator\Data\portraitCAS_ca.paa";