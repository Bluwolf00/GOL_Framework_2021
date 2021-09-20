//	[Task Type, [Parameters]] Spawn NEKY_Tasks_Run;
//
//
//////////////////////
//	General Advice  //
//////////////////////
//
//	Never use the same "Task ID" or "Task Name" more than once per mission.
//	If a parameter says "Unique" never use it for anything else.
//	All these tasks needs to be run via the server.
//	If you want to create the tasks for the briefing screen, place the codes in "Scripts\NEKY_Tasks\Init.sqf".
//	To user a Default value enter: Nil   instead of a parameter value.
//
//
//
//
////////////////////////
//	Avoid Casualties  //
////////////////////////
//
//	1. Task Type: Type: 1.
//	2. [Parameters], these are the parameters you can tweak for the Avoid Casualties task.
//		1) "Task Name". A unique Task Name (invisible).														""
//		2) [Task Description].																				["",""]
//			a) "Description". Description of the task.	 													""
//			b) "Title". The visible title of your task.		 												""
//		3) Side of casualties																				Side
//			a) WEST BLUFOR   EAST OPFOR   INDEPENDENT   CIVILIAN
//		4) {CODE}																							{}
//			a) Code to be executed upon task and subtask failure.
//			b) Values passed through are [SubTask that failed]. First subtask is 1, final is 5.
//			c) Code is called by the server.
//	3. Notification, whether the task will create a notification top center of screen.						Boolean
//		a) if you want a notification, type True.
//		b) if you don't want a notification, type False.
//		c) Defaults to True.
//
//	Examples:
//	[1, ["NeKy_Task1", ["Avoid causing any civilian casualties.", "Avoid Casualties"], CIVILIAN]] Spawn NEKY_Tasks_Run;
//	[1, ["Somename", ["Avoid causing any AAF casualties", "Avoid Casualties"], INDEPENDENT]] Spawn NEKY_Tasks_Run;
//	[1, ["Derpy_Task", ["Don't kill them civvies", "Avoid Killing Civilians"], CIVILIAN, {Params ["_SubTask"]; if (_SubTask == 2) then {SystemChat "Subtask 2 failed! You have killed 2 or more civilians!"}}]] Spawn NEKY_Tasks_Run;
//
//	Notes:
//	This task will only count for PLAYER kills. Suicide or AI kills are ignored.
//	There is up to a 10 second delay for tasks to be updated.
//	This task will be created as "Completed" and will start to fail subtasks if casualties are registered.
//
//
/////////////////////
//	 Deaths   //
/////////////////////
//
//	1. Task Type: 2.
//	2. [Parameters], these are the parameters you can tweak for the Wait/Defend task.
//		1) "Task Name". A unique Task Name (invisible).														""
//		2) [Task Description].																				["",""]
//			a) "Description". Description of the task.	 													""
//			b) "Title". The visible title of your task.		 												""
//		3) Destination.	Where the task will be placed on the map.											[X,Y,Z] or ""
//			a) Can be [X,Y,Z] or "Marker".
//			b) If you don't want it placed on the map, type: ObjNull
//		4) "TaskIcon".																						""
//			a) This is the icon used for the task.
//			b) Default: "Wait"
//			c) You can find the task names in the Create Task module in the Arma 3 editor.
//		5) Time / Variable. 																				Number, ""
//			a) Here you can enter either Time (number) or a "Variable".
//			b) If you use Time, the time will start ticking from when the task is created. Chain the task.
//			c) If you use a "Variable", as soon as this Variable is defined, the task will succeed.
//		6) {CODE}																							{}
//			a) Code to be executed upon task completion.
//			b) The code is Called.
//			c) Passed variable is: (_This select 0), (Succeeded)
//	3. Notification, whether the task will create a notification top center of screen.						Boolean
//		a) if you want a notification, type True.
//		b) if you don't want a notification, type False.
//		c) Defaults to True.
//
//	Examples:
//	[7,["NEKY_Task7", ["Wait for the helicopter to arrive.","Wait"], "Extraction", "Wait", 120]] Spawn NEKY_Tasks_Run;
//	[7,["NEKY_Task7", ["Defend FOB Windstorm from CSAT forces.","Defend"], [1412,4124,0], "Defend", "DEFENDED", { [[],{SystemChat "HQ: FOB Windstorm has been defended!"}] remoteExec ["BIS_FNC_CALL",0] } ]] Spawn NEKY_Tasks_Run;
//
//	Notes:
//	The code executed after succeeded task will only run on the server.
//
//
////////////////
////////////
////////
////
//
//	This is the main executor of any function of this script.
//
//	Made by NeKo-ArroW
//	Version 1.22


if !(isServer) exitWith {};

// Waits until Map Screen is revealed.
WaitUntil {getClientStateNumber >= 8 or !isMultiplayer};

Params
[
	["_TaskType", 0, [0]],
	["_Params", [], [[]]],
	["_Notify", 0, [0,true]]
];

// Select Function
_Functions = ["NONE","AvoidCasualties","AvoidDeaths"];
_Function = _Functions select _TaskType;
if (isNil "_Function") exitWith {SystemChat "NEKY_Tasks_Run: ERROR, incorrect task type"};
if (_Function == "NONE") exitWith {SystemChat "NEKY_Tasks_Run: ERROR, Incorrect task type"};

// Call Function
Call Compile Format ["[_Params,_Notify] Spawn NEKY_Tasks_%1",_Function];