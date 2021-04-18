Params ["_Veh","_Friendlies","_ExfilPos","_Side","_TaskID"];
private ["_Temp","_AllHitPoints","_AllHitPointsName","_AllHitPointsValue","_HitPoints","_List","_DamagePoints","_Count","_Delay"];

if(!isServer) exitWith {};
_Delay = 0;
_Count = [typeOf _Veh, true] call BIS_fnc_crewCount;
if (count units _Friendlies > _Count) then { systemChat "WARNING: REPAIR TASK FAILURE - Not enough seats for assigned friendlies"};

_TurretArray = typeOf _Veh call BIS_fnc_vehicleCrewTurrets;
if((_TurretArray find 0) isEqualTo -1) then {

	_Unit = units _Friendlies call BIS_fnc_SelectRandom;
	_Unit moveInGUnner _Veh;

};

{_X disableAI "path"; _X setUnitPos "Middle"; _X setBehaviour "COMBAT"; _X setSkill 0.1; } foreach units _Friendlies;

[_Side, [_TaskID], ["A friendly element has reported damages to their vehicle and are unable to exfil out of the area of operations. Secure the site and repair the vehicle, make sure the friendlies survive. Task will be achieved when friendly element reaches their exfil point.", "Assist Friendly Element", "Friendly Element"], _Veh,"CREATED",-1, false,"repair", false] remoteExec ["BIS_fnc_taskCreate"];

// [vehicle,groupName,exfilPos,AddTaskBoolean,Side,"Task_ID_1"] execVM "Scripts\OKS_TASK\OKS_RepairTask.sqf";

_Temp = getAllHitPointsDamage _Veh;
_AllHitPointsName = _Temp select 1;
_Hit = [];

{ if (["wheel", _x] call BIS_fnc_inString || ["pas_", _x] call BIS_fnc_inString || ["track", _x] call BIS_fnc_inString) then {_Hit pushBackUnique _X}} foreach _AllHitPointsName;

_HitPart = _Hit call BIS_fnc_selectRandom;
_Veh setHit [_HitPart,1];
///_Veh setHit ["motor",1];
_Veh setFuel 0;

waitUntil {sleep 10; !alive _Veh || _Veh getHit _HitPart <= 0.2 || {Alive _X} count units _Friendlies isEqualTo 0};

	//_Task = [_TaskID, player] call BIS_fnc_taskReal;
	//systemChat str _Task;

if((!alive _Veh || {Alive _X} count units _Friendlies isEqualTo 0) && _TaskBoolean) exitWith { [_TaskID,"Failed"] call BIS_fnc_taskSetState; };
_Friendlies addVehicle _Veh;

{_X forceSpeed 5; _X enableAttack false; [_X] orderGetIn true; _X enableAI "path"; _X setUnitPos "UP"; _X disableAI "TARGET"; _X disableAI "AUTOTARGET"; _X disableAI "SUPPRESSION"; _X disableAI "COVER";} foreach units _Friendlies;
_Veh setUnloadInCombat [false, false];
_GetInWP = _Friendlies addWaypoint [getPos _Veh, 0];
_GetInWP setWaypointType "GETIN";
[_Friendlies,0] waypointAttachVehicle _Veh;
_GetInWP setWaypointBehaviour "AWARE";
_GetInWP setWaypointForceBehaviour true;

waitUntil { sleep 10; _Delay = _Delay + 1; _Delay == 5 || {_X in _Veh} count units _Friendlies >= count units _Friendlies || {Alive _X} count units _Friendlies isEqualTo 0 || !Alive _Veh || !CanMove _Veh};
{ if (!(_X in _Veh) && Alive _X) then {_X moveInCargo _Veh}} count units _Friendlies;

_Veh ForceSpeed -1; {_X forceSpeed -1} foreach units _Friendlies;
_Veh setFuel 1;
_ExfilWP = _Friendlies addWaypoint [_ExfilPos, 1];
_ExfilWP setWaypointType "MOVE";
_ExfilWP setWaypointBehaviour "CARELESS";
_ExfilWP setWaypointForceBehaviour true;
_Veh commandMove (_ExfilPos);

sleep 30;

_ExfilWP = _Friendlies addWaypoint [_ExfilPos, 1];
_ExfilWP setWaypointType "MOVE";
_ExfilWP setWaypointBehaviour "CARELESS";
_ExfilWP setWaypointForceBehaviour true;
_Veh commandMove (_ExfilPos);


waitUntil {sleep 10; _Veh distance _ExfilPos < 50 || !Alive _Veh || !CanMove _Veh};
if(!Alive _Veh || !CanMove _Veh || {Alive _X} count units _Friendlies isEqualTo 0) exitWith { [_TaskID,"Failed"] call BIS_fnc_taskSetState; };
{deleteVehicle vehicle _X; deleteVehicle _X} foreach units _Friendlies;
[_TaskID,"Succeeded"] call BIS_fnc_taskSetState;