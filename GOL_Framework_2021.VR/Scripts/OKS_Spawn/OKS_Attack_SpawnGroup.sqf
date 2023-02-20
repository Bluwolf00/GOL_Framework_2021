/*
	OKS_Attack_SpawnGroup
	[SpawnPosOrObject,TargetPosOrObject,UnitOrClassname,Side,ShouldAddStepWaypoint] spawn OKS_Attack_SpawnGroup;
	[SpawnPosOrObject,TargetPosOrObject,UnitOrClassname,Side,ShouldAddStepWaypoint] execVM "Scripts\OKS_Dynamic\OKS_Attack_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Spawn","_TargetWaypoint","_ClassnameOrNumber","_Side","_StepWaypoint"];
	Private ["_Dir"];
	
	if(isNil "_StepWaypoint") then {
		_StepWaypoint = false;
	};
	if(typeName _Spawn == "OBJECT") then {
		_Dir = getDir _Spawn;
		_Spawn = getPos _Spawn;
	} else {
		_Dir = random 360;
	};
	if(typeName _TargetWaypoint == "OBJECT") then {
		_TargetWaypoint = getPos _TargetWaypoint;
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
	
	/// Give Attack SAD Waypoint
	if(_StepWaypoint) then {
		_PreWaypointPos = _TargetWaypoint getPos [((_Spawn distance _TargetWaypoint) / 2), _TargetWaypoint getDir _Spawn];
		_WP1 = _Group addWaypoint [_PreWaypointPos,25];
		_WP1 setWaypointType "MOVE";
	};

	_WP2 = _Group addWaypoint [_TargetWaypoint,25];
	_WP2 setWaypointType "SAD";

