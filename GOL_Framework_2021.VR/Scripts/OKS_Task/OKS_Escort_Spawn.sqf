
if(!isServer) exitWith {};

Params [
	["_Base", ObjNull, [ObjNull]],
	["_Vehicle", ObjNull, [ObjNull]],
	["_Array", [], [[]]]
];

[format["%1 %2 %3",_Base,_Vehicle,_Array]] remoteExec ["SystemChat",0];

Private ["_Leaders","_Units","_Unit"];
_Array Params ["_Spawn","_Side","_InfantryNumber","_DropOff","_ParentTask"];
_MaxCargo = _Vehicle emptyPositions "cargo";
_Settings = [_Side] call OKS_TASK_Setting;
_Settings Params ["_Leaders","_Units"];

if(_InfantryNumber > _MaxCargo) exitWith { systemChat "Vehicle is unable to hold the escort. Find another vehicle."};
_Group = createGroup _Side;
_Group setVariable ["hc_blacklist", true];
_Group setVariable ["lambs_danger_disableAI", true];

For "_i" from 1 to _InfantryNumber do {
	if ( (count (units _Group)) == 0 ) then
	{
		_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _Spawn select 0,getPos _Spawn select 1,0.2], [], 0, "NONE"];
		_Unit setRank "SERGEANT";
	} else {
		_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [getPos _Spawn select 0,getPos _Spawn select 1,0.2], [], 0, "NONE"];
		_Unit setRank "PRIVATE";
	};
	_Unit setUnitPos "UP";
	_Unit forceSpeed 5;
	_Unit setBehaviour "CARELESS";
	_Unit setDir (getDir _Spawn);
	_Unit assignAsCargo _Vehicle;
	[_Unit] orderGetin true;
	sleep 2.5;
};

private _count = 0;
waitUntil{ sleep 5; _count = _count + 1; (count units _Group isEqualTo _InfantryNumber && {_X in _Vehicle} count units _Group isEqualTo count units _Group) || _count >= 5};
if(_count >= 5) then {
	_Remaining = units _Group select {!(_X in _Vehicle)};
	{_X assignAsCargo _Vehicle; [_X] orderGetin true; _X moveInCargo _Vehicle} foreach units _Group;
};

_Players = crew _Vehicle select {isPlayer _X};
_TaskID = format["Escort_Task_%1",round(random 9999 + (random 9999))];

if(_Players isNotEqualTo []) then {
	[_Players, [_TaskID,_ParentTask], ["You have been tasked with escorting a troop to the destination. When you arrive at the drop off, remain stationary until they have all disembarked.", "Escort Troop", "Drop Off"], _DropOff,true,1,true, "exit",false] call BIS_fnc_taskCreate;
};

waitUntil {sleep 5; (_Vehicle distance _DropOff < 50 && speed _Vehicle isEqualTo 0) || {Alive _X} count units _Group isEqualTo 0};

if(_Vehicle distance _DropOff < 30 && speed _Vehicle isEqualTo 0) exitWith {
	[_Vehicle,_Group,_DropOff,_TaskID,_ParentTask] remoteExec ["OKS_Escort_Dropoff",0];
};

if({Alive _X} count units _Group isEqualTo 0) exitWith {
	[_TaskID,"FAILED"] call BIS_fnc_taskSetState;
};

//SystemChat str [_Base,_Vehicle,_Spawn,_Side,_InfantryNumber,_DropOff];
