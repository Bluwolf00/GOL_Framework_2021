/// [this] execVM "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";

if(!isServer) exitWith {};

Params ["_Vehicle"];

_Vehicle disableTIEquipment true;
_Vehicle addItemCargo ["Toolkit",2];
[_Vehicle, 30] call ace_cargo_fnc_setSpace;
sleep 5;

_Crate = "Box_NATO_Support_F" createVehicle [0,0,0];
ClearMagazineCargo _Crate;
ClearWeaponCargo _Crate;
ClearItemCargo _Crate;

[_Crate,25,true] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
_Crate setVariable ["ace_rearm_isSupplyVehicle", true];
[_Crate,_Vehicle,true] call ace_cargo_fnc_loadItem;

if(_Vehicle isKindOf "Tank") exitWith {
	//systemChat "Is tank, giving tracks";
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Track", _Vehicle,true] call ace_cargo_fnc_loadItem;
	_Vehicle addweaponTurret ["rhs_weap_smokegen",[-1]];
	_Vehicle AddMagazineTurret ["rhs_mag_smokegen",[-1]];
};

if(_Vehicle isKindOf "Car") exitWith {
	//systemChat "Is Car, giving Wheels";
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
	["ACE_Wheel", _Vehicle,true] call ace_cargo_fnc_loadItem;
};

sleep 30;

if (["FV432_Mk3_GPMG",typeOf _Vehicle] call BIS_fnc_inString || ["Panther_GPMG_Green_A",typeOf _Vehicle] call BIS_fnc_inString || ["WMIK_GPMG",typeOf _Vehicle] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargo ["UK3CB_BAF_762_200Rnd_T",10];
};

if (["Passenger_HMG",typeOf _Vehicle] call BIS_fnc_inString || ["L111A1",typeOf _Vehicle] call BIS_fnc_inString || ["FV432_Mk3_RWS",typeOf _Vehicle] call BIS_fnc_inString || ["LandRover_WMIK_HMG",typeOf _Vehicle] call BIS_fnc_inString ) then {
	_Vehicle AddMagazineCargo ["UK3CB_BAF_127_100Rnd",10];
};

if(["L134A1",typeOf _Vehicle] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargo ["UK3CB_BAF_32Rnd_40mm_G_Box",10];
};

if(["WMIK_Milan",typeOf _Vehicle] call BIS_fnc_inString) then {
	_Vehicle AddMagazineCargo ["UK3CB_BAF_1Rnd_Milan",10];
};

if(["WMIK",typeOf _Vehicle] call BIS_fnc_inString || ["Coyote",typeOf _Vehicle] call BIS_fnc_inString || ["Jackal2",typeOf _Vehicle] call BIS_fnc_inString  ) then {
	_Vehicle AddMagazineCargo ["UK3CB_BAF_762_100Rnd_T",10];
};

/*
this addItemToVest "UK3CB_BAF_762_100Rnd_T";
this addItemToVest "UK3CB_BAF_1Rnd_Milan";
this addItemToBackpack "UK3CB_BAF_127_100Rnd";
this addItemToBackpack "UK3CB_BAF_32Rnd_40mm_G_Box";