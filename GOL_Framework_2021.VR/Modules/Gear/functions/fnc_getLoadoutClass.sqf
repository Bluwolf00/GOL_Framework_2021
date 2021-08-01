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

switch (true) do {
	case (_displayName in ["Officer","Commander"]): {
		_role = "officer";
	};
	case (_displayName isEqualTo "Squad Leader"): {
		_role = "sl";
	};
	case (_displayName isEqualTo "Team Leader"): {
		_role = "ftl";
	};
	case (_displayName isEqualTo "Rifleman"): {
		if ((random 1) >= 0.6 && !(isPlayer _unit)) then {
			_role = "lr";
		} else {
			_role = "r";
			if (_groupType) then {
				_role = "mat";
			};
		};
	};
	case (_displayName in ["Engineer","Ammo Bearer"]): {
		_role = "ab";
	};
	case (_displayName in ["Rifleman (AT)","Rifleman (Heavy AT)","Missile Specialist (AT)"]): {
		_role = "mat";
		if (_groupType) then {
			_role = "mat";
		};
	};
	case ((_displayName isEqualTo "Grenadier") || (["Grenadier",_displayName] call BIS_fnc_inString)) : {
		if (_groupType) then {
			_role = "amat";
		} else {
			_role = "g";
		};
	};
	case (_displayName in ["Asst. Autorifleman","Combat Life Saver","Medic","Corpsman"]): {
		if (_groupType) then {
			_role = "ammg";
		} else {
			_role = "ag";
		};
	};
	case (_displayName in ["Autorifleman","Machinegunner","Automatic Rifleman","Auto Rifleman"]): {
		if (_groupType) then {
			_role = "mmg";
		} else {
			_role = "ar";
		};
	};
	case (_displayName in ["Machine Gunner","Machine Gunner Assistant","Heavy Gunner"]): {
		if (_groupType) then {
			_role = "mmg";
		} else {
			_role = "mmg";
		};
	};
	case ((_displayName in ["Crewman","Crew"]) || (["Crew",_displayName] call BIS_fnc_inString)): {
		_role = "crew";
	};
	case (_displayName in ["Helicopter Pilot","Pilot"]): {
		_role = "p";
	};
	case ((_displayName in ["Marksman","Sniper","Spotter"]) || (["Marksman",_displayName] call BIS_fnc_inString) || (["Sniper",_displayName] call BIS_fnc_inString)): {
		_role = "marksman";
	};
};

_role
