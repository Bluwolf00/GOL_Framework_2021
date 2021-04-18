//	[] execVM "Scripts\OKS_AAC\Init.sqf";
//
//	This initializes all the functions for OKS AAC.
//
//	Made by Oksman

// Params
// 1. Vehicle object, name of object
// 2. Object classname, what object should be loaded

params ["_vehicle","_object"];

if(!isServer) exitWith {};

waitUntil {!isNil "ace_cargo_fnc_unloadItem";};
_object = createVehicle [_object,[0,0,0],[] ,0,"NONE"];
[_object, (_this select 0),true] call ace_cargo_fnc_loadItem;

};