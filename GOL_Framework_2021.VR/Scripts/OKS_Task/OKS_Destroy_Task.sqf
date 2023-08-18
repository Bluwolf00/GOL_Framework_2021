
/*
 	Add destroy or kill task to unit/vehicle.

	[officer_1] spawn OKS_Destroy_Task;
	[officer_1] execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf";

	[officer_1,"Kill the Officer","Enemy Officer","You need to kill this %1 because it needs to happen",true,true,nil] spawn OKS_Destroy_Task;
	[officer_1,"Kill the Officer","Enemy Officer","You need to kill this %1 because it needs to happen",true,true,nil] execVM "Scripts\OKS_Task\OKS_Destroy_Task.sqf";	
*/

Params [
	["_Target",objNull,[objNull]],
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

if(_target isKindOf "Man") then {
	_TargetDisplayName = name _target;
	_TaskIcon = "kill";
};
if(_target isKindOf "LandVehicle") then {
	_TargetDisplayName = [configFile >> "CfgVehicles" >> typeOf _target] call BIS_fnc_displayName;
	_TaskIcon = "destroy";
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

if(_ShouldShowPosition) then {
	_TaskPosition = getPos _target;
};

_TaskId = format["OKS_DestroyTask_%1",random 9999 + (random 9999)];
if(isNil "_TaskParent") then {
	_TaskInfo = [true, format["%1",_TaskId], [format[_CustomDescription,_TargetDisplayName], format["%1",_CustomTitle], ""], getPos _target,"AUTOASSIGNED",-1,_ShouldPopUpNotification,_TaskIcon] call BIS_fnc_taskCreate;
} else {
	_TaskInfo = [true, [format["%1",_TaskId],format["%1",_TaskParent]], [format[_CustomDescription,_TargetDisplayName], format["%1",_CustomTitle], ""], getPos _target,"AUTOASSIGNED",-1,_ShouldPopUpNotification,_TaskIcon] call BIS_fnc_taskCreate;
};

waitUntil {sleep 5; !Alive _Target};
[_TaskId,"SUCCEEDED",_ShouldPopUpNotification] call BIS_fnc_taskSetState;
