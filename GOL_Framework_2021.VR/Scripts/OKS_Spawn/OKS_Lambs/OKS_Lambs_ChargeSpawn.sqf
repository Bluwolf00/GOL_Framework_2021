/*
	OKS_Lambs_Chargespawn
	[Spawnobject,UnitsPerWave,AmountOfWaves,Side,Range,"VariableNameSetTrueUponAllClear"] spawn OKS_Lambs_ChargeSpawn;
	[Spawnobject,UnitsPerWave,AmountOfWaves,Side,Range,"VariableNameSetTrueUponAllClear"] execVM "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_ChargeSpawn.sqf";

	[charge_1,5,2,east,1500,"ChargeSpawn1Destroyed"] spawn OKS_Lambs_ChargeSpawn;
	[charge_1,5,12,east,1500,"ChargeSpawn1Destroyed"] execVM "Scripts\OKS_Spawn\OKS_Lambs\OKS_Lambs_ChargeSpawn.sqf";
*/

 	if(!isServer) exitWith {};

	Params [
		"_SpawnPos",
		"_UnitsPerWave",
		"_AmountOfWaves",
		["_Side",east,[sideUnknown]],
		["_Range",1500,[-1]],
		["_Variable","Rush_WaveSpawn_Variable",[""]]
	];
	private ["_RandomPos","_Center","_AllSpawnedUnits","_UnitArray"];
	_AllSpawnedUnits = [];

Switch (_Side) do
{
	case BLUFOR:	// BLUFOR settings
	{
		// Unit classes are compatible with multiple class names, will select randomly. Example: ["B_Pilot_F","B_Crewman_F"];
		_Leaders = ["B_Soldier_SL_F","B_Soldier_TL_F"];	// Squad/Team leader classes.
		_Units = [
			"B_Soldier_LAT_F",
			"B_Soldier_AR_F",
			"B_Soldier_AR_F",
			"B_medic_F",
			"B_medic_F",
			"B_Soldier_GL_F",
			"B_HeavyGunner_F",
			"B_soldier_M_F"		
		]; // Class names for infantry units.
		_UnitArray = [_Leaders,_Units];
	};
	case OPFOR:		// OPFOR settings
	{
		_Leaders = ["O_Soldier_SL_F","O_Soldier_TL_F"];
		_Units = [
			"O_Soldier_LAT_F",
			"O_Soldier_AR_F",
			"O_Soldier_AR_F",
			"O_medic_F",
			"O_medic_F",
			"O_Soldier_GL_F",
			"O_HeavyGunner_F",
			"O_soldier_M_F"
		];
		_UnitArray = [_Leaders,_Units];
	};
	case INDEPENDENT:	// INDEPENDENT Settings
	{
		_Leaders = ["I_Soldier_SL_F","I_Soldier_TL_F"];
		_Units = [
			"I_Soldier_LAT_F",
			"I_Soldier_AR_F",
			"I_Soldier_AR_F",
			"I_medic_F",			
			"I_medic_F",
			"I_Soldier_GL_F",
			"I_soldier_M_F"	
		];
		_UnitArray = [_Leaders,_Units];
	};
};

	OKS_WaveSpawn_Code = {
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
			sleep 1;
		};

		{
			[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill"];
			_X allowFleeing 0;
			_X disableAI "FSM";
			_X enableAttack false;
			_AllSpawnedUnits pushBackUnique _X;
		} foreach units _Group;

		if(OKS_Suppression isEqualTo 1) then {
			{[_X] remoteExec ["OKS_Suppressed",0]} foreach units _group;
		};	


		sleep 5;
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
		[_Group,_Range,5,[],[],true] remoteExec ["lambs_wp_fnc_taskRush",0];	
	};

	for "_i" from 1 to _AmountOfWaves do {
		[_SpawnPos,_Side,_UnitsPerWave,_UnitArray,_AllSpawnedUnits,_Range] spawn OKS_WaveSpawn_Code;
		SystemChat format ["Wavespawn Current Count: %1",count _AllSpawnedUnits];
		sleep 2;
	};
	sleep 15;
	playSound3D [MISSION_ROOT + "Scripts\OKS_Spawn\OKS_Lambs\ChargeWarcry.ogg", _SpawnPos, false, getPosASL _SpawnPos, 2.5, 1, 1500];
	waitUntil { sleep 1; Call Compile Format ["%1 = false; PublicVariable '%1'",_Variable]; {Alive _X || [_X] call ace_common_fnc_isAwake} count _AllSpawnedUnits < 1};
	Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
	SystemChat "Rush Chargespawner Ended.";

