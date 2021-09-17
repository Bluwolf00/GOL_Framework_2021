//	[side, "heli type classname" (default mid size heli of said side), ["spawn","_pos","despawn"], (Vulnerable, true or false), "Vehicle ClassName", [attach,to,adjustment], Vehicle Crew/cargo Side, % of cargo, [Waypoints], {CODE}] execVM "Scripts\NEKY_VehicleDrop\NEKY_VehicleDropTrigger.sqf";
//	
//	
//	
//	

Params 
[
	"_side",
	"_HeliClass",
	"_STDs",
	"_Vulnerable",
	"_VehicleClass",
	["_Adjustment", [0], [[]]],
	["_VehicleSide", SideUnknown, [SideUnknown]],
	["_FillCargo", 0, [0]],
	["_Waypoints", [], [[]]],
	["_Code", {}, [{}]]
];

NEKY_VehicleDrop_Array = [];
NEKY_VehicleDrop_Ready = False;
[Player, systemChat 'Pilot: Where do you want the package?'] onMapSingleClick {NEKY_VehicleDrop_Array pushBack _Pos; NEKY_VehicleDrop_Ready = True};
WaitUntil {sleep 0.25; NEKY_VehicleDrop_Ready or !VisibleMap};

player onMapSingleClick "";

if (Count NEKY_VehicleDrop_Array == 0) exitWith 
{
	SystemChat "Pilot: Not enough coordinates recieved. Come back to me when you know what you want.";
	False;
};

[_Side,_HeliClass,[(_STDs select 0), (NEKY_VehicleDrop_Array select 0), (_STDs select 2)], _Vulnerable,_VehicleClass,_Adjustment,_VehicleSide,_FillCargo,_Waypoints,_Code] execVM "Scripts\NEKY_VehicleDrop\NEKY_MapClick.sqf";