/*
	Author: GuzzenVonLidl
	Applies the correct team color for the unit
	Value is grabbed from the unit name

	Usage:
	[player] call GW_Common_Fnc_setGroupID;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: YES
*/
#include "script_Component.hpp"
#define	TrimString1st [format ["%1", _unit], 1] call BIS_fnc_trimString

private ["_callSign"];
params ["_unit"];

switch (True) do {
	case (TrimString1st in ["pl","fac"]): {
		_callSign = "1-Actual";
	};
	case (TrimString1st in ["1a","1m"]): {
		_callSign = "1-1 Actual";
	};
	case (TrimString1st in ["1a1","1a2","1a3","1a4","1a5"]): {
		_callSign = "1-1 Alpha";
	};
	case (TrimString1st in ["1b1","1b2","1b3","1b4","1b5"]): {
		_callSign = "1-1 Bravo";
	};
	case (TrimString1st in ["1c1","1c2","1c3","1c4","1c5"]): {
		_callSign = "1-1 Charlie";
	};
	case (TrimString1st in ["2a","2m"]): {
		_callSign = "1-2 Actual";
	};
	case (TrimString1st in ["2a1","2a2","2a3","2a4","2a5"]): {
		_callSign = "1-2 Alpha";
	};
	case (TrimString1st in ["2b1","2b2","2b3","2b4","2b5"]): {
		_callSign = "1-2 Bravo";
	};
	case (TrimString1st in ["2c1","2c2","2c3","2c4","2c5"]): {
		_callSign = "1-2 Charlie";
	};
	case (TrimString1st in ["echo1"]): {
		_callSign = "Echo 1";
	};
	case (TrimString1st in ["echo2"]): {
		_callSign = "Echo 2";
	};
	case (TrimString1st in ["echo3"]): {
		_callSign = "Echo 3";
	};
	case (TrimString1st in ["echo4"]): {
		_callSign = "Echo 4";
	};
	case (TrimString1st in ["echo4"]): {
		_callSign = "Echo 4";
	};
	case (TrimString1st in ["echo5"]): {
		_callSign = "Echo 5";
	};
	case (TrimString1st in ["echo6"]): {
		_callSign = "Echo 6";
	};
};

if !(isNil"_callSign") then {
	(group _unit) setGroupIdGlobal [_callSign];
};
