	// OKS_Destroy_Barricade
	// [[barricade_1,barricade_2]] spawn OKS_Destroy_Barricade;
	// [[barricade_1,barricade_2]] execVM "Scripts\OKS_Task\OKS_Destroy_Barricade.sqf";
	if(HasInterface && !isServer) exitWith {};

	Params ["_Barricades"];
	Private ["_startmarker","_Position"];
	Private _Debug_Variable = false;

	_BarricadeReference = selectRandom _Barricades;
	_Position = getPos _BarricadeReference;

	if(count _Barricades > 1) then {
		_Remaining = _Barricades select {_X != _BarricadeReference};
		_TargetReference = selectRandom _Remaining;
		_Distance = ((_BarricadeReference distance _TargetReference) / 2);
		_Dir = _TargetReference getDir _BarricadeReference;

		SystemChat str [_Position,_Barricades,_Remaining,_BarricadeReference,_TargetReference,_Distance,_Dir];
		_Position = _TargetReference getPos [_Distance,_Dir];
		SystemChat str _Position;
	};

	_startmarker = createMarker [format ["oks_barricade_marker_%1",str round(random 80000 + random 9999)],_Position, 0];
	_startmarker setMarkerType "Contact_dashedLine2";
	_startmarker setMarkerColor "colorBlack";
	_startmarker setMarkerSize [2,2];
	_startmarker setMarkerAlpha 1;
	_startmarker setMarkerShape "ICON";
	_startMarker setMarkerDir (getDir _BarricadeReference);

		_Task = format["OKS_BARRICADETASK_%1",(round(random 99999))];
		Private _SubTasks = [];
		// Create Main Task
		[true, [_Task], [format["We have reports of a <font color='#84e4ff'><marker name = '%1'>obstacles</marker></font color> in our area of operations. We need to clear a path for our logistics, remove the obstacles.",_startmarker], "Destroy Obstacle", "Obstacle"], _Position,"CREATED",-1, false,"destroy", false] call BIS_fnc_taskCreate;

		waitUntil {sleep 10; {!Alive _X || getDammage _X > 0.8} count _Barricades isEqualTo count _Barricades};
		[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;


