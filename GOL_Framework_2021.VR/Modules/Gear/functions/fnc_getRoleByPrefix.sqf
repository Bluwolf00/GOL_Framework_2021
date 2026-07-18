/*
	Author: Blu.
	Returns the current role name based on the prefix.

	Usage:
	["sl"] call GW_Gear_Fnc_getRoleByPrefix;

	Arguments:
	0: Role <STRING>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params ["_role"];

_roleName = "";

switch (_role) do {

    /* Standard Roles */
    case "pl": {_roleName = "Platoon Leader"};
    case "pm": {_roleName = "Platoon Medic"};
    case "drone": {_roleName = "Drone Operator"};
    case "lightdragon": {_roleName = "Mortar Operator"};
    case "sl": {_roleName = "Squad Leader"};
    case "fac": {_roleName = "Forward Air Controller"};
    case "sm": {_roleName = "Squad Medic"};
    case "ftl": {_roleName = "Fire Team Leader"};
    case "r": {_roleName = "Rifleman"};
    case "g": {_roleName = "Grenadier"};
    case "ag": {_roleName = "Asst. Gunner"};
    case "ar": {_roleName = "Automatic Rifleman"};
    case "ab": {_roleName = "AR Ammo Bearer"};
    case "atab": {_roleName = "AT Ammo Bearer"};
    case "crew": {_roleName = "Crewman"};

    /* Specialist Roles */
    case "ammg": {_roleName = "Asst. Medium Machine Gunner"};
    case "mmg": {_roleName = "Medium Machine Gunner"};
    case "dragon": {_roleName = "Dragon"};
    case "engineer": {_roleName = "Engineer"};
    case "lr": {_roleName = "Light Rifleman"};
    case "aa": {_roleName = "Anti-Air"};
    case "amat": {_roleName = "Asst. Heavy AT"};
    case "mat": {_roleName = "Heavy AT"};
    
    /* Air Roles */
    case "p": {_roleName = "Rotary Pilot"};
    case "jetp": {_roleName = "Jet Pilot"};
    case "pj": {_roleName = "Para-Rescueman"};
    case "marksman": {_roleName = "Marksman"};

    default {
        _roleName = "";
    };
};

_roleName