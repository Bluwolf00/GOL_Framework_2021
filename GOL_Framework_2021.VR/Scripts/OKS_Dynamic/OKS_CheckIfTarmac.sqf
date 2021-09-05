/*
	[Road] execVM "Scripts\OKS_Dynamic\OKS_CheckIfTarmac.sqf";
	[Road] spawn OKS_CheckIfTarmac;
*/

Params["_Road"];
Private["_Bool"];

if(!isNull _Road && (getRoadInfo _Road select 3) != "" && (getRoadInfo _Road select 0) != "TRAIL") then {
	_Bool = ["tarmac",(getRoadInfo _Road select 3)] call BIS_fnc_inString || ["asf3",(getRoadInfo _Road select 3)] call BIS_fnc_inString || ["asf2",(getRoadInfo _Road select 3)] call BIS_fnc_inString
} else { _Bool = False};

_Bool;
