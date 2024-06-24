/*
	OKS_Attack_SpawnGroup
	[SpawnPosOrObject,HuntTrigger,"",5,Side,Range] spawn OKS_Mechanized_Spawn;
	[SpawnPosOrObject,HuntTrigger,"",5,Side,Range] execVM "Scripts\OKS_Spawn\OKS_Mechanized_Spawn.sqf";
*/

 	if(!isServer) exitWith {};

	Params [
		["_Spawn",objNull,[objNull,[]]],
		["_HuntTrigger",objNull,[objNull]],
		["_VehicleType","",[[],""]],
		["_InfantryNumber",5,[0]],
		["_Side",east,[sideUnknown]],
		["_Range",2000,[0]]
	];
	Private ["_Dir"];
	
	if(typeName _Spawn == "OBJECT") then {
		_Dir = getDir _Spawn;
		_Spawn = getPos _Spawn;
	} else {
		_Dir = random 360;
	};

	Private ["_Group","_Vehicle"];
	if(typeName _VehicleType == "STRING") then {
		_Vehicle = CreateVehicle [_VehicleType,_Spawn];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};	
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side,0,_InfantryNumber] call OKS_AddVehicleCrew;

		[_Vehicle] spawn OKS_ForceVehicleSpeed;  
	};
	if(typeName _VehicleType == "ARRAY") then {
		_VehicleType = selectRandom _VehicleType;
		_Vehicle = CreateVehicle [_Classname,_Spawn];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};	
		_Vehicle setDir _Dir;
		_Group = [_Vehicle,_Side,0,_InfantryNumber] call OKS_AddVehicleCrew;

		[_Vehicle] spawn OKS_ForceVehicleSpeed;  
	};
	sleep 1;
	{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
	if(isNil "_Group") exitWith {false};

	_Vehicle lock true;

	_CrewGroup = createGroup _side;
	_InfantryGroup = createGroup _side;
	_Infantry = (units _Group) select {gunner _vehicle != _X || driver _vehicle != _X  || commander _vehicle != _X};
	_Crew = (units _Group) select {gunner _vehicle == _X || driver _vehicle == _X  || commander _vehicle == _X};

	systemChat str _Infantry;
	systemChat str _Crew;

	_Infantry join grpNull;
	_Infantry join _InfantryGroup;
	_Crew join grpNull;
	_Crew join _CrewGroup;
	
	waitUntil {sleep 1; !isNil "lambs_wp_fnc_moduleRush"};
	[_CrewGroup, nil, _HuntTrigger, 0, 30] spawn NEKY_Hunt_Run;

	waitUntil {sleep 1; {behaviour _X == "COMBAT"} count units _CrewGroup > 0 || {behaviour _X == "COMBAT"} count units _InfantryGroup > 0};
	_CrewGroup setVariable ["Disable_Hunt",true,true];
	_CrewGroup setVariable ["NEKY_Hunt_GroupEnabled",true,true];

	for "_i" from count waypoints _CrewGroup - 1 to 0 step -1 do
	{
		deleteWaypoint [_CrewGroup, _i];
	};		

	_Vehicle lock false;
	_Vehicle forceSpeed 0;
	_InfantryGroup leaveVehicle _Vehicle;
	{
		unassignVehicle _X;	
	} foreach units _InfantryGroup;

	waitUntil {sleep 1; count (fullCrew [_Vehicle, "cargo", false]) == 0};
	[_InfantryGroup,_Range,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];
	sleep 10;
	_Vehicle lock true;
	[_Vehicle] spawn OKS_ForceVehicleSpeed;  

	
	_FollowSquad = {
		params ["_VehicleCrew","_InfantryScreen","_Vehicle"];
		Private ["_WP"];
		while { {Alive _X} count units _VehicleCrew > 0 && canMove _Vehicle && {Alive _X} count units _InfantryScreen > 0} do {
			
			if({_X distance _Vehicle < 50} count units _InfantryScreen == 0) then {
				_WP = _VehicleCrew addWaypoint [getPos (leader _InfantryScreen),10];
				_WP setWaypointType "HOLD";
			};
			
			if(!isNil "_WP") then {
				waitUntil { sleep 2; {_X distance (waypointPosition _WP) < 50} count units _InfantryScreen == 0};
				deleteWaypoint _WP;
			} else {
				sleep 5;
			};	
		};

	};

	[_CrewGroup,_InfantryGroup,_Vehicle] spawn _FollowSquad;