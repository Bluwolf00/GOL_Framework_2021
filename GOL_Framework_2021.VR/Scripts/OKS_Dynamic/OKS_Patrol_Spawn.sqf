/*
	OKS_Patrol_Spawn
	[Trigger,5,200,EAST,["O_Soldier_F"]] execVM "Scripts\OKS_Dynamic\OKS_Patrol_Spawn.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Area","_NumberInfantry","_Range","_Side"];
	private ["_Spawnpos","_RandomPos"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];

	if(typeName _Area == "ARRAY") then {
		_SpawnPos = _Area;
		_Area = createTrigger ["EmptyDetector", _SpawnPos, true];
		_Area setTriggerArea [_Range,_Range,0,false,20];
	} else {
		private _iteration = 20;
		while {_iteration > 0} do {
			_RandomPos = _Area call BIS_fnc_randomPosTrigger;
			_SpawnPos = [_RandomPos, 1, 100, 20, 0, 35, 0] call BIS_fnc_findSafePos;
			_NoPatrolsNearby = (_SpawnPos nearEntities ["Man",_Range]) select {_X getVariable ["OKS_Patrol_Unit", false] == true};
			_iteration = _iteration - 1;
			if(_SpawnPos inArea _Area && (count _NoPatrolsNearby) == 0) exitWith {};
		};
	};

	_Group = CreateGroup _Side;
	for "_i" from 1 to (_NumberInfantry) do
	{
		Private "_Unit";
		if ( (count (units _Group)) == 0 ) then
		{
			_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,0], [], 3, "NONE"];
			_Unit setRank "SERGEANT";
			_Unit setVariable ["OKS_Patrol_Unit",true,true];
		} else {
			if(count (units _Group) == 1) then {
				_Unit = _Group CreateUnit [(_Units select 0), [_SpawnPos select 0,_SpawnPos select 1,0], [], 3, "NONE"];
				_Unit setVariable ["OKS_Patrol_Unit",true,true];
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,0], [], 3, "NONE"];
				_Unit setVariable ["OKS_Patrol_Unit",true,true];
			}				
		};
		sleep 1;
	};
	_Group setBehaviour "SAFE";

	if(OKS_Suppression isEqualTo 1) then {
		{[_X] remoteExec ["OKS_Suppressed",0]} foreach units _Group;
	};		

	if(isNil "lambs_wp_fnc_taskPatrol") then {
		[_Group, _Spawnpos, _Range] call CBA_fnc_taskPatrol;
	} else {
		/*
			* Arguments:
			* 0: Group performing action, either unit <OBJECT> or group <GROUP>
			* 1: Position being searched, default group position <OBJECT or ARRAY>
			* 2: Range of tracking, default is 200 meters <NUMBER>
			* 3: Waypoint Count, default 4  <NUMBER>
			* 4: Area the AI Camps in, default [] <ARRAY>
			* 5: Dynamic patrol pattern, default false <BOOL>
			* 6: enable dynamic reinforcement <BOOL>
		*/
		[_Group, _SpawnPos, _Range,5,[],true,true] call lambs_wp_fnc_taskPatrol;	
	};
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(_Side isEqualTo civilian) then {
		_Group setSpeedMode "LIMITED";
	};
	if(!isNil "OKS_Enemy_Talk") then {
		[_Group] spawn OKS_Enemy_Talk;
	};

	if(isNil "lambs_wp_fnc_taskPatrol") then {
		waitUntil {sleep 10; count waypoints _Group > 0};
		[_Area,_Group,_Range] spawn OKS_Check_Waypoints;
	};

	if(!isNil "OKS_Tracker" && GOL_OKS_Tracker isEqualTo 1) then {
		[_Group] remoteExec ["OKS_Tracker",2];
	};
	
