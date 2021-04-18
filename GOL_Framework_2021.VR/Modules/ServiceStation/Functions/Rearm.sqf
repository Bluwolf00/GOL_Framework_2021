//	[Vehicle, ServiceStation, FullService] Spawn NEKY_ServiceStation_Rearm;
//	
//	This handles rearming a vehicle
//	
//	Made by NeKo-ArroW

Private ["_Veh","_SS","_FullService","_Ammo","_RearmSpeed","_TempFull","_AmmoCount","_Msg","_PylonIndex","_WeaponIndex","_PylonAmmo","_PylonAmmoMax","_PylonMagazines","_Pylons","_Turrets","_Ammo","_AmmoMax","_Magazines","_PylonFull"];
#include "..\Settings.sqf"

Params ["_Veh","_SS","_FullService"];
if !(_FullService) then {NEKY_ServiceStationActive PushBack _SS; PublicVariable "NEKY_ServiceStationActive"};
_GetPylonMagazines = getPylonMagazines _Veh;
ScopeName "Main";

_Pylons = [];	// [Pylon1,Pylon2]
if !((Count _GetPylonMagazines) isEqualTo 0) then
{
	_PylonAmmo = [];	// [1,4,6,1,24]
	_PylonAmmoMax = [];	// [2,8,6,1,24]
	
	_Number = Count _GetPylonMagazines;
	_PylonIndex = 0;
	_WeaponIndex = 0;
	While {!(_Number isEqualTo _WeaponIndex)} do
	{
		_AmmoOnPylon = _Veh AmmoOnPylon _PylonIndex;
		
		if (_AmmoOnPylon isEqualTo -1) then
		{
			_PylonIndex = _PylonIndex +1;
		} else {
			_Magazine = _GetPylonMagazines select _WeaponIndex;
			_AmmoMax = ((configfile >> "CfgMagazines" >> _Magazine >> "count") call BIS_fnc_getCfgData);
			if (!(_AmmoMax isEqualTo _AmmoOnPylon) && (TypeName _AmmoMax isEqualTo "SCALAR")) then
			{
				_Pylons PushBack _PylonIndex;
				_PylonAmmo pushBack _AmmoOnPylon;
				_PylonAmmoMax pushBack _AmmoMax;
			};
			_PylonIndex = _PylonIndex +1;
			_WeaponIndex = _WeaponIndex +1;
		};
	};
};

_MagAllTurrets = MagazinesAllTurrets _Veh;
_MagToRemove = [];
_MagAllTurrets Apply {if ((_x select 0) in _GetPylonMagazines) then {_MagToRemove pushBack _x}};
For "_i" from 0 to ((Count _MagToRemove) -1) step 1 do
{
	_MagAllTurrets deleteAt (_MagAllTurrets Find (_MagToRemove select _i));
};

_Turrets = [];	// [[Turret1],[Turret2]]
if !((Count _MagAllTurrets) isEqualTo 0) then 
{
	// Store current ammo, turrets and magazine types
	_Magazines = [];	// [["mag1","mag2","mag3"], ["mag1"]]
	_Ammo = [];
	_AmmoMax = [];

	// Store all turret, magazine, ammo and ammo max information
	Private ["_CurTurret","_TempMagazinesArray","_TempAmmoArray","_TempAmmoMaxArray"];
	
	{
		_Magazine = (_x select 0);
		_TempAmmo = (_x select 2);
		_TempAmmoMax = ((configfile >> "CfgMagazines" >> _Magazine >> "count") call BIS_fnc_getCfgData);
		if !(_TempAmmo isEqualTo _TempAmmoMax) then
		{
			// First run defining
			if (isNil "_CurTurret") then 
			{
				_CurTurret = (_x select 1);
				_TempMagazinesArray = [];
				_TempAmmoArray = [];
				_TempAmmoMaxArray = [];
			};
			
			// Store turret arrays before starting on the next turret
			if !((_x select 1) isEqualTo _CurTurret) then 
			{
				_Magazines pushBack _TempMagazinesArray;
				_Ammo pushBack _TempAmmoArray;
				_AmmoMax pushBack _TempAmmoMaxArray;
				_TempMagazinesArray = [];
				_TempAmmoArray = [];
				_TempAmmoMaxArray = [];
				_CurTurret = (_x select 1);
			};
			
			if !(_CurTurret in _Turrets) then {_Turrets pushBack _CurTurret};
			_TempMagazinesArray pushBack _Magazine;
			_TempAmmoArray pushBack _TempAmmo;
			_TempAmmoMaxArray pushBack _TempAmmoMax;
		};
		
		if ((Count _MagAllTurrets) isEqualTo (_ForEachIndex +1)) then 
		{
			if !(isNil "_TempMagazinesArray") then
			{
				if ((Count _TempMagazinesArray) > 0) then
				{
					_Magazines pushBack _TempMagazinesArray;
					_Ammo pushBack _TempAmmoArray;
					_AmmoMax pushBack _TempAmmoMaxArray;
				};
			};
		};
	} forEach _MagAllTurrets;
};

