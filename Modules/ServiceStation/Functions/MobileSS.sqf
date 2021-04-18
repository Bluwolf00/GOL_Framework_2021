//	null = [This, Radius, (is a Mobile Service Station), ["NearestObjects"]] execVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
///////////////////////////////////////////
//
//	1. Object or Vehicle name, the name of the Object or Vehicle that will be the Mobile Service Station.
//		a. Can be the actual name of the Object or Vehicle. Generally used when activating Service Stations later in to the mission.
// 		b. This, when entered in the init line of an object or Vehicle, adds an action to activate the Mobile Service Station.
//	2. OPTIONAL: Radius, range of service station.
//		a. Any number (meters) from center of object or vehicle chosen above.
//		b. Nil, will make it default to what is defined in NEKY_Settings.
//	3. OPTIONAL: If it is a Mobile Service Station. True/False.
//		a. Defaults to True, Always use True. If you want to use a stationary Service Station use the main script NEKY_ServiceStation.sqf.
//		b. False, when using NEKY_ServiceStation.sqf.
//	4. OPTIONAL: Objects to scan for, an array of strings that will scan for types of vehicles ( https://community.bistudio.com/wiki/nearestObjects ).
//		a. This decides what "TYPES" of vehicles the Service Station will look for/work with. ["CAR","AIR","PLANE","HELICOPTER","TANK"] are some examples.
//		b. Defaults to all land vehicles and all aerial vehicles.
//
//////////////
//	How To
//////////////
//
//	1.
//	2. Place an object or vehicle that you want to be the Mobile Service Station (Vehicle Ammo Crate for slingloading or any truck for a vehicle).
//	3. Modify the code to your liking.
//	4. Place the code in the init line of the object or vehicle you want to be the Mobile Service Station.
//
//	Note: If you want to make a stationary Service Station look in to NEKY_ServiceStation.sqf.
//
///////////////
//	Examples:
///////////////
//	null = [This, nil, True, ["LandVehicle","AIR"]] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
//	null = [RepairTruck, 15, True, ["LandVehicle"]] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
//	null = [This, nil] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
//	null = [This] ExecVM "Scripts\NEKY_ServiceStation\MobileSS.sqf";
///////////////
///////////////
//	Made by NeKo-ArroW with help from GuzzenVonLidl
//	Thanks to Raptor for helping me out testing this on dedicated server
//	Version 2.0
///////////////

#include "..\Settings.sqf"
Private ["_MRadius"];

Params
[
	["_Object", ObjNull, [ObjNull]],
	["_MRadius", _MRadius, [0]],
	["_IsMSS", true, [true]],
	["_Filter", ["LandVehicle","AIR","SHIP"], [[]]]
];

_Object addAction ["<t color='#00FF00'>Activate Service Station</t>",
{
	Params ["_Object"];
	_Params = _This select 3;
	_Params Params ["_MRadius","_IsMSS","_Filter"];

	Hint "Service Station Activated.";
	[[_Object,_MRadius,_IsMSS,_Filter],{_This call NEKY_ServiceStation_ServiceStation}] RemoteExec ["BIS_FNC_SPAWN",0];
	_Object setVariable ["NEKY_ServiceStation_MSS_Active",True,true];
},[_MRadius,_IsMSS,_Filter],4,false,true,"","((_Target distance _This) < 10) && !(_Target getVariable ['NEKY_ServiceStation_MSS_Active',false]) && Alive _Target"];

_Object addAction ["<t color='#FF0000'>Deactivate Service Station</t>",
{
	Params ["_Object"];

	Hint "Service Station Deactivated.";
	_Object setVariable ["NEKY_ServiceStation_MSS_Active",False,true];
	NEKY_ServiceStations deleteAt (NEKY_ServiceStations find _Object);
	PublicVariable "NEKY_ServiceStations";
},[],11,false,true,"","((_Target distance _This) < 10) && (_Target getVariable ['NEKY_ServiceStation_MSS_Active',false]) && Alive _Target"];
