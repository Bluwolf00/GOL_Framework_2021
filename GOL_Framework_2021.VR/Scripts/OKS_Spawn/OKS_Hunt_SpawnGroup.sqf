/*
	OKS_Hunt_SpawnGroup
	[Spawn,nil,UnitOrClassname,Side,Range] spawn OKS_Hunt_SpawnGroup;
	[Spawn,nil,UnitOrClassname,Side,Range] execVM "Scripts\OKS_Dynamic\OKS_Hunt_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Spawn","_Dir","_ClassnameOrNumber","_Side","_Range"];
	if(typeName _Spawn == "OBJECT") then {
		_Dir = getDir _Spawn;
		_Spawn = getPos _Spawn;
	};
	Private ["_Group"];
	waitUntil {sleep 1; !isNil "OKS_Dynamic_Setting"};
	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_Trigger"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	
	if(typeName _ClassnameOrNumber == "SCALAR") then {
		_Group = CreateGroup _Side;
		for "_i" from 1 to (_ClassnameOrNumber) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Spawn getPos [5,(random 360)], [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Spawn getPos [5,(random 360)], [], 0, "NONE"];
				_Unit setRank "PRIVATE";
			};
			sleep 0.5;
		};
	};
	if(typeName _ClassnameOrNumber == "STRING") then {
		_Vehicle = CreateVehicle [_ClassnameOrNumber,_Spawn];
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
	};
	if(typeName _ClassnameOrNumber == "ARRAY") then {
		_ClassnameOrNumber = selectRandom _ClassnameOrNumber;
		_Vehicle = CreateVehicle [_Classname,_Spawn];
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
	};
	sleep 1;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(isNil "_Group") exitWith {false};
	waitUntil {sleep 5; !(isNil "lambs_wp_fnc_taskHunt")};
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
	[_Group, _Range, 30, [], [], true,true,true] spawn lambs_wp_fnc_taskHunt;

