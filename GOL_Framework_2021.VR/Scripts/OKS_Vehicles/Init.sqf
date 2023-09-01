//	[] execVM "Scripts\OKS_Vehicles\Init.sqf";
//
//	This initializes all the functions for OKS Ambience.
//
//	Made by Oksman

execVM "Scripts\OKS_Vehicles\OKS_Mortar_action.sqf";
_Mortars = Vehicles select {
	["mk6",typeOf _X] call BIS_fnc_inString ||
	["podnos",typeOf _X] call BIS_fnc_inString ||
	["2b14",typeOf _X] call BIS_fnc_inString ||
	["m252",typeOf _X] call BIS_fnc_inString ||
	["l16",typeOf _X] call BIS_fnc_inString
};
{
	[_X] execVM "Scripts\OKS_Vehicles\OKS_Mortar.sqf";		
} forEach _Mortars;

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
OKS_Tanker = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Tanker.sqf";
OKS_CreateCrew = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_CreateCrew.sqf";
OKS_Helicopter = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Helicopter.sqf";




