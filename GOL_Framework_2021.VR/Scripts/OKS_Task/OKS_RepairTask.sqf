/*
	[vehicle,Group,ShouldBeCaptive,Side,1] execVM "Scripts\OKS_TASK\OKS_RepairTask.sqf";
*/
if(HasInterface && !isServer) exitWith {};

Params ["_Veh","_Friendlies","_ShouldBeCaptive","_Side","_TaskID"];
private ["_Temp","_AllHitPoints","_AllHitPointsName","_AllHitPointsValue","_HitPoints","_List","_DamagePoints","_Count","_Delay"];

Private _Debug_Variable = true;
//if(_Debug_Variable) then {systemChat format [" "]};

_Friendlies setVariable ["hc_blacklist", true];
{_X disableAI "PATH"; if(_ShouldBeCaptive) then {_X setCaptive true} } foreach units _Friendlies;

waitUntil {sleep 5; if(_Debug_Variable) then {[format ["Checking for Task_Settings"]] remoteExec ["systemChat",0]}; !(isNil "OKS_Task_Setting")};

{_X disableAI "PATH"; if(_ShouldBeCaptive) then {_X setCaptive true} } foreach units _Friendlies;
_Settings = [_Side] Call OKS_Task_Setting;
_Settings Params ["_Leaders","_Units","_ExfilMarker"];
Private _ExfilPos = getMarkerPos _ExfilMarker;

_Delay = 0;
_Count = [typeOf _Veh, true] call BIS_fnc_crewCount;
if (count units _Friendlies > _Count) exitWith { ["WARNING: REPAIR TASK FAILURE - Not enough seats for assigned friendlies"] remoteExec ["systemChat",0]};

_TurretArray = typeOf _Veh call BIS_fnc_vehicleCrewTurrets;
if((_TurretArray find 0) isEqualTo -1) then {

	_Unit = units _Friendlies call BIS_fnc_SelectRandom;
	_Unit moveInGUnner _Veh;
	if(_Debug_Variable) then { [format ["Checking Gunner %2 - Moving %1",_Unit,_Veh]] remoteExec ["systemChat",0]};

};
_Task = format["OKS_REPAIRTASK_%1",_TaskID];
{_X disableAI "path"; _X setUnitPos "Middle"; _X setBehaviour "COMBAT";} foreach units _Friendlies;

if(_Debug_Variable) then {["Disable AI and CreateTask"] remoteExec ["systemChat",0]};

[true, [_Task], ["A friendly element has reported damages to their vehicle and are unable to exfil out of the area of operations. Secure the site and repair the vehicle, make sure the friendlies survive. Task will be achieved when friendly element reaches their exfil point.", "Assist Friendly Element", "Friendly Element"], _Veh,"CREATED",-1, false,"repair", false] call BIS_fnc_taskCreate;

_Temp = getAllHitPointsDamage _Veh;
_AllHitPointsName = _Temp select 1;
_Hit = [];

{ if (["wheel", _x] call BIS_fnc_inString || ["pas_", _x] call BIS_fnc_inString || ["track", _x] call BIS_fnc_inString) then {_Hit pushBackUnique _X}} foreach _AllHitPointsName;

_HitPart = _Hit call BIS_fnc_selectRandom;
_Veh setHit [_HitPart,1];
///_Veh setHit ["motor",1];
_Veh setFuel 0;

if(_Debug_Variable) then {[format ["Damage Done %1",_Veh]] remoteExec ["systemChat",0]};

waitUntil {sleep 10; if(_Debug_Variable) then {[format ["Vehicle Dead: %1 - HitPart Fixed: %2 - Friendlies Dead: %3",!alive _Veh,_Veh getHit _HitPart <= 0.2,{Alive _X} count units _Friendlies isEqualTo 0]] remoteExec ["systemChat",0]}; !alive _Veh || _Veh getHit _HitPart <= 0.2 || {Alive _X} count units _Friendlies isEqualTo 0};

	//_Task = [_TaskID, player] call BIS_fnc_taskReal;
	//systemChat str _Task;

if((!alive _Veh || {Alive _X} count units _Friendlies isEqualTo 0) && _TaskBoolean) exitWith { [_Task,"Failed"] call BIS_fnc_taskSetState; };
_Friendlies addVehicle _Veh;

if(_Debug_Variable) then {[format ["Ordering AI to Embark."]] remoteExec ["systemChat",0]};

{_X forceSpeed 5; _X enableAttack false; if(Leader group _X isEqualTo _X) then {_X assignAsDriver _Veh}; _X assignAsCargo _Veh; [_X] orderGetIn true; _X enableAI "path"; _X setUnitPos "UP"; _X disableAI "TARGET"; _X disableAI "AUTOTARGET"; _X disableAI "SUPPRESSION"; _X disableAI "COVER"; _X disableAI "AUTOCOMBAT"; _X setBehaviour "AWARE"; } foreach units _Friendlies;

_Veh setUnloadInCombat [false, false];
_GetInWP = _Friendlies addWaypoint [getPos _Veh, 0];
_GetInWP setWaypointType "GETIN";
[_Friendlies,0] waypointAttachVehicle _Veh;
_GetInWP setWaypointBehaviour "AWARE";
_GetInWP setWaypointForceBehaviour true;

waitUntil { sleep 4; _Delay = _Delay + 1; _Delay == 5 || {_X in _Veh} count units _Friendlies >= count units _Friendlies || {Alive _X} count units _Friendlies isEqualTo 0 || !Alive _Veh || !CanMove _Veh};
{ if (!(_X in _Veh) && Alive _X) then {_X moveInAny _Veh}} count units _Friendlies;
[(Leader _Friendlies),_Veh] remoteExec ["moveInDriver",0];

if(_Debug_Variable) then {[format ["Ordering AI to exfil."]] remoteExec ["systemChat",0]};
sleep 0.5;
[_Veh,10] remoteExec ["ForceSpeed",0];
[_Veh,1] remoteExec ["setFuel",0];

sleep 3;
_ExfilWP = _Friendlies addWaypoint [_ExfilPos, 1];
_ExfilWP setWaypointType "MOVE";
_ExfilWP setWaypointBehaviour "CARELESS";
_ExfilWP setWaypointForceBehaviour true;

sleep 10;
deleteWaypoint [_Friendlies, 0]; deleteWaypoint [_Friendlies, 1];
_ExfilWP = _Friendlies addWaypoint [_ExfilPos, 0];
_ExfilWP setWaypointType "MOVE";
_ExfilWP setWaypointBehaviour "CARELESS";
_ExfilWP setWaypointForceBehaviour true;


waitUntil {sleep 10; _Veh distance _ExfilPos < 50 || !Alive _Veh || !CanMove _Veh};
if(!Alive _Veh || !CanMove _Veh || {Alive _X} count units _Friendlies isEqualTo 0) exitWith { [_Task,"Failed"] call BIS_fnc_taskSetState; };
{deleteVehicle vehicle _X; deleteVehicle _X} foreach units _Friendlies;
if(_Debug_Variable) then { ["Task Successful."] remoteExec ["systemChat",0]};
[_Task,"Succeeded"] call BIS_fnc_taskSetState;