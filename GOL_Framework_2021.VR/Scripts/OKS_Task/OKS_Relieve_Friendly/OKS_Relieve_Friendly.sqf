	// OKS_Relieve_Friendly
	// [group this,nil,[4756.37,5623.24,0]] spawn OKS_Relieve_Friendly;
	// [5,getPos house_1,[4756.37,5623.24,0]] spawn OKS_Relieve_Friendly;
	//  [group this] execVM "Scripts\OKS_Task\OKS_Relieve_Friendly.sqf";
	if(!isServer) exitWith {};

	Params [
		["_GroupOrNumber",grpNull,[grpNull,0]],
		["_HouseLocation",nil,[[]]],
		["_ExfilPos",nil,[[]]],
		["_ShouldDeleteOnExfil",true,[true]],
		["_Side",west,[]]
	];
	Private ["_Group","_GarrisonPositions","_GarrisonMaxSize","_AdditionalTaskText"];
	Private _Debug_Variable = true;

	if(typeName _GroupOrNumber isEqualTo "SCALAR") then {
		_NumberOfInfantry = _GroupOrNumber;
		if(isNil "_HouseLocation") exitWith { systemChat "DEBUG: Cannot use integer as paramater for Relieve Friendly without a _HouseLocation. Make sure _HouseLocation is assigned"};
		_Group = [_NumberOfInfantry,_HouseLocation, _Side] call OKS_StaticGroup_NearestBuilding;
	} else {
		_Group = _GroupOrNumber;
	};

	if(isNil "_Group" || typeName _Group isEqualTo "STRING") exitWith { systemChat format["Failed to create group. Reason: %1",_Group]};
	if(!isNil "_ExfilPos") then {
		_AdditionalTaskText = " The squad will attempt to fallback once relieved. You do not need to escort them."
	} else {
		_AdditionalTaskText = "";
	};

	// Setup Group
	_Group setVariable ["acex_headless_blacklist",true];
	{
		_X disableAI "PATH"; _X enableAI "COVER"; _X enableAI "FSM"; _X setUnitPos "UP";
		_X enableAI "SUPPRESSION"; _x enableAttack true; _x allowFleeing 0;
	} foreach units _Group;

	_TaskId = (round(random 99999));
	_Task = format["OKS_RELIEVETASK_%1",_TaskId];

	// Create Main Task
	[	
		true,
		_Task,
		[
			format[
				"Callsign %1, a squad of infantry located in the area, they need to be relieved. Use the action on one of the friendly soldiers to relieve them.%2",
				[groupId _Group, 2] call BIS_fnc_trimString,
				_AdditionalTaskText
			],
			format[
				"Relieve %1",
				[groupId _Group, 6] call BIS_fnc_trimString
			],
			"Relieve"
		],
		leader _Group,
		"AUTOASSIGN",
		-1,
		false,
		"help",
		true
	] call BIS_fnc_taskCreate;

	{
		[
			_X,
			[
				"<t color='#FFD200'>RELIEVE SQUAD</t>", 
				{
					[((_this select 3) select 0),"SUCCEEDED"] call BIS_fnc_taskSetState;
					group (_this select 0) setVariable ['OKS_Relieved',true,true];	
				},
				[_Task],
				6,true,true,"",
				"!((group _target) getVariable ['OKS_Relieved',false]) && {alive _X} count units (group _target) > 0"
			]
		] remoteExec ["addAction",0];
	} foreach units _Group;

	waitUntil {sleep 5; _Task call BIS_fnc_taskState == "SUCCEEDED" || {Alive _X} count units _Group < 1};

	if({Alive _X} count units _Group < 1) exitWith {
		[_Task,"FAILED"] call BIS_fnc_taskSetState;
	};

	if(!isNil "_ExfilPos") then {
		{
			_IndividualGroup = createGroup (side _X);
			_x joinAs [_IndividualGroup, 0];
			_X enableAI "PATH"; _X enableAI "MOVE"; _X disableAI "COVER"; _X disableAI "FSM";
			_X disableAI "SUPPRESSION"; _x enableAttack false; _x allowFleeing 0;

			[_X,_ExfilPos] spawn {
				params ["_unit","_ExfilPos"];
				while {alive _unit} do {
					_unit doMove _ExfilPos;	
					sleep 5;
				};
				if(_unit distance _ExfilPos < 15 && _ShouldDeleteOnExfil) then {
					deleteVehicle _unit;
				}
			};
		} foreach units _Group;
	}


