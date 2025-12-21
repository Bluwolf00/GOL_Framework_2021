/*
	Author: GuzzenVonLidl
	Applies gear to aa soldier automaticly appon spawning it.
	Players are not affected by this
	Disable autogear by setting it to false

	Usage:
	[this, "sl"] call GW_Gear_Fnc_getLoadoutClass;

	Arguments:
	0: Unit <OBJECT>
	1: Role <STRING>	NOTE: THIS PARAM IS OPTIONAL AND SHOULD ONLY BE USED IF YOU WANT TO FORCE A ROLE

	Return Value: NO

	Public: NO
*/
#include "script_Component.hpp"

params [
	"_unit"
];

private _role = "r";
private _displayName = getText (configfile >> "CfgVehicles" >> (typeOf _unit) >> "displayName");

_ResolveRoleByDisplayName = {
    params ["_displayName","_ArrayOfMatches","_ExpectedRole"];
    
	// Default role returned is rifleman.
	_ReturnedRole = "r";

	// If match is found in the Array of Matches - Return the role set by _ReturnedRole
    {
        if ([_x, _displayName] call BIS_fnc_inString) exitWith {
			_ReturnedRole = _ExpectedRole;
		};
    } forEach _ArrayOfMatches;
    
	_ReturnedRole
};

private _rolePatterns = [
    [["Officer","Commander"], "officer"],
	[["Platoon Leader"], "pl"],
    [["Squad Leader"], "sl"],
    [["JTAC"], "fac"],
    [["Team Leader"], "ftl"],
    [["Engineer","Ammo Bearer"], "ab"],
    [["Rifleman (AT)","Rifleman (Heavy AT)","Missile Specialist (AT)"], "mat"],
    [["Grenadier"], "g"],
    [["Asst. Autorifleman","Combat Life Saver","Medic","Corpsman"], "ag"],
    [["Autorifleman","Automatic Rifleman","Auto Rifleman"], "ar"],
    [["Machinegunner","Machine Gunner","Machine Gunner Assistant","Heavy Gunner"], "mmg"],
    [["Crewman","Crew"], "crew"],
    [["Helicopter Pilot","Pilot"], "p"],
    [["Sniper"], "marksman"],
    [["Marksman","Spotter"], "lr"],
    [["Missile Specialist (AA)","AA Specialist","Anti-Air Specialist","Anti Aircraft"], "aa"]
];

// Try to resolve role by display name using the patterns
{
	_x params ["_ArrayOfMatches", "_ReturnedRole"];
    private _result = [_displayName, _ArrayOfMatches, _ReturnedRole] call _ResolveRoleByDisplayName;
    if (_result != "r") exitWith {
		_role = _result;
	};
} forEach _rolePatterns;

_role