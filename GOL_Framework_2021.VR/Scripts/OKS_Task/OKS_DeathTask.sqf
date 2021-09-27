
/*
 Setup in OKS_TaskSetup.SQF

 execvM "Scripts\OKS_Task\OKS_DeathTask.sqf";
*/

if(HasInterface && !isServer) exitWith {};

Private _DeathArray = 0;
Private _MainTask = "OKS_DeathTask";
Private _Debug_Variable = true;

// Check and define variable
_Var = "OKS_PlayerDeaths";
if !(isNil {MissionNameSpace getVariable _Var}) exitWith {SystemChat "OKS_PlayDeaths already defined"}; // Exit if side already defined
MissionNameSpace setVariable [_Var,0];

[true, _MainTask, ["Keep your casualties to a minimum.", "Avoid Friendly Casualties", ""], ObjNull, "Succeeded", 1, false, "Defend"] call BIS_FNC_TaskCreate;
Private _SubTasks = [];
UISleep 0.1;

For "_i" from 0 to 10 step 1 do
{
	_Index = _i;
	_TempName = Format ["%1_%2",_MainTask,_i];
	_TempCount = (_i * 2);
	_NewDescription = [Format ["No more than %1 T4 casualties on your side.",_TempCount], Format ["%1 or less T4s",_TempCount], ""];
	[true, [_TempName, _MainTask], _NewDescription, ObjNull, "Succeeded", 1, false, "Defend"] call BIS_FNC_TaskCreate;
	_SubTasks pushBack [_TempName,_TempCount];
	UISleep 0.1;
};

// Mission Eventhandler
addMissionEventHandler ["EntityKilled",
{
	if !(isServer) exitWith {};
	Params ["_Killed","_Killer"];
	if (isPlayer _Killed) then {
		_NewValue = ((MissionNameSpace getVariable _Var) + 1);
		MissionNameSpace setVariable [_Var,_NewValue];
		{ if (_NewValue >= (_X select 1)) then { [_X select 0,"FAILED"] call BIS_fnc_taskSetState; _SubTasks deleteAt (_SubTasks find _X); } } foreach _SubTasks;
		if(Count _SubTasks == 0) exitWith {[_MainTask,"FAILED"] call BIS_fnc_taskSetState};	// Task has already depleted subtasks.
	};
}];

