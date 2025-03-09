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
		["","","","","","",""],
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
	_BehaviourArray Params ["_WaypointType","_Careless"];

	_SafeZones = ["flag_west_1","flag_west_2","flag_east_1","flag_east_2"];
	_ActiveSafeZones = [];
	{
		if(!isNil _X) then {
			_SafeZone = missionNamespace getVariable [_X , objNull]; // Get the object variable

			if(!isNull _SafeZone) then {
				_ActiveSafeZones pushbackUnique _SafeZone;
			}
		}
	} foreach _SafeZones;

	_Aircraft = createVehicle [_Classname, _SpawnPosition, [], 0, "FLY"];
	_Aircraft setPos [_SpawnPosition select 0,_SpawnPosition select 1,_Altitude + 100];
	_Aircraft setDir (_Aircraft getDir _TargetArea);

	
	_Crew = _Side createVehicleCrew _Aircraft;
	
	_WP = _Crew addWaypoint [_TargetArea,200];
	_WP setWaypointType _WaypointType;

	if(_Careless) then {
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
			_Player = _X;
			_Player distance _Aircraft < _SpottingRange &&
			[objNull, "VIEW"] checkVisibility [getPosASL _Aircraft, (getPosASL vehicle _Player)] >= 0.3 &&
			{_Player distance _X > 500} count _ActiveSafeZones == count _ActiveSafeZones
		};
		if(count _NearPlayers > 0) then {
			systemChat format["Scout Spotted Value: %1",_NearPlayers];
		};
		{
			_requiredValueForSpotting = 0.5;
			_ValueSpotted = [objNull, "VIEW"] checkVisibility [getPosASL _Aircraft, (getPosASL vehicle _X)];
			_nearConcealment = count (nearestTerrainObjects [_X, [], 10]);
			if(stance _X == "PRONE" && _nearConcealment >= 1) then {
				systemChat "Player is prone and near concealment. Required value is 0.65";
				_requiredValueForSpotting = 0.65;
			} else {
				systemChat "Player isn't prone. Required value is 0.5";
			};
			
			if(_ValueSpotted >= _requiredValueForSpotting) then {
				_crew reveal [_X,_SpottingValue];
				(leader _crew) doTarget _X;
				_WP setWaypointPosition [getPos _X,0];
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

			if(!(_Careless)) then {
				_WP setWaypointPosition [getPos _targetPlayer,0];
				_WP setWaypointType "SAD";
				systemChat format ["%1 was spotted (%2) by %3. Not careless - Adding SAD waypoint.",name _X,_ValueSpotted,[configFile >> "CfgVehicles" >> typeOf _Aircraft] call BIS_fnc_displayName];
			};
		};
		sleep 2;
	};