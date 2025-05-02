/*
     Add destroy or kill task to unit/vehicle.

    [officer_1] spawn OKS_Destroy_Task;
    [[officer_1,officer_2,officer_3]] execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf";

    [officer_1,"Kill the Officer","Enemy Officer","You need to kill this %1 because it needs to happen","kill",nil,true,true] spawn OKS_Destroy_Task;
    [
        TargetOrTargets,
        TaskTitle,
        TargetName,
        TaskDescription - "You need to kill this %1 because it needs to happen. There are %2 targets." (1% == TargetName, %2 == Count of targets),
        TaskIcon,
        TaskParent,
        shouldShowPos,
        shouldPopUpNotify
    ] execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf";    
*/

Params [
    ["_Target",objNull,[objNull,[]]],
    ["_CustomTitle",nil,[""]],
    ["_CustomDisplayName",nil,[""]],
    ["_CustomDescription",nil,[""]],
    ["_CustomIcon","destroy",[""]],
    ["_TaskParent",nil,[""]],
    ["_ShouldShowPosition",true,[true]],
    ["_ShouldPopUpNotification",true,[true]]    
];

private ["_TaskInfo","_TargetDisplayName","_TaskId"];
private _TaskPosition = nil;
private _TaskIcon = "destroy";
private _TargetArray = [];

if(typeName _target == "OBJECT") then {
    if(_target isKindOf "Man") then {
        _TargetDisplayName = name _target;
        _TaskIcon = "kill";
    };
    if(_target isKindOf "LandVehicle") then {
        _TargetDisplayName = [configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName;
        _TaskIcon = "destroy";
    };
    _TargetArray pushBackUnique _target;
	if(_ShouldShowPosition) then {	
		_TaskPosition = getPos _target;
	}
};
if(typeName _target == "ARRAY") then {
    _selectedTarget = selectRandom _target;
    if(_selectedTarget isKindOf "Man") then {
        _TargetDisplayName = name _selectedTarget;
        _TaskIcon = "kill";
    };
    if(_selectedTarget isKindOf "LandVehicle") then {
        _TargetDisplayName = [configFile >> "CfgVehicles" >> typeOf _selectedTarget] call BIS_fnc_displayName;
        _TaskIcon = "destroy";
    };
	if(_ShouldShowPosition) then {
		_TargetArray = _target;
		_TaskPosition = [0, 0, 0];
		{
			_TaskPosition = _TaskPosition vectorAdd (getPosWorld _x);
		} forEach _TargetArray;
		_TaskPosition = _TaskPosition vectorMultiply (1 / (count _TargetArray));	
	}
};

if(isNil "_CustomTitle") then {
    _CustomTitle = format["Eliminate %1",_TargetDisplayName];
};
if(isNil "_CustomDescription") then {
    _CustomDescription = format["You have been tasked with eliminating a valueable target, the target: %1",_TargetDisplayName];
};
if(!isNil "_CustomDisplayName") then {
    _TargetDisplayName = _CustomDisplayName;
};
if(!isNil "_CustomIcon") then {
    _TaskIcon = _CustomIcon;
};

_TaskId = format["OKS_DestroyTask_%1",random 9999 + (random 9999)];
_TaskData = _TaskId;
if(!isNil "_TaskParent") then {
	_TaskData = [_TaskId,_TaskParent]
};
_TaskInfo = [
	true,
	_TaskData,
	[format[_CustomDescription,_TargetDisplayName,count _TargetArray], format["%1",_CustomTitle], ""],
	_TaskPosition,
	"AUTOASSIGNED",
	-1,
	_ShouldPopUpNotification,
	_TaskIcon
] call BIS_fnc_taskCreate;

waitUntil {sleep 5; {Alive _X} count _TargetArray == 0};
[_TaskId,"SUCCEEDED",_ShouldPopUpNotification] call BIS_fnc_taskSetState;