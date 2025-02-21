/*

	Param 1: Spawn Position for Aircraft (Helicopters, Planes, UAVs)
	Param 2: Target Position for Waypoint
	Param 3: Side of Aircraft
	Param 4: Aircraft Classname
	Param 5: [Waypoint Type,ShouldBeCareless]
	Param 6: [Spotting Distance,Spotting Value (0-1)]
	Param 7: [Waypoint Altitude,LoiterDistance]
	Param 8: Should call in Mortars when spotting players

	[
		getPos drone_1,
		getPos droneTarget_1,
		east,
		"rhs_pchela1t_vvs",
		["LOITER",false],		
		[500,4],
		[250,500],
		true
	] spawn OKS_Scout;

	[
		getPos drone_1,
		getPos droneTarget_1,
		east,		
		"rhs_pchela1t_vvs",
		["LOITER",false],
		[500,4],
		[250,500],
		["","","","","","",""],
		true
	] execVM "Scripts\OKS_Spawn\OKS_Scout.sqf";	

*/



	if(HasInterface && !isServer) exitWith {};

	Params [
		"_SpawnPosition",
		"_TargetArea",		
		["_Side",east,[sideUnknown]],
		["_Classname","rhs_pchela1t_vvs",[""]],
		["_BehaviourArray",["LOITER",true],[]],
		["_SpottingArray",[500,4],[]],
		["_FlyingArray",[250,500],[]],
		["_Loadout",nil,[[]]],
		["_ShouldCallMortars",true,[false]]
	];

	_SpottingArray Params ["_SpottingRange","_SpottingValue"];
	_FlyingArray Params ["_Altitude","_LoiterDistance"];

	_Aircraft = createVehicle [_Classname, _SpawnPosition, [], 0, "FLY"];
	_Aircraft setPos [_SpawnPosition select 0,_SpawnPosition select 1,_Altitude];
	_Aircraft setDir (_Aircraft getDir _TargetArea);

	
	_Crew = _Side createVehicleCrew _Aircraft;
	
	_WP = _Crew addWaypoint [_TargetArea,200];
	_WP setWaypointType _WAYPOINT;

	if(_CARELESS) then {
		_WP setWaypointCombatMode "BLUE";
		_WP setWaypointBehaviour "CARELESS";
	} else {
		_WP setWaypointCombatMode "YELLOW";
		_WP setWaypointBehaviour "AWARE";		
	};
	_WP setWaypointLoiterAltitude _Altitude;
	_WP setWaypointLoiterRadius _LoiterDistance;


	if(!isNil "_Loadout") then {
		_i = 1;
		{
			_Aircraft setPylonLoadout [_i, _X];
			_i = _i + 1;
		} foreach _Loadout;
	};

	while {alive _Aircraft && {Alive _X} count crew _Aircraft >= 1} do {
		_NearPlayers = AllPlayers select {
			_X distance _Aircraft < _SpottingRange &&
			[objNull, "VIEW"] checkVisibility [getPosASL _Aircraft, getPosASL _X] >= 0.3
		};
		systemChat str [_NearPlayers,([objNull, "VIEW"] checkVisibility [getPosASL _Aircraft, getPosASL player])];
		{
			_requiredValueForSpotting = 0.5;
			_nearConcealment = count (nearestTerrainObjects [_X, [], 10]);
			if(stance _X == "PRONE" && _nearConcealment >= 1) then {
				systemChat "Player is prone and near concealment. Required value is 0.65";
				_requiredValueForSpotting = 0.65;
			} else {
				systemChat "Player isn't prone. Required value is 0.5";
			};

			if([objNull, "VIEW"] checkVisibility [getPosASL _Aircraft, getPosASL _X] >= _requiredValueForSpotting) then {
				_crew reveal [_X,_SpottingValue];
				(leader _crew) doTarget _X;
				_WP setWaypointPosition getPos _X;
				_WP setWaypointLoiterRadius (_LoiterDistance * 0.5);
				systemChat format ["%1 was revealed (%2) by %3.",name _X,_SpottingValue,[configFile >> "CfgVehicles" >> typeOf _Aircraft] call BIS_fnc_displayName];
			};		
		} foreach _NearPlayers;

		if(count _NearPlayers > 0) then {
			if(!(missionNamespace getVariable ["Active_UAV_Mortar",false])) then {
				_targetPlayer = (selectRandom _NearPlayers);
				systemChat format ["%1 was targeted by mortar.",name _targetPlayer];
				missionNamespace setVariable ["Active_UAV_Mortar",true,true];
				["OffMap", _Side, "Precise", "light", [getPos _targetPlayer, 5]] execVM "Scripts\NEKY_Mortars\NEKY_Mortars.sqf";
			};
		};
		sleep 2;
	};