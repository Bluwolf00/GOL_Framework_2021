	//	OKS_Vehicle_Waypoints
	if(HasInterface && !isServer) exitWith {};

	Params["_Area","_Group","_NumberOfWaypoints"];
	Private ["_Road","_WP","_WPCount","_LastWP"];
	Private _Waypoints = [];
	For [{_i = 0}, {_i < _NumberOfWaypoints}, {_i = _i + 1}] do {
		_Waypoints append [_i];
	};

	{
		private _Repetitions = 0;
		while {true} do {
			_Repetitions = _Repetitions + 1;
			_Location = _Area call BIS_fnc_randomPosTrigger;
			_Roads = _Location nearRoads 800;
			_Roads = _Roads select {GetRoadInfo _X select 0 != "TRAIL"};
			_Road = selectRandom _Roads;

			if(!isNil "_Road") then { if (!((getRoadInfo _Road select 0) isEqualTo "TRAIL")) then {Break}};
			if(_Repetitions >= 30) then {_Road = [_Location, 800] call BIS_fnc_nearestRoad; Break};
		};
		//_Location = _Area call BIS_fnc_randomPosTrigger;
		//systemChat str _Location;
		//_Road = [(_Area call BIS_fnc_randomPosTrigger), 800] call BIS_fnc_nearestRoad;
		//systemChat str GetPos _Road;
		sleep 5;
		//_Road = [_nearRoads,[],{_Area distance _x},"ASCEND"] call BIS_fnc_sortBy;
		//SystemChat str [_Road,_Road select 0];

		If(isNil "_Road" || isNull _Road) then {
			_Road = _Location;
			SystemChat "Could not find road, using Location";
		};
		_WP = _Group addWaypoint [_Road, 0];
		_WP setWaypointCompletionRadius 50;
		_WP setWaypointSpeed "LIMITED";
		_WP setWaypointBehaviour "SAFE";
		_WP setWaypointType "MOVE";

	} foreach _Waypoints;

	_WPCount = count waypoints _Group;
	[_Group,(_WPCount - 1)] setWaypointType "CYCLE";




