
/*
 Setup in OKS_TaskSetup.SQF
*/
_unit = _this select 0;
_id = _this select 1;
_name = _this select 2;
_faction = _this select 4;
_taskNumber = _this select 5;
_taskType = _this select 6;
_taskID = ((_this select 3) select 0);
_taskTitle = [(_this select 3), 1, "No Title Found"] call BIS_fnc_param;
_taskDesc = [(_this select 3), 2, ""] call BIS_fnc_param;
_taskMarker = [(_this select 3), 3, ""] call BIS_fnc_param;
_taskLocation = [(_this select 3), 4, objNull] call BIS_fnc_param;
_taskParent = [(_this select 3), 5, ""] call BIS_fnc_param;

_TaskInfo = [_faction, [format["%1",_taskID],format["%1",_taskParent]], [format["%1",_taskDesc], format["%1",_taskTitle], format["%1",_taskMarker]], _taskLocation,"CREATED",-1,false];

_TaskVariable = format ["OKS_TASK_INFO_%1",_TaskNumber];
_unit setVariable [_TaskVariable,_TaskInfo];

	_Statement = {

		params["_Object","_Target","_Array"];

		if(_Object isKindOf "Man" && side _Object != west) then {
			switch (selectRandom [1,2,3,4,5,6]) do {
				case 1: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_1.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
				case 2: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_2.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
				case 3: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_3.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
				case 4: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_4.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
				case 5: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_5.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
				case 6: {
					playSound3D [MISSION_ROOT + "OKS_Talk\Voices\Arab_Talk_6.ogg", _Object, false, getPosASL _Object, 5, 1, 25];
				};
			};
		};

		_taskParent = _Array select 0;
		_taskID = _Array select 1;
		_taskDesc = _Array select 2;
		_taskTitle = _Array select 3;
		_taskMarker = _Array select 4;
		_taskLocation = _Array select 5;
		_taskNumber = _Array select 6;
		_taskType = _Array select 7;

		_Task = [_faction, [format["%1",_taskID],_taskParent], [format["%1",_taskDesc], format["%1",_taskTitle], format["%1",_taskMarker]], _taskLocation,"AUTOASSIGNED",-1,true] call BIS_fnc_taskCreate;
		[_Task,_TaskType] call BIS_fnc_taskSetType;
		_TaskIdVariable = format ["OKS_TASK_ID_%1",_TaskNumber];
		_Object setVariable [_TaskIdVariable,_Task];

		_TaskActionVariable = format ["OKS_TASK_ACTION_%1",_TaskNumber];
		_Action = _Object getVariable [_TaskActionVariable,false];
		[_Object,0,["ACE_MainActions",_Action]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject",0];

	};

	_Action = [_id,_name,"",_Statement,{true},{},[format["%1",_taskParent],format["%1",_taskID],format["%1",_taskDesc],format["%1",_taskTitle],format["%1",_taskMarker],_taskLocation,_TaskNumber,_TaskType],{}] call ace_interact_menu_fnc_createAction;

	_TaskActionVariable = format ["OKS_TASK_ACTION_%1",_TaskNumber];
	_unit setVariable [_TaskActionVariable,_id];

	[_unit, 0, ["ACE_MainActions"], _Action] call ace_interact_menu_fnc_addActionToObject;