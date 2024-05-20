/*
	OKS_PlayerWaypoint_SpawnGroup
	[Spawn,UnitOrClassname,Side,Range,nil,CargoSlotsOptionalForVehicle,true] spawn OKS_PlayerWaypoint_SpawnGroup;
	[Spawn,UnitOrClassname,Side,nil,Range,0,true] execVM "Scripts\OKS_Spawn\OKS_PlayerWaypoint_SpawnGroup.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Spawn","_ClassnameOrNumber","_Side","_Range","_Dir",["_CargoSlots",0,[0]],["_AttackInStraightLine",false,[false]]];
	if(typeName _Spawn == "OBJECT") then {
		_Dir = getDir _Spawn;
		_Spawn = getPos _Spawn;
	};
	Private ["_Group","_Vehicle","_Target"];

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
				if(count (units _Group) == 1) then {
					_Unit = _Group CreateUnit [(_Units select 0), _Spawn getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
				} else {
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Spawn getPos [(5+(random 5)),(random 360)], [], 0, "NONE"];
				};		
				_Unit setRank "PRIVATE";
			};
		};
	};
	if(typeName _ClassnameOrNumber == "STRING") then {
		_Vehicle = CreateVehicle [_ClassnameOrNumber,_Spawn];
		
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};			
		_Vehicle setDir _Dir;

		if(_CargoSlots > 0) then {
			_Group = [_Vehicle,_Side,0,_CargoSlots] call OKS_AddVehicleCrew;
		} else {
			_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
		};
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
		
		[_Vehicle] spawn OKS_ForceVehicleSpeed;  
	};
	if(typeName _ClassnameOrNumber == "ARRAY") then {
		_Classname = selectRandom _ClassnameOrNumber;
		_Vehicle = CreateVehicle [_Classname,_Spawn];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};			
		_Vehicle setDir _Dir;
		if(_CargoSlots > 0) then {
			_Group = [_Vehicle,_Side,0,_CargoSlots] call OKS_AddVehicleCrew;
		} else {
			_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;
		};
	};
	sleep 1;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(isNil "_Group") exitWith {false};
	_NearestPlayers = [allPlayers, [], {_x distance (Leader _Group)}, "ASCEND"] call BIS_fnc_sortBy;
	_NearestPlayers select {Alive _X && isTouchingGround _X};
	if(Count _NearestPlayers > 0) then {
		_Target = _NearestPlayers select 0;
	} else {
		[_Group,_Range,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];	
	};

	if(_AttackInStraightLine) then {

		_DistanceToTarget = (Leader _Group) distance _Target;
		_SplitDistance = _DistanceToTarget / 3;

		_SplitWp1 = _Group addWaypoint [_Target getPos [(_SplitDistance * 2),(((Leader _Group) getDir _Target) - 180)], 25];
		_SplitWp1 setWaypointType "MOVE";

		_SplitWp2 = _Group addWaypoint [_Target getPos [_SplitDistance,(((Leader _Group) getDir _Target) - 180)], 25];
		_SplitWp2 setWaypointType "MOVE";
	};

	_Waypoint = _Group addWaypoint [getPos _Target, 25];
	_Waypoint setWaypointType "SAD";

	sleep 5;
	[_Group,"AWARE"] remoteExec ["setBehaviour",0];
	[_Group,"FULL"] remoteExec ["setSpeedMode",0];
	if(typeName _ClassnameOrNumber == "ARRAY" || typeName _ClassnameOrNumber == "STRING") then {
		[_Group,"SAFE"] remoteExec ["setBehaviour",0];
		[_Vehicle,20] remoteExec ["limitSpeed",0];
	};

	_Group;

