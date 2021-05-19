/// [this] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";

if(!isServer) exitWith {};

Params ["_Vehicle"];

_Vehicle disableTIEquipment true;
_Vehicle addweaponTurret ["rhs_weap_smokegen",[-1]];
_Vehicle AddMagazineTurret ["rhs_mag_smokegen",[-1]];
_Vehicle addItemCargo ["Toolkit",2];
[_Vehicle, 30] call ace_cargo_fnc_setSpace;
sleep 5;

_Crate = "Box_T_NATO_WpsSpecial_F" createVehicle [0,0,0];
ClearMagazineCargo _Crate;
ClearWeaponCargo _Crate;
ClearItemCargo _Crate;

[_Crate,25,true] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
_Crate setVariable ["ace_rearm_isSupplyVehicle", true];
[_Crate,_Vehicle,true] call ace_cargo_fnc_loadItem;

if(_Vehicle isKindOf "Tank") exitWith {
	systemChat "Is tank, giving tracks";
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
};

if(_Vehicle isKindOf "Car") exitWith {
	systemChat "Is Car, giving Wheels";
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
};
