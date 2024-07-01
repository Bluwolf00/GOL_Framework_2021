
/*
	[1,Base,Spawn,6,west,dropoff,8,"Reinforce Balota Airfield"] execVM "Scripts\OKS_Task\OKS_Escort_Base.sqf";
	// [base,vehicle player,[spawn1,west,4,dropoff,"OKS_Escort_MainTask_1"]] remoteExec ["OKS_Escort_Spawn",0]
*/

Params [
	["_ID", 0, [0]],
	["_Base", ObjNull, [ObjNull]],
	["_Spawn", ObjNull, [ObjNull]],
	["_InfantryNumber", 4, [0]],
	["_Side", sideUnknown, [sideUnknown]],
	["_DropOff", ObjNull, [ObjNull]],
	["_ObjectiveNumber", 12, [0]],
	["_ObjectiveName", "Reinforce Friendlies",[""]]
];


_TaskID = format ["OKS_Escort_MainTask_%1",_ID];
[true, _TaskID, [format["Friendly forces have requested reinforcements. Your job is to escort enough troops (%1) to the area.",_ObjectiveNumber], _ObjectiveName, "Drop Off"], _DropOff,"CREATED",1,true, "run",false] call BIS_fnc_taskCreate;
missionNamespace setVariable [_taskID,0];

SystemChat str [_Spawn,_Side,_InfantryNumber,_DropOff,_TaskID];

_Base AddAction [
	"<t color='#ffff4c'>Request Escort Troop</t>",
	{
		Params ["_target","_caller","_actionId","_Array"];
		[_target,vehicle _caller,_Array] remoteExec ["OKS_Escort_Spawn",2]
	},
	[_Spawn,_Side,_InfantryNumber,_DropOff,_TaskID],
	10,
	true,
	true,
	"",
	"(_this distance _target < 30) && !(isNull objectParent _this)"
];

waitUntil{sleep 10; missionNamespace GetVariable [_taskID,0] >= _ObjectiveNumber};
removeAllActions _Base;
[_TaskID,"SUCCEEDED"] call BIS_fnc_taskSetState;

