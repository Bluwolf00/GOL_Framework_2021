

Params [
	["_Vehicle", ObjNull, [ObjNull]],
	["_Group", GrpNull, [GrpNull]],
	["_DropOff", ObjNull, [ObjNull]],
	["_TaskID", "",[""]],
	["_ParentTask","",[""]]
];

Private _TroopCount = count(units _Group select {Alive _X});
Private _Troop = units _Group;

Private _WaitUntilDelete = {
	Params ["_Unit","_DropOff"];
	waitUntil {sleep 1; _Unit doMove (getPos _DropOff); _Unit distance _DropOff < 3};
	deleteVehicle _Unit;
};

{
	[_x] join grpNull;
	_X leaveVehicle _Vehicle;
	unassignVehicle _X;
	doGetOut _X;
	sleep 3;
	_X doMove (getPos _DropOff);
	_X moveTo (getPos _DropOff);
	sleep 3;
	[_X,_DropOff] spawn _WaitUntilDelete;
} foreach units _Group;

Private _Repeat = 0;
waitUntil{sleep 2; _Repeat = _Repeat + 1; ({Alive _X} count _Troop) isEqualTo 0 || _Repeat >= 10};
if(_Repeat >= 10) then {
	{_X hideObject true; doGetOut _X; deleteVehicle _X} foreach _Troop;
};
private _CurrentCount = missionNamespace getVariable [_ParentTask,false];
missionNamespace setVariable [_ParentTask,(_CurrentCount + _TroopCount)];
[_TaskID,"SUCCEEDED"] call BIS_fnc_taskSetState;