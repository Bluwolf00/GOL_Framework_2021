// [explosive_1,60] execVM "Scripts\OKS_Task\OKS_Defuse_Explosive.sqf";
// [[3127.24,879.851,0],60] spawn OKS_Defuse_Explosive;

if(!isServer) exitWith {};

	Params [
		["_ExplosiveOrPositionATL",objNull,[[],objNull]],
		["_TimeInSeconds",600,[0]],
		["_VariableTrueOnFail","ExplosiveDetonated",[""]],
		["_VariableTrueOnSuccess","ExplosiveDefused",[""]]
	];

	sleep 10;

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

	_targetDayTimeAsString = format ["%1:%2:%3",_hours,_minutes,_seconds];
	_defuseTask = format["DefuseBombTask_%1",(random 9999)];

	[
		true,
		_defuseTask,
		[
			format["An explosive charge has been placed in a sensitive area. You must defuse the explosive before it detonates. We suspect the charge is set to go off at: %1",_targetDayTimeAsString],
			"Defuse Explosive",
			"Defuse"
		],
		getPos _Explosive,
		"ASSIGNED",
		-1,
		true,
		"mine",
		false
	] call BIS_fnc_taskCreate;

	waitUntil {
		sleep 1; 
		systemChat str [dayTime,_targetDayTime];
		(dayTime >= _targetDayTime) || isNull _Explosive
	};
	if(!isNull _Explosive) then {
		_Explosive setDamage 1;
	};
	sleep 0.1;
	_NearPlayerToExplosive = {_X distance _ExplosivePos < 3 && Alive _X && [_X] call ace_common_fnc_isAwake} count AllPlayers > 0;
	if(isNull _Explosive && _NearPlayerToExplosive) then {
		[_defuseTask, "SUCCEEDED", true] call BIS_fnc_taskSetState;	
		Call Compile Format ["%1 = True; PublicVariable '%1'",_VariableTrueOnSuccess];
	} else {	
		[_defuseTask, "FAILED", true] call BIS_fnc_taskSetState;
		Call Compile Format ["%1 = True; PublicVariable '%1'",_VariableTrueOnFail];
		{
			systemChat str _X;
			if(["bridge", str _X] call BIS_fnc_inString) then {
				_X hideObject true
			}		
		} foreach (_ExplosivePos nearRoads 25)
	};

	// [
	// 	true,
	// 	format["RescueHVTTask_%1",(random 9999)],
	// 	[
	// 		"You have failed the extraction of HVTs. The HVTs were killed!",
	// 		"Extract HVT",
	// 		"Extract"
	// 	],
	// 	objNull,
	// 	"FAILED",
	// 	-1,
	// 	true,
	// 	"exit",
	// 	false
	// ] call BIS_fnc_taskCreate;		

	// // Succeeded
	// [
	// 	true,
	// 	format["RescueHVTTask_%1",(random 9999)],
	// 	[
	// 		"You have successfully extracted HVTs. Good work!",
	// 		"Extract HVT",
	// 		"Extract"
	// 	],
	// 	objNull,
	// 	"SUCCEEDED",
	// 	-1,
	// 	true,
	// 	"exit",
	// 	false
	// ] call BIS_fnc_taskCreate;
		
