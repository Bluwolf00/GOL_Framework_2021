
/*
 	Add clear task to an area

	[house_1,nil,45,"Clear Area","attack"] spawn OKS_ClearImmediateArea;
	[house_1,nil,15,"Clear Building","kill"] execVM "Scripts\OKS_Task\OKS_ClearImmediateArea.sqf";	
*/

Params [
	["_Target",objNull,[objNull]],
	["_Parent",nil,[""]],
	["_Range",15,[0]],
	["_TaskTitle","Secure Area",[""]],
	["_TaskIcon","attack",[""]]
];

_TaskId = format["OKS_ClearImmediateArea_%1",round(random 9999)];
_TaskDetails = _TaskId;
if(!isNil "_Parent") then {
	_TaskDetails = [_TaskId,_Parent];
};

_TaskInfo = [
	true,
	_TaskDetails,
	[
		"You have been tasked with clearing this of enemy forces. Root out the enemy by all means necessary.",
		_TaskTitle,
		"Target"
	],
	getPos _target,
	"AUTOASSIGNED",
	-1,
	false,
	_TaskIcon
] call BIS_fnc_taskCreate;

_trigger = createTrigger ["EmptyDetector", getPos _target];
_trigger setTriggerArea [_Range, _Range, 0, true];
_trigger setTriggerActivation ["EAST", "PRESENT", true];
_trigger setTriggerStatements ["this", "", ""];

waitUntil {sleep 1; triggerActivated _trigger};
waitUntil {sleep 1; {Alive _Target || [_X] call ace_common_fnc_isAwake} count list _trigger == 0};
_Target setVariable ["ObjectiveComplete",true,true];
[_TaskId,"SUCCEEDED",true] call BIS_fnc_taskSetState;
