//	[["TaskName", ["Description","Title"], SIDE, {CODE}], Notification] spawn NEKY_Tasks_AvoidCasualties;
//
//	1. Parameters
//		1) "Task Name". 											""
//		2) Task Description.										["",""]
//		  a) "Description". 	 									""
//		  b) "Title". 		 										""
//		3) Side of casualties										Side
//		  a) WEST/BLUFOR EAST/OPFOR INDEPENDENT CIVILIAN
//		4) {CODE}													{}
//		  a) Code to be executed upon task and subtask failure.
//		  b) Values passed through are [Task that failed]
//	2. Notification, whether the task will create a notification top center of screen.						Boolean
//
//	This creates a task for "Avoiding Civilian Casualties" for all players.
//
//	Made by NeKo-ArroW
//	Version 1.1

Private ["_Index"];

Params ["_Params","_Notify"];
if (TypeName _Notify == "SCALAR") then { _Notify = True };

_Params Params
[
	["_TaskName", "NEKY_TASKS_AVOIDCASUALTIES", [""]],
	["_Description", ["Avoid causing civilian casualties.","Avoid Civilian Casualties", ""], [[]]],
	["_Side", CIVILIAN, [SideUnknown]],
	["_Code", {}, [{}]]
];

if !(isNil {MissionNameSpace getVariable _Var}) exitWith {SystemChat "ERROR: NEKY_Tasks_AvoidCasualties. Side already defined"}; // Exit if side already defined

// Check and define variable
_Var = Format ["NEKY_Tasks_AvoidCasualties_%1",_Side];

MissionNameSpace setVariable [_Var,0];

[true, _TaskName, _Description, ObjNull, "Succeeded", 1, _Notify, "Defend"] call BIS_FNC_TaskCreate;
_SubTasks = [];
UISleep 0.1;

For "_i" from 0 to 7 step 1 do
{
	_Index = _i;
	_TempName = Format ["%1_%2",_TaskName,_i];
	_TempCount = (_i * 2);
	_NewDescription = [Format ["No more than %1 casualties caused by your side.",_TempCount], Format ["Civilian: %1 or less",_TempCount,_Side], ""];
	[true, [_TempName, _TaskName], _NewDescription, ObjNull, "Succeeded", 1, false, "Defend"] call BIS_FNC_TaskCreate;
	_SubTasks pushBack [_TempName,_TempCount];
	UISleep 0.1;
};

// Define Variable Settings
_Var = Format ["%1_Settings",_Var];
MissionNameSpace setVariable [_Var,[_TaskName,_SubTasks,_Code]];

// Mission Eventhandler
addMissionEventHandler ["EntityKilled",
{
	if !(isServer) exitWith {};
	Params ["_Killed","_Killer"];

	_Side = (Side (Group _Killed));
	_Var = Format ["NEKY_Tasks_AvoidCasualties_%1",_Side];
	if (isNil {MissionNameSpace getVariable _Var}) exitWith {}; // Exit if side not defined by Tasks

	if (isPlayer _Killed) exitWith {}; // Exit if player
	if (!(isPlayer _Killer) or (typeOf _Killer == "headlessClient_F")) exitWith {}; // Exit if AI or HC is killer

	[_Var] Spawn NEKY_Tasks_AvoidCasualties_Killed;
}];



