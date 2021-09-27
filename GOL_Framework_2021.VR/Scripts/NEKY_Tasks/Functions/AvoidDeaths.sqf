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
	["_TaskName", "NEKY_TASKS_AVOIDDEATHS", [""]],
	["_Description", ["Avoid causing civilian casualties.","Avoid Civilian Casualties", ""], [[]]],
	["_Side", CIVILIAN, [SideUnknown]],
	["_Code", {}, [{}]]
];

if !(isNil {MissionNameSpace getVariable _Var}) exitWith {SystemChat "ERROR: NEKY_Tasks_AvoidDeaths already defined"}; // Exit if side already defined

// Check and define variable
_Var = "NEKY_Tasks_AvoidDeaths";

MissionNameSpace setVariable [_Var,0];

[true, _TaskName, _Description, ObjNull, "Succeeded", 1, _Notify, "Defend"] call BIS_FNC_TaskCreate;
_SubTasks = [];
UISleep 0.1;

For "_i" from 0 to 10 step 1 do
{
	_Index = _i;
	_TempName = Format ["%1_%2",_TaskName,_i];
	_TempCount = (_i * 2);
	_NewDescription = [Format ["No more than %1 casualties on your side.",_TempCount], Format ["%1 or less deaths",_TempCount], ""];
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

	_Var = "NEKY_Tasks_AvoidDeaths";
	if (isNil {MissionNameSpace getVariable _Var}) exitWith {}; // Exit if not defined by Tasks

	if (!isPlayer _Killed) exitWith {}; // Exit if not player
	[_Var] Spawn NEKY_Tasks_AvoidDeaths_Killed;
}];



