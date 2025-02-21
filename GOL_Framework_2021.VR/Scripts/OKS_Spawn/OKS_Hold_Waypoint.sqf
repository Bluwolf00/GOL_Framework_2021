/*
	OKS_Hold_Waypoint
	[SpawnPosOrObject,ArrayOrObject,UnitOrClassname,Side] spawn OKS_Hold_Waypoint;
	[SpawnPosOrObject,ArrayOrObject,UnitOrClassname,Side] execVM "Scripts\OKS_Spawn\OKS_Hold_Waypoint.sqf";
*/

 	if(!isServer) exitWith {};

	Params [
		["_Spawn",objNull,[objNull,[]]],
		["_TargetWaypoint",objNull,[[],objNull]],
		["_ClassnameOrNumber",5,[0,""]],
		["_Side",east,[sideUnknown]]
	];
	Private ["_Dir"];
	
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
		if(OKS_Suppression isEqualTo 1) then {
			{[_X] remoteExec ["OKS_Suppressed",0]} foreach units _group;
		};	
	};
	if(typeName _ClassnameOrNumber == "STRING") then {
		_Vehicle = CreateVehicle [_ClassnameOrNumber,_Spawn];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};	
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

		[_Vehicle] spawn OKS_ForceVehicleSpeed;  
	};
	if(typeName _ClassnameOrNumber == "ARRAY") then {
		_ClassnameOrNumber = selectRandom _ClassnameOrNumber;
		_Vehicle = CreateVehicle [_Classname,_Spawn];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};	
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

		[_Vehicle] spawn OKS_ForceVehicleSpeed;  
	};
	sleep 1;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(isNil "_Group") exitWith {false};
	
	_WP = _Group addWaypoint [_TargetWaypoint,0];
	_WP setWaypointType "HOLD";
	_WP setWaypointBehaviour "SAFE";
	_WP setWaypointCombatMode "RED";	




