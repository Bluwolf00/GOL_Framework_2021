// [attackheli_1,attacktarget_1,west,500] spawn OKS_Helicopter_Attack;	
// [attackheli_1,attacktarget_1,west,500] execVM "Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf";
/*
	Params:
	1 - Object - Spawn Position
	2 - Object - Attack Position
	3 - Side
	4 - Classname
	5 - Range of Reveal command (All Enemies within X meters of target)

*/

if(!isServer) exitWith {};

Params [
	["_Spawn",objNull,[objNull]],
	["_Waypoint",objNull,[objNull]],
	["_Side",east,[sideUnknown]],
	["_Classname","",[""]],
	["_Range",500,[0]]
];

	_Vehicle = CreateVehicle [_Classname,[getPos _Spawn#0, getPos _Spawn#1, 150], [], 0, "FLY"];
	_Vehicle setDir (getDir _Spawn);
	_Vehicle flyInHeight 125;
	_Vehicle setVehicleLock "LOCKED";

	_Group = [_Vehicle,west,0] call OKS_AddVehicleCrew;

    _Group setBehaviour "COMBAT";
	_Group setCombatMode "RED";
    _WP = _Group addWaypoint [getPos _Waypoint,0];
    _WP setWaypointType "SAD";

	_EnemyUnitsNearby = (_Waypoint nearEntities ["Man", _Range]) select {!isPlayer _X && Side _X != _Side};
	{_Group reveal [_X,4]} foreach _EnemyUnitsNearby;


