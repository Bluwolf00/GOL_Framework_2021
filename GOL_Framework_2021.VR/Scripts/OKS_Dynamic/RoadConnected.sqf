/*
	[RoadObject,Count] execVM "Scripts\OKS_Dynamic\RoadConnected.sqf";
	[RoadObject,Count] spawn OKS_RoadConnected;
*/
Params ["_Road","_Count"];
Private ["_Roads","_Road1","_Road2"];

_Repetitions = 0;

_AllRoads = [];

_Roads = roadsConnectedTo _Road;
_Roads1 = roadsConnectedTo (_Roads select 0);
_Roads2 = roadsConnectedTo (_Roads select 1);

SystemChat str _Road;
SystemChat str _Roads;
SystemChat str (roadsConnectedTo _Roads1);
SystemChat str (roadsConnectedTo _Roads2);

{{_AllRoads pushBackUnique _X} foreach _X} foreach [_Roads,_Roads1,_Roads2];

SystemChat str _AllRoads;
/*
OKS_RoadConnected = {

	Params ["_Road","_AllRoads","_Repetitions"];
	_Repetitions = _Repetitions + 1;
	if(_Repetitions >= _Count) exitWith { SystemChat format ["Reached Limit: Array: %1",_AllRoads]};
	_NewRoads = roadsConnectedTo _Road;
	systemChat format  ["Given Road %1 leads to %2",_Road,_NewRoads];
	{_AllRoads pushBackUnique _X; if(_AllRoads find _X isEqualTo -1) then {
		[_X] call OKS_RoadConnected;
	}; } foreach _NewRoads;

	[_AllRoads,_Repetitions];

};

_Array = [_Road1,_AllRoads,_Repetitions] call OKS_RoadConnected;
_Array Params ["_AllRoads","_Repetitions"];
//[_Road2] spawn OKS_RoadConnected;


	/*
	_FirstRoads = (roadsConnectedTo _Road);
	if(count _FirstRoads == 2) then {
		[_FirstRoads select 0] spawn OKS_RoadConnected;
		[_FirstRoads select 1] spawn OKS_RoadConnected;
	};

	[575963: ,575965: ]

	//if(count _FirstPairRoads == 1) exitWith {SystemChat "First Connection is only 1. Exiting.."; false};

	//SystemChat str count _FirstPairRoads;
	{ if(!(isNull _X)) then {_Roads pushBackUnique _X}}foreach _FirstPairRoads;

	if(count _FirstPairRoads >= 2) then {
	  {{_SecondPairRoads pushBackUnique _X} foreach (roadsConnectedTo _X)} foreach _FirstPairRoads;
	  { if(!(isNull _X)) then {_Roads pushBackUnique _X}} foreach _SecondPairRoads;
	};
