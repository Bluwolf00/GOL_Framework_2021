/*
	OKS_Lambs_Wavespawn
	[SpawnPosOrPositionsInArray,UnitsPerWave,AmountOfWaves,DelayPerWave,TypeOfWP,Side,Range,"VariableNameSetTrueUponAllClear"] spawn OKS_Lambs_Wavespawn;
	[SpawnPosOrPositionsInArray,UnitsPerWave,AmountOfWaves,DelayPerWave,TypeOfWP,Side,Range,"VariableNameSetTrueUponAllClear"] execVM "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_Wavespawn.sqf";

	[[getPos spawn_1,getPos spawn_2],5,2,120,"hunt",east,1500,"WaveSpawn1Destroyed"] spawn OKS_Lambs_Wavespawn;
*/

 	if(!isServer) exitWith {};

	Params [
		"_SpawnPos",
		"_UnitsPerWave",
		"_AmountOfWaves",
		"_DelayPerWave",
		["_LambsType","rush",[""]],
		["_Side",east,[sideUnknown]],
		["_Range",1500,[-1]],
		["_Variable","Rush_WaveSpawn_Variable",[""]]
	];
	private ["_RandomPos","_Center","_AllSpawnedUnits"];
	_AllSpawnedUnits = [];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];

	OKS_WaveSpawn_Code = {
		Params ["_SpawnPos","_Side","_UnitsPerWave","_UnitArray","_AllSpawnedUnits","_Range","_LambsType"];

		_UnitArray Params ["_Leaders","_Units","_Officer"];
		_Group = CreateGroup _Side;
		_Group setVariable ["acex_headless_blacklist",true,true];
		for "_i" from 1 to round(_UnitsPerWave * OKS_ForceMultiplier) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SpawnPos getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				if(count (units _Group) == 1) then {
					_Unit = _Group CreateUnit [(_Units select 0), _SpawnPos getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
				} else {
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _SpawnPos getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
				};			
				_Unit setRank "PRIVATE";
			};
			sleep 1;
		};

		{
			[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill"];
			_AllSpawnedUnits pushBackUnique _X;
		} foreach units _Group;

		if(OKS_Suppression isEqualTo 1) then {
			{[_X] remoteExec ["OKS_Suppressed",0]} foreach units _group;
		};	


		sleep 5;
		switch (toLower _LambsType) do {
			case "hunt": {
				/* 
					* Arguments:
					* 0: Group performing action, either unit <OBJECT> or group <GROUP>
					* 1: Range of tracking, default is 500 meters <NUMBER>
					* 2: Delay of cycle, default 15 seconds <NUMBER>
					* 3: Area the AI Camps in, default [] <ARRAY>
					* 4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
					* 5: Only Players, default true <BOOL>
					* 6: enable dynamic reinforcement <BOOL>
					* 7: Enable Flare <BOOL> or <NUMBER> where 0 disabled, 1 enabled (if Units cant fire it them self a flare is created via createVehicle), 2 Only if Units can Fire UGL them self
				*/	
				waitUntil {sleep 1; !(isNil "lambs_wp_fnc_taskHunt")};
				[_Group, _Range, 30, [], [], true,false,false] remoteExec ["lambs_wp_fnc_taskHunt",0];
			};
			case "creep":{
				/* 
					* Arguments:
					* 0: Group performing action, either unit <OBJECT> or group <GROUP>
					* 1: Range of tracking, default is 500 meters <NUMBER>
					* 2: Delay of cycle, default 15 seconds <NUMBER>
					* 3: Area the AI Camps in, default [] <ARRAY>
					* 4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
					* 5: Only Players, default true <BOOL>
				*/
				waitUntil {sleep 1; !(isNil "lambs_wp_fnc_taskCreep")};
				[_Group, _Range, 30, [], [], true] remoteExec ["lambs_wp_fnc_taskCreep",0];
			};
			default {
				/* 
					Arguments:
					0: Group performing action, either unit <OBJECT> or group <GROUP>
					1: Range of tracking, default is 500 meters <NUMBER>
					2: Delay of cycle, default 15 seconds <NUMBER>
					3: Area the AI Camps in, default [] <ARRAY>
					4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
					5: Only Players, default true <BOOL>
				*/			
				waitUntil {sleep 1; !isNil "lambs_wp_fnc_moduleRush"};
				[_Group,_Range,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];	
			};
		};
	};	

	for "_i" from 1 to _AmountOfWaves do {
		if(typeName _SpawnPos == "ARRAY") then {
			if(typeName (_SpawnPos select 0) == "SCALAR") then {
				[_SpawnPos,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range,_LambsType] spawn OKS_WaveSpawn_Code;
			} else {
				{
					[_X,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range,_LambsType] spawn OKS_WaveSpawn_Code;				
				} forEach _SpawnPos;
			};
		} else {
			[getPos _SpawnPos,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range,_LambsType] spawn OKS_WaveSpawn_Code;
		};
		
		if(_i != _AmountOfWaves) then {
			sleep (_DelayPerWave * OKS_ResponseMultiplier);
		};	
		SystemChat format ["Wavespawn Current Count: %1",count _AllSpawnedUnits];
	};

	waitUntil { sleep 5; {Alive _X || [_X] call ace_common_fnc_isAwake} count _AllSpawnedUnits < 1};
	Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
	SystemChat "Rush Wavespawner Ended.";

