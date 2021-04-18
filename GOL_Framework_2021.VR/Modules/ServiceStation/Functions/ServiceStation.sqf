//	null = [This, Radius, (is a Mobile Service Station), ["NearestObjects"]] ExecVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf";
///////////////////////////////////////////
//
//	1. Object name, the name of the object.
//		a. Can be the actual name of the Object. Generally used when activating Service Stations later in to the mission.
// 		b. This, when entered in the init line of an object, activates the Service Station instantly.
//	2. OPTIONAL: Radius, range of service station.
//		a. Any number (meters) from center of object chosen above.
//		b. Nil, will make it default to what is defined in NEKY_Settings.
//	3. OPTIONAL: If it is a Mobile Service Station. True/False.
//		a. Defaults to false, Always use false. If you want to use a Mobile Service Station use the extension NEKY_MobileSS.sqf.
//		b. True, when this script is being executed via NEKY_MobileSS.sqf.
//	4. OPTIONAL: Objects to scan for, an array of strings that will scan for types of vehicles ( https://community.bistudio.com/wiki/nearestObjects ).
//		a. This decides what "TYPES" of vehicles the Service Station will look for/work with. ["CAR","AIR","PLANE","HELICOPTER","TANK"] are some examples.
//		b. Defaults to all land vehicles and all aerial vehicles.
//
//////////////
//	How To
//////////////
//
//	1. Place this file accompanied by NEKY_MobileSS.sqf and NEKY_Settings.sqf in: yourmissionfolder\Scripts\NEKY_ServiceStation\
//	2. Place an object or vehicle that you want to be the Mobile Service Station (Vehicle Ammo Crate for slingloading or any truck for a vehicle).
//	3. Modify the code to your liking.
//	4. Place the code in the init line of the object or vehicle you want to be the Mobile Service Station.
//
//	Note: If you want to make a stationary Service Station look in to NEKY_ServiceStation.sqf.
//
///////////////
//	Examples:
///////////////
//	null = [This, nil, false, ["LandVehicle","AIR"]] ExecVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf";
//	null = [Helipad, 15, false, ["LandVehicle"]] ExecVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf";
//	null = [This, nil] ExecVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf";
//	null = [This] ExecVM "Scripts\NEKY_ServiceStation\ServiceStation.sqf";
///////////////
///////////////
//	Made by NeKo-ArroW with help from GuzzenVonLidl
//  Thanks to MacGregor and Parker for helping me out testing this on dedicated server
//	version 2.2
///////////////

Private ["_Variables","_FullService","_Radius","_InspectionSpeed","_RepairingSpeed","_RepairingTrackSpeed","_RepairingSpeedPlane","_Refueling","_RemoveWheelSpeed","_MountWheelSpeed","_RearmSpeed","_RearmSpeedPlane","_MRadius"];

if (isServer) then  // To avoid having all players loop the scanners
{
	#include "..\Settings.sqf"

	Params
	[
		["_SS", ObjNull, [ObjNull]],
		["_Radius", _Radius, [0]],
		["_IsMSS", false, [true]],
		["_Filter", ["LANDVEHICLE","AIR","SHIP"], [[]]]
	];

	if (isNil "NEKY_ServiceStationArray") then
	{
		_Variables = ["NEKY_ServiceStationArray","NEKY_ServiceStations"];
		{ call compile format ["if (isNil '%1') then {%1 = [];}", _x] } forEach _Variables;
	};
	sleep 1;

	_FullService = False;
	NEKY_ServiceStations PushBack _SS;
	[] Spawn {sleep 5; PublicVariable "NEKY_ServiceStations"};

	// MSS Deactivate if moved or destroyed
	if (_IsMSS) then
	{
		_This spawn
		{
			Params ["_SS"];

			While {True} do
			{
				if ( !(Speed _SS isEqualTo 0) or !(Alive _SS) or !(_SS in NEKY_ServiceStations) ) exitWith
				{
//					SystemChat "MSS Moving, died or deactivated.";
					[_SS,false] call NEKY_ServiceStation_Available;
					NEKY_ServiceStations deleteAt (NEKY_ServiceStations Find _SS);
					PublicVariable "NEKY_ServiceStations";
				};
				sleep 10;
			};
		};
	};

	[_SS,_Radius,_Filter] Spawn
	// Scanner
	{
		Params ["_SS","_Radius","_Filter"];

		While {_SS in NEKY_ServiceStations} do
		{
			_Vehicles = NearestObjects [(getPos _SS), _Filter, _Radius];
			{
				if (!(_x in NEKY_ServiceStationArray) && (Alive _x)) then
				{
					NEKY_ServiceStationArray pushBack _x;
					PublicVariable "NEKY_ServiceStationArray";
					if !(_x getVariable ["NEKY_ServiceStation_HasActions",false]) then
					{
						[[_x,_SS],{_This Spawn NEKY_ServiceStation_Actions}] remoteExec ["BIS_FNC_SPAWN",0,true];
						_x setVariable ["NEKY_ServiceStation_HasActions",true,true];
					};
					_x setVariable ["NEKY_ServiceStation_InStation",[true,_SS],true];
					[_x,_SS,_Radius] Spawn NEKY_ServiceStation_ExitLoop;
				};
			} forEach _Vehicles;
			Sleep 4;
		};
	};
};