/*

["_SpawnPosition","_VehicleType","_Speed","_EndPosition"] spawn OKS_Civilian_Vehicle;
    [getPos civilian_1,
        selectRandom ["UK3CB_ADC_C_Skoda", "UK3CB_ADC_C_Sedan", "UK3CB_ADC_C_Lada", 
            "UK3CB_ADC_C_Datsun_Civ_Open", "UK3CB_ADC_C_Datsun_Civ_Closed", 
            "UK3CB_ADC_C_Hatchback"],10,getPos Civilian_2] execVM "Scripts\OKS_Spawn\OKS_Civilian_Vehicle.sqf";

*/



if(!isServer) exitWith {};

Params ["_SpawnPosition","_VehicleType","_Speed","_EndPosition"];

_vehicle = createVehicle [_VehicleType, _SpawnPosition, [], 0, "CAN_COLLIDE"];
_civilianGroup = createGroup civilian;
_driver = _civilianGroup createUnit ["UK3CB_ADC_C_CIV_CHR_01", [0,0,0], [], 0, "NONE"];
_driver moveInDriver _vehicle;

_waypoint = _civilianGroup addWaypoint [_EndPosition,0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointBehaviour "CARELESS";

_vehicle forceSpeed _Speed;

waitUntil {sleep 5; _vehicle distance _EndPosition < 20};
deleteVehicle _driver;
deleteVehicle _vehicle;
