/*
	[RoadObject] execVM "OKS_CheckRoadConnections.sqf";
	[RoadObject] spawn OKS_CheckRoadConnections;
*/
Params ["_Road","_Bool"];
Private ["_Roads","_FirstPairRoads","_SecondPairRoads","_ThirdPairRoads","_FourthPairRoads","_FifthPairRoads","_SixthPairRoads","_SeventhPairRoads","_EigthPairRoads"];

	private _Debug_Variable = False;

	_Roads = [];
	_SecondPairRoads = [];
	_ThirdPairRoads = [];
	_FourthPairRoads = [];
	_FifthPairRoads = [];
	_SixthPairRoads = [];
	_SeventhPairRoads = [];
	_EigthPairRoads = [];

	_FirstPairRoads = (roadsConnectedTo _Road);

	//if(count _FirstPairRoads == 1) exitWith {SystemChat "First Connection is only 1. Exiting.."; false};

	//SystemChat str count _FirstPairRoads;
	{ if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FirstPairRoads;

	if(count _FirstPairRoads >= 1) then {
	  {{_SecondPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FirstPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}} foreach _SecondPairRoads;
	};

	if(count _SecondPairRoads >= 1) then {
	  {{_ThirdPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _SecondPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _ThirdPairRoads;
	};

	if(count _ThirdPairRoads >= 1) then {
	  {{_FourthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _ThirdPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FourthPairRoads;
	};

	if(count _FourthPairRoads >= 1) then {
	  {{_FifthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FourthPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FifthPairRoads;
	};

	if(count _FifthPairRoads >= 1) then {
	  {{_SixthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FifthPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _SixthPairRoads;
	};

	if(count _SixthPairRoads >= 1) then {
	  {{_SeventhPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _SixthPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _SeventhPairRoads;
	};

	if(count _SeventhPairRoads >= 1) then {
	  {{_EigthPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _SeventhPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _EigthPairRoads;
	};

	//SystemChat str _Roads;
	if ({((getRoadInfo _X) select 8) isEqualTo true} count _Roads > 0) exitWith { if(_Debug_Variable) then { SystemChat format ["Bridge Found: %1",False] }; false};
	_Bool = {(count (roadsConnectedTo _X)) == 2} count _Roads == count _Roads;
	if(_Debug_Variable) then { SystemChat format ["Complete: %1",_Bool] };

	_Bool;
