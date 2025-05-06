/*
	OKS_Defuse_Explosive - Do not use too many at a time, can cause lag.

 	[explosive_1,60,targetObject,"Task_Main",true,false,"VariableOnSuccess","VariableOnFail"] execVM "Scripts\OKS_Task\OKS_Defuse_Explosive.sqf";
 	[getPos explosiveSite_1,60,targetObject,"Task_Main",true,true,"VariableOnSuccess","VariableOnFail"] spawn OKS_Defuse_Explosive;
*/ 

if(!isServer) exitWith {};

	Params [
		["_ExplosiveOrPositionATL",objNull,[[],objNull]],
		["_TimeInSeconds",600,[0]],
		["_TargetObject",nil,[objNull]],
		["_Parent",nil,[""]],
		["_PopUpNotification",true,[false]],
		["_ShouldShowPosition",true,[false]],
		["_VariableTrueOnFail","ExplosiveDetonated",[""]],
		["_VariableTrueOnSuccess","ExplosiveDefused",[""]]
	];

	Private ["_Explosive","_ExplosivePos","_TimeInMinutes","_TimeInVariable"];

	if(typeName _ExplosiveOrPositionATL == "ARRAY") then {
		_Explosive = "SatchelCharge_Remote_Ammo" createVehicle _ExplosiveOrPositionATL;
		_Explosive setPosATL _ExplosiveOrPositionATL;
		_ExplosivePos = getPos _Explosive;
	} else {
		_Explosive = _ExplosiveOrPositionATL;
		_ExplosivePos = getPos _Explosive;
	};

	_TimeInMinutes = (_TimeInSeconds / 60);
	_TimeInVariable = (_TimeInMinutes / 60);

	private _currentDayTime = dayTime; // assuming dayTime returns 1.66046
	private _targetDayTime = _currentDayTime + _TimeInVariable;

	private _hours = floor _targetDayTime;
	private _minutes = floor ((_targetDayTime - _hours) * 60);
	private _seconds = floor ((((_targetDayTime - _hours) * 60) - _minutes) * 60);

	private _minutesString = "";
	private _secondsString = "";
	if(_minutes > 9) then {
		_secondsString = _seconds
	} else {
		_minutesString = format["0%1",_minutes];
	};	
	if(_minutes > 9) then {
		_minutesString = _minutes;
		_secondsString 
	} else {
		_minutesString = format["0%1",_minutes];
	};
	_targetDayTimeAsString = format ["%1:%2:%3",_hours,_minutesString,_seconds];

	_defuseTask = format["DefuseBombTask_%1",(random 9999)];
	private _TaskId = _defuseTask;
	if(!isNil "_Parent") then {
		_TaskId = [_defuseTask,_Parent];
	};

	private _targetString = "";
	if(!isNil "_TargetObject") then {
		_targetString = [configFile >> "CfgVehicles" >> typeOf _TargetObject] call BIS_fnc_displayName;
	} else {
		_targetString = "sensitive area";
	};

	private _Position = objNull;
	if(_ShouldShowPosition) then {
		_Position = getPos _Explosive
	};

	[
		true,
		_TaskId,
		[
			format["An explosive charge has been placed to destroy a %3. You must defuse the explosive before it detonates. We suspect the charge is set to go off in %2 minutes, local time: %1",_targetDayTimeAsString,_TimeInMinutes,_targetString],
			"Defuse Explosive",
			"Defuse"
		],
		_Position,
		"ASSIGNED",
		-1,
		_PopUpNotification,
		"mine",
		false
	] call BIS_fnc_taskCreate;	

	private _TimeExpired = 0;
	waitUntil {
		sleep 1;
		_TimeExpired = _TimeExpired + 1;
		private _DoesTargetExistAndIsDestroyed = false;
		if(!isNil "_TargetObject") then {
			_DoesTargetExistAndIsDestroyed = !alive _TargetObject
		};		 
		systemChat str [_TimeExpired,_TimeInSeconds];
		_TimeExpired >= _TimeInSeconds || isNull _Explosive || _DoesTargetExistAndIsDestroyed
	};
	if(!isNull _Explosive) then {
		_Explosive setDamage 1;
	};
	sleep 0.1;
	// Find nearest GroundWeaponHolder for SatchelAmmo (Successful Disarm)
	_WeaponHolders = _ExplosivePos nearObjects ["ALL",3] select {typeOf _X == "GroundWeaponHolder"};
	_IsDisarmed = ({"SatchelCharge_Remote_Mag" in (magazineCargo _X)} count _WeaponHolders > 0);

	// If target exists, check if its alive.
	private _DoesTargetExistAndIsAlive = true;
	if(!isNil "_TargetObject") then {
		_DoesTargetExistAndIsAlive = alive _TargetObject
	};	

	if(_IsDisarmed && _DoesTargetExistAndIsAlive) then {
		[_defuseTask, "SUCCEEDED", true] call BIS_fnc_taskSetState;	
		Call Compile Format ["%1 = True; PublicVariable '%1'",_VariableTrueOnSuccess];
	} else {	
		[_defuseTask, "FAILED", true] call BIS_fnc_taskSetState;
		Call Compile Format ["%1 = True; PublicVariable '%1'",_VariableTrueOnFail];
	};