	// OKS_Escort_Friendly
	// [6,getPos escort1,east,true,getpos exfil,"VariableNameTrueOnSuccess",false] spawn OKS_Escort_Friendly;
	// [6,getPos escort1,east,true,getpos exfil,"VariableNameTrueOnSuccess",false] execVM "Scripts\OKS_Task\OKS_Escort_Friendly.sqf";
	if(!isServer) exitWith {};

	Params ["_NumberInfantry","_Position","_Side","_ShouldCreateTasks","_Exfil","_Variable","_ShouldUseVehicle"];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_Unit","_Casualties","_SelectedLeader","_GroupMarker","_sideMarker"];
	Private _Debug_Variable = true;

	_Settings = [_Side] call OKS_TASK_Setting;
	_Settings Params ["_Leaders","_Units"];
	_Building = nearestBuilding _Position;
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
	_startmarker = createMarker [format ["oks_escort_marker_%1",str round(random 80000 + random 9999)],_Position, 0];
	_startmarker setMarkerType "Contact_circle4";
	_startmarker setMarkerColor _sideMarker;
	_startmarker setMarkerShape "ICON";

	_endmarker = createMarker [format ["oks_escort_end_%1",str round(random 80000 + random 9999)],_Exfil, 0];
	_endmarker setMarkerType "Contact_pencilTask1";
	_endmarker setMarkerColor _sideMarker;

		// If Garrison is too big for Building, set to max size.
		if(_NumberInfantry >= _GarrisonMaxSize) then {
			_NumberInfantry = _GarrisonMaxSize;
			if(_Debug_Variable) then { systemChat str _NumberInfantry };
		};

		// Create the Garrison Group
		_Group = CreateGroup _Side;
		_Group setVariable ["hc_blacklist",true];
		for "_i" from 1 to _NumberInfantry do
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
				_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
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
			SystemChat format ["Friendly Escort at %1 Units: %2",_Position,count units _Group];
			//SystemChat format ["Houses to setVariable: %1",_Houses];
		};

		waitUntil {sleep 5; !(isNil "ace_ai_fnc_garrison") && !(isNil "OKS_SetStatic")};
		//[_Position, [_type], units _Group, 5, 2, false, true] remoteExec ["ace_ai_fnc_garrison",0];
		sleep 2;
		[_Group] remoteExec ["OKS_SetStatic",0];
		//_SelectedLeader = selectRandom (units _Group);
		_TaskId = (round(random 99999));
		_Task = format["OKS_ESCORTTASK_%1",_TaskId];
		// Create Main Task
		if(_ShouldCreateTasks) then {
			[true, [_Task,"RESCUEMAIN"], [format["Callsign %3, a squad of infantry located in the area around this <font color='#84e4ff'><marker name = '%1'>location</marker></font color>. They have requested an escort to reach their new <font color='#84e4ff'><marker name = '%2'>positition</marker></font color>. Talk to the Squad leader when you are ready to assist.",_startmarker,_endmarker,[str _Group, 2] call BIS_fnc_trimString], format["Escort %1",[str _Group, 7] call BIS_fnc_trimString], "Escort"], _SelectedLeader,"CREATED",-1, false,"help", false] call BIS_fnc_taskCreate;
		};
		//_Group selectLeader _SelectedLeader;
		//[_Group, _SelectedLeader] remoteExec ["selectLeader", 0];
		//[_SelectedLeader, "officer"] call GW_Gear_Fnc_Handler;

        //"_Position","_Side","_ShouldCreateTasks","_Exfil","_Variable","_ShouldUseVehicle"
		//Params ["_TaskId","_Group","_Building","_SelectedLeader","_ShouldCreateTasks","_ShouldUseVehicle","_Position","_Debug_Variable","_Exfil","_Variable","_Side"];
		//OKS_Escort_TaskAction = "OKS_ESCORT_ACTION";
		_Group setVariable [format["OKS_ESCORT_TASK"],false,true];


		/*
		_OKS_Escort_Action = [OKS_Escort_TaskAction,"Order Fallback","",OKS_Escort_Statement,{true},{},[OKS_Escort_TaskAction,_TaskId],{}] call ace_interact_menu_fnc_createAction;
		sleep 1;
		(str [_OKS_Escort_Action,_SelectedLeader]) remoteExec ["SystemChat",0];
		[_SelectedLeader, 0, ["ACE_MainActions"], _OKS_Escort_Action] remoteExec ["ace_interact_menu_fnc_addActionToObject",0];
		*/

		// When player is within 250 meters of Objective Group (Activates AI) or if all objective group members are dead (Objective Fails)
		waitUntil { sleep 5; {_X distance _Building < 250} count AllPlayers >= 1 || {Alive _X} count units _Group < 1};
		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks && isServer) exitWith {
				[_Task,"FAILED"] call BIS_fnc_taskSetState;
			};
		{_X setCaptive false; _X setCombatMode "RED"} foreach units _Group;

		// Add ACE Action
		OKS_Escort_Statement = {
			params["_Object","_Target","_id"];

			(Group _Object) setVariable ["OKS_ESCORT_TASK",true,true];
			_Object removeAction _id;
			//[_Object,0,["ACE_MainActions",_Action]] remoteExec ["ace_interact_menu_fnc_removeActionFromObject",0];
		};
		publicVariable "OKS_Escort_Statement";
		[_SelectedLeader,["<t color='#FFD200'>ORDER FALLBACK!</t>", OKS_Escort_Statement,[],6,true,true,"","_target distance _this < 6"]] remoteExec ["addAction",0];

		/// Wait until the OKS_Escort_Task_X is true or if all objective group members are dead.
		waitUntil {_Group GetVariable ["OKS_ESCORT_TASK",false] || {Alive _X} count units _Group < 1};
		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks && isServer) exitWith {
			[_Task,"FAILED"] call BIS_fnc_taskSetState;
		};

		OKS_EnableCode = {
			Params ["_Group","_Exfil","_Vehicle"];

			if(!isNull _Vehicle) then {
				_Group addVehicle _Vehicle;
				_Vehicle setUnloadInCombat [false, false];
				{_X setCombatMode "YELLOW"; _X disableAI "COVER"; _x disableAI "SUPPRESSION"; _X disableAI "AUTOCOMBAT"; _X setBehaviour "AWARE"; _X enableAttack false; _X disableAI "FSM"; _X enableAI "MOVE"; _X enableAI "PATH"; _X doMove _Exfil; _X setUnitPos "AUTO"; if(!isNull _Vehicle) then {[_X] orderGetIn true}} foreach units _Group;
			} else {
				{_X setCombatMode "YELLOW"; _X disableAI "COVER"; _x disableAI "SUPPRESSION"; _X disableAI "AUTOCOMBAT"; _X setBehaviour "AWARE"; _X enableAttack false; _X disableAI "FSM"; _X enableAI "MOVE"; _X enableAI "PATH"; _X doMove _Exfil; _X setUnitPos "AUTO";} foreach units _Group;
			};
		};
		PublicVariable "OKS_EnableCode";

		// Find Nearby Vehicles
		// That are empty, has enough space, and not player
		// Assign to Vehicle
		Private ["_Vehicle"];
		_Vehicles = _Position nearEntities [["LandVehicle"],100];

		_Vehicles = _Vehicles select {
			(count (crew _X)) == 0 && canMove _X &&
			(
			 (_X emptyPositions "driver") +
			 (_X emptyPositions "gunner") +
			 (_X emptyPositions "commander") +
			 (_X emptyPositions "cargo")
		    ) >= count units _Group;
		};
		if(count _Vehicles > 0) then {
			_Vehicle = selectRandom _Vehicles;
			SystemChat str _Vehicles;
		};

		if(!isNil "_Vehicle" && _ShouldUseVehicle) then {
			_Vehicle setVehicleLock "LOCKEDPLAYER";
			_null = [_Group,_Exfil,_Vehicle,_Debug_Variable] spawn {
				Params ["_Group","_Exfil","_Vehicle","_Debug_Variable"];
				while {{Alive _X} count units _Group > 0} do {
					if(_Debug_Variable) then { systemChat format["Group %1 - Exfil %2 - Vehicle %3 - Enabled AI",_Group,_Exfil,_Vehicle]};
					[_Group,_Exfil,_Vehicle] remoteExec ["OKS_EnableCode",0];
					sleep 20;
				}
			}
		} else {
			_null = [_Group,_Exfil,_Debug_Variable] spawn {
				Params ["_Group","_Exfil","_Debug_Variable"];
				while {{Alive _X} count units _Group > 0} do {
					if(_Debug_Variable) then { systemChat format["Group %1 - Exfil %2 - Vehicle N/A - Enabled AI",_Group,_Exfil]};
					[_Group,_Exfil,objNull] remoteExec ["OKS_EnableCode",0];
					sleep 20;
				}
			}
		};

		_wp = _Group addWaypoint [_Exfil, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed "FULL";

		[leader _Group,format["1-1 this is %1, we are relocating to our new position, out.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
		Private _Repetition = 0;
		waitUntil {sleep 2; if({speed _X isEqualTo 0} count units _Group == count units _Group) then { _Repetition = _Repetition + 1; if(_Debug_Variable) then { systemChat format["Repetition Vehicle: %1",_Repetition]};} else { _Repetition = 0; if(_Debug_Variable) then { systemChat format["Reset Vehicle Repetition: %1",_Repetition]}; }; ({(_X distance _Exfil < 45 && isNull (ObjectParent _X)) || (_X distance _Exfil < 25 && !isNull (ObjectParent _X)) || (!Alive _X)} count units _Group == count units _Group) || ({Alive _X} count units _Group < 1) || (_Repetition isEqualTo 20)};
		if({Alive _X} count units _Group < 1 && _ShouldCreateTasks) exitWith {
			[_Task,"FAILED"] call BIS_fnc_taskSetState;
		};
		if(_ShouldCreateTasks) then {
			[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
			Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
		};
		if(_Debug_Variable) then { systemChat "Exfil reached - Garrisoning"};
		[leader _Group,format["1-1 this is %1, we have reached our position, thanks for the assist, out.",(format["%1",[str _Group, 7] call BIS_fnc_trimString])]] remoteExec ["sideChat",0];
		_Types = [];
		(_Exfil nearObjects ["House", 10]) apply {_Types pushBackUnique (typeOf _X)};
		[_Exfil, _Types, units _Group, 5, 1, false, false] remoteExec ["ace_ai_fnc_garrison",0];
		_UnitArray = [];

		if(!isNil "_Vehicle") then {
			_Group leaveVehicle _Vehicle;
			_Vehicle setUnloadInCombat [true, true];
			_Gunner = gunner _Vehicle;
			if(!isNull _Gunner) then {
				[gunner _Vehicle] join grpNull;
				gunner _Vehicle assignAsGunner _Vehicle;
			};
		};
		_Repetition = 0;
		{UnassignVehicle _X; doGetOut _X; [_X] join grpNull; _UnitArray pushBackUnique _X; sleep (0.5 +(random 0.5))}foreach units _Group;

		waitUntil { sleep 2; if({speed _X isEqualTo 0} count _UnitArray == count _UnitArray) then { _Repetition = _Repetition + 1; if(_Debug_Variable) then { systemChat format["Repetition: %1",_Repetition]};} else { _Repetition = 0; if(_Debug_Variable) then { systemChat format["Reset Repetition: %1",_Repetition]}; }; _Repetition isEqualTo 5};
		if(_Debug_Variable) then { systemChat "Garrison Complete - Returning to Group"};

		_Group = CreateGroup _Side;
		{[_X] join _Group}foreach _UnitArray;
		{[_X,"PATH"] remoteExec ["disableAI",0]}foreach units _Group;
		_endmarker setMarkerAlpha 0;

		OKS_SetEscortMarker = {
			Params ["_marker","_Group","_GroupMarker","_SideMarker"];

			_marker setMarkerType _GroupMarker;
			_marker setMarkerColor _SideMarker;
			_marker setMarkerText format["%1",[str _Group, 7] call BIS_fnc_trimString];
			_marker setMarkerSize [0.7,0.7];
			_marker setMarkerAlpha 1;
			_marker setMarkerPos (getPos leader _Group);
		};
		_unitmarker = createMarker [format ["oks_escort_unitmarker_%1",str round(random 80000 + random 9999)],(getPos leader _Group), 0];
		_unitmarker setMarkerColor _sideMarker;
		[_unitmarker,_Group,_GroupMarker,_SideMarker] remoteExec ["OKS_SetEscortMarker",0];


