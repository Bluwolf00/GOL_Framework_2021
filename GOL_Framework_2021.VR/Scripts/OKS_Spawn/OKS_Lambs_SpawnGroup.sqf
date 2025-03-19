/*
	OKS_Lambs_SpawnGroup
	[SpawnPos,"rush",UnitsPerBase,Side,Range,[]] spawn OKS_Lambs_SpawnGroup;
	[SpawnPos,"creep",UnitsPerBase,Side,Range,[]] execVM "Scripts\OKS_Spawn\OKS_Lambs_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_SpawnPos","_LambsType",["_NumberInfantry",5,[0]],["_Side",east,[sideUnknown]],["_Range",1500,[0]],["_Array",[],[[]]]];
	private ["_RandomPos","_Center"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	_Group = CreateGroup _Side;
	_Group setVariable ["acex_headless_blacklist",true,true];
	for "_i" from 1 to (_NumberInfantry) do
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
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill"]; _Array pushBackUnique _X } foreach units _Group;
	Call Compile Format ["PublicVariable '%1'",_Array];

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

			{_X setUnitPos "DOWN"; _X setBehaviour "STEALTH"; _X setCombatMode "GREEN"; } foreach units _Group;
			waitUntil {sleep 5; {_X distance (leader _Group) < 150} count AllPlayers > 0};
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
			{_X setUnitPos "AUTO"; _X setBehaviour "AWARE"; _X setCombatMode "RED"; } foreach units _Group;
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

