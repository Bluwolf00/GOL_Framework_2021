
	/// _null = [Task_Object_1,NumberTaskOnObject,"SUCCEEDED"] spawn OKS_TASKSTATE;
	/// If you have 1 task for one object, use 1 on NumberTaskOnObject. This is for when you have more than one task from one
	/// object.

	if(!isServer) exitWith {};

	_TaskObject = _this select 0;
	_TaskNumber = _this select 1;
	_State = _this select 2;

	_Task = _TaskObject getVariable [format ["OKS_TASK_ID_%1",_TaskNumber],false];
	_Action = _TaskObject getVariable [format ["OKS_TASK_ACTION_%1",_TaskNumber],false];
	[_TaskObject,0,["ACE_MainActions",_Action]] call ace_interact_menu_fnc_removeActionFromObject;


	if("STRING" != typeName _Task) then {
		if(!_Task) then {
			_TaskInfo = (_this select 0) getVariable [format ["OKS_TASK_INFO_%1",_TaskNumber],false];
			_Task = _TaskInfo call BIS_fnc_taskCreate;
			[_Task,_State] call BIS_fnc_taskSetState;
		};
	}
	else {
			[_Task,_State] call BIS_fnc_taskSetState;
	};