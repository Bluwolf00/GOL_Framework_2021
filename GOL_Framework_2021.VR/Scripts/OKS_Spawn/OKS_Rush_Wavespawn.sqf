/*
	OKS_Rush_Wavespawn
	[SpawnPosOrPositionsInArray,UnitsPerWave,AmountOfWaves,DelayPerWave,Side,Range,"VariableNameSetTrueUponAllClear"] spawn OKS_Rush_Wavespawn;
	[SpawnPosOrPositionsInArray,UnitsPerWave,AmountOfWaves,DelayPerWave,Side,Range,"VariableNameSetTrueUponAllClear"] execVM "Scripts\OKS_Dynamic\OKS_Rush_Wavespawn.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_SpawnPos","_UnitsPerWave","_AmountOfWaves","_DelayPerWave","_Side","_Range","_Variable"];
	private ["_RandomPos","_Center","_AllSpawnedUnits"];
	_AllSpawnedUnits = [];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];

	OKS_RushWaveSpawn_Code = {
		Params ["_SpawnPos","_Side","_UnitsPerWave","_UnitArray","_AllSpawnedUnits","_Range"];

		_UnitArray Params ["_Leaders","_Units","_Officer"];
		_Group = CreateGroup _Side;
		_Group setVariable ["acex_headless_blacklist",true,true];
		for "_i" from 1 to (_UnitsPerWave) do
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
			sleep 0.5;
		};

		{
			[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill"];
			_AllSpawnedUnits pushBackUnique _X;
		} foreach units _Group;

		/* 
			Arguments:
			0: Group performing action, either unit <OBJECT> or group <GROUP>
			1: Range of tracking, default is 500 meters <NUMBER>
			2: Delay of cycle, default 15 seconds <NUMBER>
			3: Area the AI Camps in, default [] <ARRAY>
			4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
			5: Only Players, default true <BOOL>
		*/
		sleep 10;
		waitUntil {sleep 1; !isNil "lambs_wp_fnc_moduleRush"};
		[_Group,_Range,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];	
	};	

	for "_i" from 1 to _AmountOfWaves do {
		if(typeName _SpawnPos == "ARRAY") then {
			if(typeName (_SpawnPos select 0) == "SCALAR") then {
				[_SpawnPos,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range] spawn OKS_RushWaveSpawn_Code;
			} else {
				{
					[_X,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range] spawn OKS_RushWaveSpawn_Code;				
				} forEach _SpawnPos;
			};
		} else {
			[getPos _SpawnPos,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range] spawn OKS_RushWaveSpawn_Code;
		};
		
		sleep _DelayPerWave;
		SystemChat format ["Wavespawn Current Count: %1",count _AllSpawnedUnits];
	};

	waitUntil { sleep 5; {Alive _X || [_X] call ace_common_fnc_isAwake} count _AllSpawnedUnits < 1};
	Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
	SystemChat "Rush Wavespawner Ended.";

