// Example
// [Plane_1,PlaneExit_1,selectRandom ["UK3CB_AAF_B_L39_AA","UK3CB_AAF_B_C130J_CARGO","UK3CB_AAF_B_Gripen"],west,true,"MOVE"] spawn OKS_AirSpawn;    
// [Plane_1,PlaneExit_1,selectRandom ["UK3CB_AAF_B_L39_AA","UK3CB_AAF_B_C130J_CARGO","UK3CB_AAF_B_Gripen"],west,true,"MOVE"] execVM "Scripts\OKS_Spawn\OKS_AirSpawn.sqf";

Params ["_SpawnPos","_MoveToPos","_Classname","_Side","_ShouldBeCareless","_WaypointType","_Height"];

_SpawnPos = [_SpawnPos#0,_SpawnPos#1,_Height];
_aircraft = CreateVehicle [_Classname,_SpawnPos, [], -1, "FLY"];
_aircraft setPosATL _SpawnPos;
_aircraft setDir (_aircraft getDir _MoveToPos);
_aircraft setVelocityModelSpace [0, 20, 0];
_crew = [_aircraft,_Side] call OKS_AddVehicleCrew;
_aircraft flyInHeight _Height;

if(_ShouldBeCareless) then {
    _crew setBehaviour "CARELESS";
    _crew setCombatMode "BLUE";
} else {
    _crew setBehaviour "STEALTH";
    _crew setCombatMode "BLUE";
};

_MoveWP = _crew addWaypoint [_MoveToPos,0];
_MoveWP setWaypointType _WaypointType;

if(waypointType _MoveWP != "SAD") then {
    _MoveWP setWaypointCompletionRadius 1000;
    _MoveWP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _X} foreach thisList"];
};