// Example
// [getpos jetspawn_1,jetstrike_1,getpos jetexit_1,selectRandom ["UK3CB_AAF_B_L39_AA","UK3CB_AAF_B_C130J_CARGO","UK3CB_AAF_B_Gripen"],west,250] spawn OKS_AirStrike;    
// [getpos jetspawn_1,jetstrike_1,getpos jetexit_1,selectRandom ["UK3CB_AAF_B_L39_AA","UK3CB_AAF_B_C130J_CARGO","UK3CB_AAF_B_Gripen"],west,250] execVM "Scripts\OKS_Spawn\OKS_AirStrike.sqf";

Params ["_SpawnPos","_StrikePos","_EndPos","_Classname","_Side","_Height"];
_Direction = getDir _StrikePos;
_StrikePos = _StrikePos getPos [350,(getDir _StrikePos - 180)];

_SpawnPos = [_SpawnPos#0,_SpawnPos#1,_Height];
_aircraft = CreateVehicle [_Classname,_SpawnPos, [], -1, "FLY"];
_aircraft setPosATL _SpawnPos;
_aircraft setDir (_aircraft getDir _StrikePos);
_aircraft setVelocityModelSpace [0, 500, 0];
_crew = [_aircraft,_Side] call OKS_AddVehicleCrew;
_aircraft flyInHeight _Height;

{ _X disableAI "AUTOCOMBAT"; _X disableAI "TARGET"; _X disableAI "AUTOTARGET"; _X disableAI "LIGHTS"} foreach units _crew;
_crew setBehaviour "CARELESS";
_crew setCombatMode "BLUE";

_MoveWP = _crew addWaypoint [_StrikePos,0];
_MoveWP setWaypointType "MOVE";

_ExitWP = _crew addWaypoint [_EndPos,0];
_ExitWP setWaypointType "MOVE";
_ExitWP setWaypointCompletionRadius 1000;
_ExitWP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _X} foreach thisList"];

waitUntil {sleep 0.2; _aircraft distance2d _strikePos < 500};
sleep 1;
systemChat "Bombs away.";
_bomb = createVehicle ["BombCluster_01_Ammo_F", [_StrikePos select 0,_StrikePos select 1,60], [], 0, "NONE"];
_bomb setDir _Direction;
_bomb setVelocityModelSpace [0, 50, -150];