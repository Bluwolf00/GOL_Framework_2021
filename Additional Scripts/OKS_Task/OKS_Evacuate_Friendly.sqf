	// OKS_Evacuate_Friendly
	// [getPos house_1,getPos flag_west_1,west,true,6,"evacuatetasksucceded",500] spawn OKS_Evacuate_Friendly;
	//  [getPos house_1,getPos flag_west_1,west,true,6,"evacuatetasksucceded",500] execVM "Scripts\OKS_Task\OKS_Evacuate_Friendly.sqf";
	if(!isServer) exitWith {};

	Params [
		["_Position",[0,0,0],[[]]],
		["_Exfil",[0,0,0],[[]]],
		["_Side",west,[sideUnknown]],
		["_ShouldCreateTasks",true,[true]],
		["_NumberOfInfantry",5,[0]],
		["_Variable","",[""]],
		["_ActivationRange",250,[0]]
	];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_Unit","_Casualties","_SelectedLeader","_GroupMarker","_sideMarker"];
	Private _Debug_Variable = true;

	_Settings = [_Side] call OKS_TASK_Setting;
	_Settings Params ["_Leaders","_Units"];
	_AllBuildings = (nearestObjects [getPos house_1, ["HOUSE","BUILDING"], 50]);
	{_AllBuildings pushBackUnique _X} foreach (nearestTerrainObjects [_Position, ["HOUSE"], 50]);
	_Building = ([_AllBuildings, [], { _Position distance _x }, "ASCEND",{Count ([_X] call BIS_fnc_buildingPositions) >= _NumberOfInfantry}] call BIS_fnc_sortBy)#0;
	if(isNil "_Building") exitWith {systemChat "Debug: Building with enough positions not found. Exiting."};

	// Get Building Data
	_Building setVariable ["OKS_IsObjective",true];
	_GarrisonMaxSize = Count ([_Building] call BIS_fnc_buildingPositions);
	_GarrisonPositions = ([_Building] call BIS_fnc_buildingPositions);

	switch (_Side) do {
		case west:{
			_sideMarker = "ColorBlufor";
			_GroupMarker = "b_inf";
		};
		case east:{
			_sideMarker = "ColorOpfor";
			_GroupMarker = "o_inf";
		};
		case independent:{
			_sideMarker = "ColorIndependent";
			_GroupMarker = "n_inf";
		};
		default{
			_sideMarker = "colorBlack";
			_GroupMarker = "b_inf";
		}
	};
	_startmarker = createMarker [format ["oks_evacuate_marker_%1",str round(random 80000 + random 9999)],_Position, 0];
	_startmarker setMarkerType "hd_start";
	_startmarker setMarkerColor _sideMarker;
	_startmarker setMarkerShape "ICON";

	_endmarker = createMarker [format ["oks_evacuate_end_%1",str round(random 80000 + random 9999)],_Exfil, 0];
	_endmarker setMarkerType "hd_end";
	_endmarker setMarkerColor _sideMarker;

		// Create the Garrison Group
		_Group = CreateGroup _Side;
		_Group setVariable ["acex_headless_blacklist",true];
		for "_i" from 1 to _NumberOfInfantry do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
				_Unit setRank "SERGEANT";
				_SelectedLeader = _Unit;
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position getPos [(random 8),(random 360)], [], 0, "NONE"];
				_Unit setRank "PRIVATE";

			};
			if(_Debug_Variable) then {SystemChat format ["%1 Pos %2",group _unit,getPos _Unit]};
			_Unit disableAI "PATH";
			_Unit setCombatMode "YELLOW";
			_Unit setUnitPos "MIDDLE";
			_Unit setSkill 1;

			_Select = selectRandom _GarrisonPositions;
			_GarrisonPositions deleteAt (_GarrisonPositions find _Select);
			_Unit setPos _Select;

			if(_Side isNotEqualTo civilian) then {
				_Unit setUnitPos (selectRandom ["AUTO","MIDDLE"]);
			};

			sleep 1;
		};

		_startmarker setMarkerText (format["%1",[str _Group, 7] call BIS_fnc_trimString]);
		_endmarker setMarkerText (format["%1",[str _Group, 7] call BIS_fnc_trimString]);
		 /* Arguments:
			 * 0: The building(s) nearest this position are used <POSITION>
			 * 1: Limit the building search to those type of building <ARRAY>
			 * 2: Units that will be garrisoned <ARRAY>
			 * 3: Radius to fill building(s) <SCALAR> (default: 50)
			 * 4: 0: even filling, 1: building by building, 2: random filling <SCALAR> (default: 0)
			 * 5: True to fill building(s) from top to bottom <BOOL> (default: false) (note: only works with filling mode 0 and 1)
			 * 6: Teleport units <BOOL> (default: false)
		 */
		private _type = typeOf nearestBuilding (getPos (leader _group));
		_Building setVariable ["OKS_isGarrisoned",true];

		if(_Debug_Variable) then {
			SystemChat format ["Friendly Evacuation at %1 Units: %2",_Position,count units _Group];
			//SystemChat format ["Houses to setVariable: %1",_Houses];
		};

		waitUntil {sleep 5; !(isNil "ace_ai_fnc_garrison") && !(isNil "OKS_SetStatic")};
		//[_Position, [_type], units _Group, 5, 2, false, true] remoteExec ["ace_ai_fnc_garrison",0];
		sleep 2;
		[_Group] remoteExec ["OKS_SetStatic",0];
		//_SelectedLeader = selectRandom (units _Group);
		_TaskId = (round(random 99999));
		_Task = format["OKS_EVACUATETASK_%1",_TaskId];
		// Create Main Task
		if(_ShouldCreateTasks) then {
			if(count taskChildren ("EVACUATEMAIN" call BIS_fnc_taskVar) == 0) then {
				[true, ["EVACUATEMAIN"], [format["You have been tasked with evacuating friendly forces in the area of operations. Each element needs to be dropped off and their respective exfil points. Once you have arrived in the area, let them know that you are ready for them to embark. (Vehicle Action)"], format["Evacuate Friendlies"], "Evacuate"], _SelectedLeader,"CREATED",-1, false,"meet", false] call BIS_fnc_taskCreate;
			};
			[true, [_Task,"EVACUATEMAIN"], [format["Callsign %3, a squad of infantry located in the area around this <font color='#84e4ff'><marker name = '%1'>location</marker></font color>. They have requested an evacuation to reach their new <font color='#84e4ff'><marker name = '%2'>position</marker></font color>. Use the action on your vehicles when you are ready.",_startmarker,_endmarker,[str _Group, 2] call BIS_fnc_trimString], format["Evacuate %1",[str _Group, 7] call BIS_fnc_trimString], "Evacuate"], _SelectedLeader,"CREATED",-1, false,"run", false] call BIS_fnc_taskCreate;
		};
		_Group setVariable [format["OKS_EVACUATETASK_",_TaskId],false,true];


		// When player is within 250 meters of Objective Group (Activates AI) or if all objective group members are dead (Objective Fails)
		waitUntil { sleep 5; {_X distance _Building < _ActivationRange} count AllPlayers >= 1 || {Alive _X} count units _Group < 1};
		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks && isServer) exitWith {
				[_Task,"FAILED"] call BIS_fnc_taskSetState;
				deleteMarker _StartMarker;
				deleteMarker _EndMarker;
			};
		{_X setCaptive false; _X setCombatMode "RED"} foreach units _Group;
		[_Task,"ASSIGNED",true] call BIS_fnc_taskSetState;


		_Trigger = createTrigger ["EmptyDetector", getPos _Building, false];
		_Trigger setTriggerArea [100,100,20,false];
		_Trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
		_Trigger setTriggerStatements ["this","",""];
		private _VehicleId = format ["oks_evacuate_vehicle_%1",str round(random 80000 + random 9999)];
		GOL_CURRENT_EVACUATION_VEHICLES = [];
		[_Trigger,_Group,_StartMarker,_VehicleId] spawn {
			Params ["_Trigger","_Group","_StartMarker","_VehicleId"];
			while {!isNil "_Trigger"} do {
				if(isNull _Trigger || {!Alive _X} count units _Group == count units _Group) exitWith {systemChat "Trigger or Group Deleted. Exiting Script"};
				//SystemChat format["Trigger Exists: %1",list _Trigger];
				{
					_Player = _X;
					//systemChat str _Player;
					//systemChat str ((vehicle _Player) call BIS_fnc_objectType);
					//systemChat str [{_X in ((vehicle _Player) call BIS_fnc_objectType)} count ["Vehicle"] > 0,((vehicle _X) getVariable ["OKS_Evacuate_Action",false])];
					if(
						{_X in ((vehicle _Player) call BIS_fnc_objectType)} count ["Vehicle"] > 0 &&
						!((vehicle _X) getVariable ["OKS_Evacuate_Action",false] &&
						!((_Group) getVariable ["OKS_EVACUATE_TASK",false])) &&
						!(isNull _Trigger)
					) then {
						// Add Action to Player Vehicles
						//SystemChat "Add Action to Vehicle.";
						(vehicle _X) setVariable ["OKS_Evacuate_Action",true,true];
						_OKS_Evacuate_Statement = {
							params["_Object","_Target","_id","_args"];
							_args params ["_Group","_VehicleId","_Trigger"];

							if !(_Group GetVariable ["OKS_EVACUATE_TASK",false]) then {
			
								(_Group) setVariable ["OKS_EVACUATE_TASK",true,true];
								{_X assignAsCargo _Object} foreach units _Group;
								(_Object) setUnloadInCombat [false, false];

								// Reset Vehicle Action
								_Object setVariable ["OKS_Evacuate_Action",false,true];
								deleteVehicle _Trigger;

								//[_Object,0,["ACE_MainActions",_Action]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject",0];
								[leader _Group,format["1-1 this is %1, we are moving to mount up, out.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
							};
							_Object removeAction _id;
						};
						//publicVariable "OKS_Evacuate_Statement";
						//systemchat str _StartMarker;
						
						// Add action if it isn't an MHQ
						if(!(["mhq", vehicleVarName _X,false] call BIS_fnc_inString)) then {
							[(vehicle _X),["<t color='#FFD200'>READY TO EVACUATE!</t>", _OKS_Evacuate_Statement,[_Group,_VehicleId,_Trigger],6,true,true,"",format["_this in _target && _target distance (getMarkerPos '%1') < 50",_StartMarker]]] remoteExec ["addAction",0];
							GOL_CURRENT_EVACUATION_VEHICLES pushBackUnique (vehicle _X);
							publicVariable "GOL_CURRENT_EVACUATION_VEHICLES";	
						};
					};
				} foreach (list _Trigger);
				sleep 5;
			};
		};	

		/// Wait until the OKS_EVACUATE_TASK_Task_X is true or if all objective group members are dead.
		waitUntil {_Group GetVariable ["OKS_EVACUATE_TASK",false] || {Alive _X} count units _Group < 1};

		// Reset Variable to allow AddAction to Occur once more
		{
			_X setVariable ["OKS_Evacuate_Action",false,true];
			removeAllActions _X;
		} foreach GOL_CURRENT_EVACUATION_VEHICLES;

		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks && isServer) exitWith {
			[_Task,"FAILED"] call BIS_fnc_taskSetState;
			deleteVehicle _Trigger;
			deleteMarker _StartMarker;
			deleteMarker _EndMarker;
		};

		OKS_EnableCode = {
			Params ["_Group","_Exfil"];
			{_X setCombatMode "YELLOW"; _X disableAI "COVER"; _x disableAI "SUPPRESSION"; _X disableAI "AUTOCOMBAT"; _X setBehaviour "AWARE"; _X enableAttack false; _X disableAI "FSM"; _X enableAI "MOVE"; _X enableAI "PATH"; _X setUnitPos "UP"; [_X] orderGetIn true;} foreach units _Group;
		};
		PublicVariable "OKS_EnableCode";
		_null = [_Group,_Exfil,_Debug_Variable] spawn {
			Params ["_Group","_Exfil","_Debug_Variable"];
			while {{Alive _X} count units _Group > 0} do {
				//if(_Debug_Variable) then { systemChat format["Group %1 - Exfil %2 - Enabled AI",_Group,_Exfil]};
				[_Group,_Exfil] remoteExec ["OKS_EnableCode",0];
				sleep 20;
			}
		};
		waitUntil{ sleep 3; {isNull (objectParent _X) && Alive _X} count units _Group == 0};
		[leader _Group,format["1-1 this is %1, all in, out.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
		_startmarker setMarkerAlpha 0;
		Private _Repetition = 0;
		waitUntil {
			sleep 2;
			({
				(_X distance _Exfil < 45 && isNull (ObjectParent _X)) ||
				(_X distance _Exfil < 25 && !isNull (ObjectParent _X)) ||
				(!Alive _X)
			} count units _Group == count units _Group)
			OR
			({Alive _X} count units _Group < 1)
		};
		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks) exitWith {
			[_Task,"FAILED"] call BIS_fnc_taskSetState;
			deleteMarker _StartMarker;
			deleteMarker _EndMarker;
		};
		[leader _Group,format["1-1 this is %1, we are ready to dismount, halt the vehicle, over.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
		waitUntil {sleep 5; speed (objectParent (leader _Group)) == 0};
		{unassignVehicle _X; _X leaveVehicle (objectParent _X); doGetOut _X;} foreach units _Group;

		waitUntil {sleep 5; {isNull (objectParent _X)} count units _Group == count units _Group};
		if(_ShouldCreateTasks) then {
			[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
			Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
		};

		// Radio Call reaching Exfil
		if(_Debug_Variable) then { systemChat "Exfil reached - Garrisoning"};
		[leader _Group,format["1-1 this is %1, we have reached our position, thanks for the assist, out.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
		_Types = [];
		(_Exfil nearObjects ["House", 50]) apply {_Types pushBackUnique (typeOf _X)};
		[_Exfil, _Types, units _Group, 5, 1, true, false] remoteExec ["ace_ai_fnc_garrison",0];
		_UnitArray = [];

		_Repetition = 0;
		waitUntil { sleep 2; if({speed _X isEqualTo 0} count units _Group == count units _Group) then { _Repetition = _Repetition + 1; if(_Debug_Variable) then { systemChat format["Repetition: %1",_Repetition]};} else { _Repetition = 0; if(_Debug_Variable) then { systemChat format["Reset Repetition: %1",_Repetition]}; }; _Repetition isEqualTo 5};
		if(_Debug_Variable) then { systemChat "Garrison Complete - Set to Static"};
		{[_X,"PATH"] remoteExec ["disableAI",0]}foreach units _Group;
		_endmarker setMarkerAlpha 0;

		OKS_SetEvacuateMarker = {
			Params ["_marker","_Group","_GroupMarker","_SideMarker"];

			_marker setMarkerType _GroupMarker;
			_marker setMarkerColor _SideMarker;
			_marker setMarkerText format["%1",[str _Group, 7] call BIS_fnc_trimString];
			_marker setMarkerSize [0.7,0.7];
			_marker setMarkerAlpha 1;
			_marker setMarkerPos (getPos leader _Group);
		};
		_unitmarker = createMarker [format ["oks_evacuate_unitmarker_%1",str round(random 80000 + random 9999)],(getPos leader _Group), 0];
		_unitmarker setMarkerColor _sideMarker;
		[_unitmarker,_Group,_GroupMarker,_SideMarker] remoteExec ["OKS_SetEvacuateMarker",0];

		if({taskState _X == "succeeded"} count (taskChildren ("EVACUATEMAIN" call BIS_fnc_taskVar)) == count (taskChildren ("EVACUATEMAIN" call BIS_fnc_taskVar))) then {
			"EVACUATEMAIN" setTaskState "SUCCEEDED";
		};


