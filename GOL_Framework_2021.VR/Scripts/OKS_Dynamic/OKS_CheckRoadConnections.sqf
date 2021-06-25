/*
	[RoadObject] execVM "OKS_CheckRoadConnections.sqf";
	[RoadObject] spawn OKS_CheckRoadConnections;
*/
Params ["_Road"];
Private ["_Roads","_FirstPairRoads","_SecondPairRoads","_ThirdPairRoads","_FourthPairRoads","_FifthPairRoads"];

	_Roads = [];
	_SecondPairRoads = [];
	_ThirdPairRoads = [];
	_FourthPairRoads = [];
	_FifthPairRoads = [];
	_SixthPairRoads = [];

	_FirstPairRoads = (roadsConnectedTo _Road);

	//if(count _FirstPairRoads == 1) exitWith {SystemChat "First Connection is only 1. Exiting.."; false};

	//SystemChat str count _FirstPairRoads;
	{ if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FirstPairRoads;

	if(count _FirstPairRoads >= 2) then {
	  {{_SecondPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FirstPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}} foreach _SecondPairRoads;
	};

	if(count _SecondPairRoads >= 2) then {
	  {{_ThirdPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _SecondPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _ThirdPairRoads;
	};

	if ({((getRoadInfo _X) select 8) isEqualTo true} count _Roads > 0) exitWith {false};

	if(count _ThirdPairRoads >= 2) then {
	  {{_FourthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _ThirdPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FourthPairRoads;
	};

	if(count _FourthPairRoads >= 2) then {
	  {{_FifthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FourthPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FifthPairRoads;
	};

	if(count _FifthPairRoads >= 2) then {
	  {{_SixthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FifthPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _SixthPairRoads;
	};
	//SystemChat str _Roads;

	_Bool = {(count (roadsConnectedTo _X)) == 2} count _Roads == count _Roads;
	//SystemChat format ["Complete: %1",_Bool];

	_Bool;

	/*
	_Connected = [];
	{_Connected pushBackUnique (roadsConnectedTo [_X])} foreach _Roads;

	//SystemChat str _Connected;
	_
	//SystemChat str [_Bool,_Roads];
