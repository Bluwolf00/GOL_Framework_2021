// Example
// [Plane_1,PlaneExit_1,selectRandom ["UK3CB_AAF_B_L39_AA","UK3CB_AAF_B_C130J_CARGO","UK3CB_AAF_B_Gripen"],west,true,"MOVE"] execVM "Scripts\OKS_Ambience\OKS_AirSpawn.sqf";

Params ["_SpawnPos","_MoveToPos","_Classname","_Side","_ShouldBeCareless","_WaypointType"];

if(_SpawnPos select 2 < 500) then {
    _SpawnPos = [_SpawnPos#0,_SpawnPos#1,700];
};

_aircraft = CreateVehicle [_Classname,_SpawnPos, [], -1, "FLY"];
_aircraft setPosATL _SpawnPos;
_aircraft setDir (_aircraft getDir _MoveToPos);
_aircraft setVelocityModelSpace [0, 200, 0];
_crew = [_aircraft,_Side] call OKS_AddVehicleCrew;
_aircraft flyInHeight 600;
if(_ShouldBeCareless) then {
    _crew setBehaviour "STEALTH";
    _crew setCombatMode "BLUE";
};

_MoveWP = _crew addWaypoint [_MoveToPos,0];
_MoveWP setWaypointType _WaypointType;

if(waypointType _MoveWP != "SAD") then {
    _MoveWP setWaypointCompletionRadius 1000;
    _MoveWP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _X} foreach thisList"];
};