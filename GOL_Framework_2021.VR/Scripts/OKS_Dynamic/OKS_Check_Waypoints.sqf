	//	OKS_Check_Waypoints
	if(HasInterface && !isServer) exitWith {};

	Params["_Area","_Group","_Range"];
	Private ["_SafePos","_Debug_Variable","_Repetitions","_DeleteTriggers"];
	Private _Waypoints = waypoints _Group;
	_DeleteTriggers = [];
	_Debug_Variable = false;

	{
		if(surfaceIsWater (waypointPosition _X)) then {
			if(_Debug_Variable) then {
				SystemChat "Waypoint found in water.. moving";
			};
			_Repetitions = 0;
			while {true} do {
				sleep 0.2;
				_Repetitions = _Repetitions + 1;

				_SafePos = [(WaypointPosition _X), 1, (_Range * 3), 2, 0, 0.5, 0] call BIS_fnc_findSafePos;
				if(_Repetitions > 30) exitWith {};
				if(_Debug_Variable) then {
					SystemChat format ["CheckWaypoints: %1 - %2 in %3: %4",_Group,_SafePos,_Area,(_SafePos inArea _Area)];
				};
				if(_SafePos inArea _Area) exitWith { _X setWaypointPosition [_SafePos,0]; if(_Debug_Variable) then {SystemChat "Waypoint SafePos Found."}}
			};
			if(_Repetitions > 30) exitWith {  if(_Debug_Variable) then { _DeleteTriggers pushBackUnique _X; SystemChat "Faied to Find Waypoint. Adding to Delete."}};
		};
	} foreach _Waypoints;

	{deleteWaypoint _X} foreach _DeleteTriggers;
