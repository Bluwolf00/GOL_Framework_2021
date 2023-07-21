// Example
// [Plane_1,CargoDrop_1,PlaneExit_1,"UK3CB_AAF_B_C130J_CARGO"],west,true,"MOVE"] execVM "Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf";

Params ["_SpawnPos","_DropToPos","_MoveToPos","_Classname","_Side","_ShouldBeCareless","_WaypointType"];

if(_SpawnPos select 2 < 500) then {
    _SpawnPos = [_SpawnPos#0,_SpawnPos#1,900];
};

_aircraft = CreateVehicle [_Classname,_SpawnPos, [], -1, "FLY"];
_aircraft setPosATL _SpawnPos;
_aircraft setDir (_aircraft getDir _MoveToPos);
_aircraft setVelocityModelSpace [0, 150, 0];
_crew = [_aircraft,_Side] call OKS_AddVehicleCrew;
_crew setVariable ["acex_headless_blacklist",true,true];
_aircraft flyInHeight 700;
_aircraft setCaptive true;

if(_ShouldBeCareless) then {
    _crew setBehaviour "STEALTH";
    _crew setCombatMode "BLUE";
};
_DropWP = _crew addWaypoint [_DropToPos,0];
_DropWP setWaypointType _WaypointType;
_DropWP setWaypointCompletionRadius 1000;

_MoveWP = _crew addWaypoint [_MoveToPos,0];
_MoveWP setWaypointType _WaypointType;

if(waypointType _MoveWP != "SAD") then {
    _MoveWP setWaypointCompletionRadius 1000;
    _MoveWP setWaypointStatements ["true", "deleteVehicle (vehicle this); {deleteVehicle _X} foreach thisList"];
};

waitUntil {sleep 1; _aircraft distance2d (WaypointPosition _DropWP) < 500 || !Alive _aircraft};
deleteWaypoint _DropWP;
if(Alive _aircraft) then {
    _aircraft spawn {
        {   
            // Create box and Chute and make it fall
            _Box = CreateVehicle ["Box_NATO_AmmoVeh_F", [0,0,0], [], 0, "NONE"];
            _Box disableCollisionWith _this;
            _Box HideObjectGlobal True;
            _Chute = CreateVehicle ["B_Parachute_02_F", [0,0,0], [], 0, "NONE"];
            _Chute AllowDamage False;
            _Chute disableCollisionWith _this;
            _Chute disableCollisionWith _Box;
            _Box attachTo [_Chute,[0,0,0]];
            _Chute HideObjectGlobal True;
            _Temp = [_this, 50, (GetDir _this)] call BIS_fnc_relPos;
            _Temp = [_Temp select 0, _Temp select 1, ((_Temp select 2) - 10)];
            _Chute SetPosATL _Temp;
            _Chute SetDir (getDir _this);
            _PitchBank = _Chute call BIS_fnc_getPitchBank;
            [_Chute,25,(_PitchBank select 1)] call BIS_fnc_SetPitchBank;
            sleep 0.7;
            _Box HideObjectGlobal False;
            _Chute HideObjectGlobal False;
            _Chute setVelocity [((Velocity _this) select 0), ((Velocity _this) select 1),-5];
            [_Chute] spawn { For "_i" from 1 to 10 do { Params ["_Chute"]; _Chute setvelocity [Velocity _Chute select 0, Velocity _Chute select 1, -5]; sleep 0.5 } };
        } foreach [1,2,3];
    };
};

