//	["Variable"] Spawn NEKY_Tasks_AvoidCasualties_Killed;
//
//	1) "Variable". 										String
//		a) The variable name for the side.
//		b) Automatically named "NEKY_Tasks_AvoidCasualties_" followed by Side name. EAST, CIV, WEST, GUER.
//
//	This handles updating the task as units are killed.
//
//	Made by NeKo-ArroW

if !(isServer) exitWith {};

Private ["_SelectTask"];
Params ["_Var"];

_Kills = ((MissionNameSpace getVariable _Var) +1); // +1 to count add this kill
MissionNameSpace setVariable [_Var, _Kills];
_SettingsVar = (Format ["%1_Settings",_Var]);
_Settings = MissionNameSpace getVariable _SettingsVar;
_Settings Params ["_TaskName","_SubTasks","_Code"];
if (Count _SubTasks == 0) exitWith {};	// Task has already depleted subtasks.

if (_Kills == 1) then
{
	_SelectTask = ((_SubTasks Select 0) select 0);
	(_Settings select 1) deleteAt 0;
	MissionNameSpace setVariable [_SettingsVar,_Settings];
} else {
	_SubTaskVal = _SubTasks select 0 select 1;
	if !(_Kills > _SubTaskVal) ExitWith {};
	_SelectTask = ((_SubTasks select 0) select 0);
	(_Settings select 1) deleteAt 0;
	MissionNameSpace setVariable [_SettingsVar,_Settings];
};
if (isNil "_SelectTask") exitWith {}; // Exit if no subtask selected
_Count = Count _SubTasks;
Sleep 10;

[_SelectTask, "Failed", false] call NEKY_Tasks_SetTaskState;
[5 - _Count] Call _Code;

// Fail main task if all subtasks have failed
if (Count _SubTasks == 0) then
{
	Sleep 1;
	[_TaskName, "Failed", false] call NEKY_Tasks_SetTaskState;
};