	// OKS_Rescue_Friendly
	// [[1241.42,2522.1,4],east,["lot","large","fatal"],nil] spawn OKS_Treat_Casualty
	// [getPosATL pos_1,east,["lot","large","fatal"],nil] spawn OKS_Treat_Casualty;
	// [casualty_1,east,["lot","large","fatal"],nil] execVM "Scripts\OKS_Task\OKS_Treat_Casualty.sqf";
	if(!isServer) exitWith {};

	Params [
		["_ManOrPosition",objNull,[objNull]],
		["_Side",civilian,[sideUnknown]],
		["_Severity",["lot","large","fatal"],[[]]],
		["_TaskParent","",[""]]
	];
	Private ["_PosATL","_Dir","_Unit","_Casualty"];
	Private _Debug_Variable = false;
	_Settings = [_Side] call OKS_TASK_Setting;
	_Settings Params ["_Leaders","_Units"];

	if(typeName _ManOrPosition == "ARRAY") then {
			_PosATL = getPosATL _ManOrPosition;
			_Dir = getDir _ManOrPosition;
	} else {
		if(!(_ManOrPosition isKindOf "Man")) exitWith {
			systemChat "Treat Task: Given object is not human.";
		};
		if((_ManOrPosition isKindOf "Man")) then
		{
			_Casualty = _ManOrPosition;
		} else {
			_PosATL = getPosATL _ManOrPosition;
			_Dir = getDir _ManOrPosition;
		}
	};

	if(isNil "_Casualty") then {
		_Casualty = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _PosATL, [], 0, "NONE"];
		_Group setVariable ["acex_headless_blacklist",true,true];
		_Casualty setPosATL _PosATL;
		_Casualty setDir _Dir;		
		_Casualty setRank "PRIVATE";
		_Casualty setUnitPos "Middle";
		_Casualty disableAI "MOVE";
	};

	For "_i" from 0 to 30 do {
		_Casualty addItemToUniform "ACE_ElasticBandage"
	};

	private _Status = (selectRandom _Severity);
	private _TextStatus = "";
	[_Casualty,_Status] spawn OKS_MedicalDamage;

	waitUntil {sleep 1; _Casualty getVariable ["GOL_MedicalInjuryReady",false]};

	switch (_Status) do{
		case "lot": {
			_TextStatus = "The casualty has lost a lot of blood and require medical attention, if not treated soon he may go into cardiac arrest."
		};
		case "large": {
			_TextStatus = "The casualty has lost a large amount of blood and require medical attention, he will most likely go into cardiac arrest if not stabilized soon."
		};
		case "fatal": {
			_TextStatus = "The casualty has lost a fatal amount of blood and require immediate medical attention, he is in cardiac arrest currently, time is extremely short."
		};
		default {
			_TextStatus = "We do not have a clear picture of the status of the casualty."
		}
	};

	_TaskId = format["OKS_TREAT_TASK_%1",(round(random 99999))];

	if(isNil "_TaskParent") then {
		[true, _TaskId, [format["You have a casualty to stabilize. %1",_TextStatus], "Stabilize Casualty", "Casualty"], _Casualty,"ASSIGNED",-1, false,"heal", false] call BIS_fnc_taskCreate;
	} else {
		[true, [_TaskId,_TaskParent], [format["You have a casualty to stabilize. %1",_TextStatus], "Stabilize Casualty", "Casualty"], _Casualty,"ASSIGNED",-1, false,"heal", true] call BIS_fnc_taskCreate;
	};
	sleep 20;
	waitUntil {
		sleep 1;
		(([_Casualty] call ace_medical_status_fnc_getCardiacOutput > 0.07) &&
		[_Casualty] call ace_medical_status_fnc_getBloodLoss < 0.001 &&
		{[_Casualty, _X] call ace_medical_treatment_fnc_hasTourniquetAppliedTo} count ["LeftLeg","RightLeg","LeftArm","RightArm"] == 0)
		|| !Alive _Casualty
	};

	if(!Alive _Casualty) exitWith {
		[_TaskId,"FAILED"] call BIS_fnc_taskSetState;
	};
	[_TaskId,"SUCCEEDED"] call BIS_fnc_taskSetState;
		


