/// [this, false,false] execVM "Scripts\OKS_Vehicles\OKS_Helicopter.sqf"; will apply to single airframe
//  [objNull, false,false] execVM "Scripts\OKS_Vehicles\OKS_Helicopter.sqf" will apply to all airframes on the map including enemy if placed;
/// [vehicle,ShouldDisableThermals,ShouldDisableNVG] - Parameters
/// Add MSS Box true/false

if(!isServer) exitWith {};

Params
[
	["_Vehicle", ObjNull, [ObjNull]],
	["_ShouldDisableThermal", true, [true]],
	["_shouldDisableNVG", false, [true]]
];

OKS_isWhiteList = {
	Params ["_Vehicle"];
	Private "_return";
	_WhiteListWords = ["mi24","mi8"];
	{
		if (((ToLower typeOf _Vehicle) find _X) == -1) then {
			_return = false;
		} else {
			_return = true;
			break;
		};
	} foreach _WhiteListWords;
	if(true) exitWith {_return}
};

Private _Debug_Variable = true;
OKS_Helicopter_Code = {

	Private _Debug_Variable = true;
	Params ["_Vehicle","_ShouldDisableThermal","_shouldDisableNVG"];
	_Vehicle RemoveAllEventHandlers "HandleDamage";
	_Vehicle setVariable ["NEKY_OldDamage",0];
	_Vehicle setVariable ["GW_Disable_autoRemoveCargo",true,true];

	clearItemCargoGlobal _Vehicle;
	clearWeaponCargoGlobal _Vehicle;
	clearMagazineCargoGlobal _Vehicle;
	clearBackpackCargoGlobal _Vehicle;
	_Vehicle disableTIEquipment true;

	if(_ShouldDisableThermal) then {
		_Vehicle setVariable ["A3TI_Disable", true,true];
	};
	if(_shouldDisableNVG) then {
		_Vehicle disableNVGEquipment true;
	};

	_Vehicle setVariable ["gw_gear_blackList",true,true];
	waitUntil{!isNil "OKS_MISSION_SETTINGS"};
	if(_Debug_Variable) then {SystemChat "Setting Cargo Space"};
	waitUntil {sleep 1; !(isNil "ace_cargo_fnc_setSpace")};
	[_Vehicle, 30] call ace_cargo_fnc_setSpace;

	_Vehicle addItemCargoGlobal ["Toolkit",2];
	_Vehicle addMagazineCargoGlobal ["SatchelCharge_Remote_Mag",5];

	// Add Extra Flares

	_CMWeapons = (_Vehicle weaponsTurret [-1]) select {["CM", _X,false] call BIS_fnc_inString};

	{
		_CMWeapon = _X;
		systemchat str _CMWeapon;
		_FlareMag = (getArray (configFile >> "CfgWeapons" >> (_CMWeapon) >> "magazines")
			select 
				(count (getArray (configFile >> "CfgWeapons" >> (_CMWeapon) >> "magazines"))) - 1 );
		{_Vehicle removeMagazinesTurret [_X,[-1]]} forEach getArray (configFile >> "CfgWeapons" >> (_CMWeapon) >> "magazines");
		systemchat str _FlareMag;
		_Vehicle addMagazineTurret [_FlareMag,[-1]];
		_Vehicle addMagazineTurret [_FlareMag,[-1]];
	} foreach _CMWeapons;

	_Vehicle setVehicleAmmo 1;
	
	// Created by Neko-Arrow - Thanks very much
	if([_Vehicle] call OKS_isWhiteList) then {
		_Vehicle addEventHandler ["HandleDamage",
		{
		    Params ["_Unit","_Selection","_NewDamage"];

		    //SystemChat str _Selection;

		    // Exits
		    if !(Alive _Unit) exitWith {};
		    if ( ((ToLower _Selection) find "rotor") == -1 ) exitWith {};

		    // Variables
		    _Multiplier = 0.3;

		    // Added Damage
		    _OldDamage = _Unit getVariable ["NEKY_OldDamage",0];
		    _AddedDamage = _NewDamage - _OldDamage;

		    //if !(_AddedDamage < 0) exitWith { 0 };
		    // New Damage
		    _Damage = _OldDamage + (_AddedDamage * _Multiplier);
		    _Damage = if (_Damage > 1) then { 1 } else { _Damage };

		    //SystemChat format ["Old: %3 Added: %1 Final: Damage %2",(_AddedDamage * _Multiplier),_Damage,_OldDamage];
		    _Unit setVariable ["NEKY_OldDamage",_Damage];

		    _Damage
		}];
	};
};

sleep 5;
Private "_Array";
if(isNull _Vehicle) then {
	{ if(_X isKindOf "Helicopter") then {[_X,_ShouldDisableThermal,_shouldDisableNVG] spawn OKS_Helicopter_Code; if(_Debug_Variable) then { systemChat format["Helicopter Script added to %1",_X] }}} foreach vehicles;
} else {

	//if ([_Vehicle] call OKS_isWhiteList) exitWith {systemChat "isWhitelisted. Exiting.."; false};
	[_Vehicle,_ShouldDisableThermal,_shouldDisableNVG] spawn OKS_Helicopter_Code;
	
};