// Start servicing the vehicle
if !(((Count _Turrets) isEqualTo 0) && ((Count _Pylons) isEqualTo 0)) then
{
	_MsgIndex = 0;
	While {(_Veh in NEKY_ServiceStationArray) && !(((Count _Turrets) isEqualTo 0) && ((Count _Pylons) isEqualTo 0))} do
	{
		_Full = [];
		["Rearming", _Veh, true, _MsgIndex] spawn NEKY_ServiceStation_Hints;
		
		// Add Ammo to turrets
		if !((Count _Turrets) isEqualTo 0) then
		{
			_Turret = _Turrets select 0;
			
			_AmmoCount = (_Ammo select 0) select 0;
			_TempAmmoMax = (_AmmoMax select 0) select 0;
			_Magazine = (_Magazines select 0) select 0;
			_AmmoToAdd = (_TempAmmoMax * _RearmSpeed);
			if (_AmmoToAdd < 0.1) then {_AmmoCount = _AmmoCount + 0.1} else {_AmmoCount = _AmmoCount + (_TempAmmoMax * _RearmSpeed)};
			If (_AmmoCount >= _TempAmmoMax) then 
			{
				_AmmoCount = _TempAmmoMax;
				_TempFull = True;
			} else {
				_TempFull = False;
			};
			(_Ammo select 0) Set [0,_AmmoCount];
			
			if (_AmmoCount >= 1) then
			{
				[[_Veh,_Turret,_AmmoCount,_Magazine],
				{
					{
						[_This,
						{
							Params ["_Veh","_Turret","_AmmoCount","_Magazine"]; 
							_Veh setMagazineTurretAmmo [_Magazine, _AmmoCount, _Turret];
						}] RemoteExec ["BIS_FNC_SPAWN",_x];
					} forEach (Crew (_This select 0));
				}] remoteExec ["BIS_FNC_SPAWN",2];
			};

			// Remove full turrets
			if (_TempFull) then
			{
				(_Magazines select 0) deleteAt 0;
				(_Ammo select 0) deleteAt 0;
				(_AmmoMax select 0) deleteAt 0;
				
				if ((Count (_Magazines select 0)) isEqualTo 0) then 
				{
					_Magazines deleteAt 0;
					_Ammo deleteAt 0;
					_AmmoMax deleteAt 0;
					_Turrets deleteAt 0;
				};
			};
		};
		
		// Rearming Pylons
		if !((Count _Pylons) isEqualTo 0) then
		{
			_Pylon = (_Pylons select 0);
			_AmmoCount = (_PylonAmmo select 0);
			_TempAmmoMax = (_PylonAmmoMax select 0);
			_AmmoToAdd = (_TempAmmoMax * _RearmSpeed);
			if (_AmmoToAdd < 0.33) then {_AmmoCount = _AmmoCount + 0.33} else {_AmmoCount = _AmmoCount + (_TempAmmoMax * _RearmSpeed)};
			If (_AmmoCount >= _TempAmmoMax) then 
			{
				_AmmoCount = _TempAmmoMax;
				_PylonFull = True;
			} else {
				_PylonFull = False;
			};
			_PylonAmmo Set [0,_AmmoCount];

			if (_AmmoCount >= 1) then
			{
				_Veh SetAmmoOnPylon [_Pylon, _AmmoCount];
				if (_PylonFull) then 
				{
					_Pylons deleteAt 0;
					_PylonAmmo deleteAt 0;
					_PylonAmmoMax deleteAt 0;
				};
			};
		};
		
		if (_MsgIndex isEqualTo 2) then {_MsgIndex = 0} else {_MsgIndex = _MsgIndex +1};
		Sleep 1;
		
		if (!(_Veh in NEKY_ServiceStationArray)) Then {BreakTo "Main"};
	};
	if (_Veh in NEKY_ServiceStationArray) then {[[_Veh],{(_This select 0) setVehicleAmmo 1}] remoteExec ["BIS_FNC_SPAWN",0]; ["Rearming Complete!", _Veh] spawn NEKY_ServiceStation_Hints};
} else {
	["Rearming not needed", _Veh] spawn NEKY_ServiceStation_Hints;
	Sleep 2;
};

if (!(_Veh in NEKY_ServiceStationArray)) exitWith {[_SS,true] call NEKY_ServiceStation_Available; ["You have left the service station, service ending",_Veh] call NEKY_ServiceStation_Hints};
if (_FullService) then {["Service complete!", _Veh] spawn NEKY_ServiceStation_Hints};
if ((driver _Veh) in _Veh) then {_Veh engineOn True};
[_SS,false] call NEKY_ServiceStation_Available;