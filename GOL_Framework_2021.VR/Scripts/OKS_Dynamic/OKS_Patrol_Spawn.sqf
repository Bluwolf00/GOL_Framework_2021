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
			while {true} do {
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 10, 0, 35, 0] call BIS_fnc_findSafePos;
				if(_SpawnPos inArea _Area) exitWith {};
			};
		};

		_Group = CreateGroup _Side;
		for "_i" from 1 to (_NumberInfantry) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,0], [], 30, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,0], [], 30, "NONE"];
			};
			sleep 1;
		};
		_Group setBehaviour "SAFE";
		[_Group, _Spawnpos, _Range] call CBA_fnc_taskPatrol;
		{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
		if(_Side isEqualTo civilian) then {
			_Group setSpeedMode "LIMITED";
		};
		if(!isNil "OKS_Enemy_Talk") then {
			[_Group] execVM "Scripts\OKS_Ambience\OKS_Enemy_Talk.sqf";
		};

		waitUntil {sleep 10; count waypoints _Group > 0};
		[_Area,_Group,_Range] spawn OKS_Check_Waypoints;
