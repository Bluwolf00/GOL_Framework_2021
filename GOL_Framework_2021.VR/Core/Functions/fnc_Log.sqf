/*
	Author: GuzzenVonLidl
	A simple and fast way of displaying debugging information
	NOTE: This function should only be called from macros

	Usage:
	[__LINE__, #COMPONENT_TAG, "Hello World", "DEBUG", false] call GW_fnc_log

	Arguments:
	0: Line this was called from <NUMBER>
	1: Component <STRING>
	2: Message <STRING> or <ARRAY>
	3: Level of Debugging <STRING>
	4: Global <BOOL>

	Return Value:
	true

	Public: Yes

*/
#include "script_Component.hpp"
private ["_log_write", "_logType", "_logMsg", "_strArr", "_strNumbers", "_strText", "_logColor"];
params ["_line", ["_component", ""], "_msg", "_type", ["_global", false]];
_strNumbers = [diag_frameNo, diag_tickTime, time, _line];
_logVisualy = false;

#ifdef DEBUG_MODE_FULL
	_logVisualy = false;
#endif

switch (_type) do  {
	case "DEBUG": {
		_logType = "DEBUG";
		_logColor = "#1111";
	};
	case "WARNING": {
		_logType = "WARNING";
		_logColor = "#1101";
		_logVisualy = true;
	};
	case "ERROR": {
		_logType = "ERROR";
		_logColor = "#1001";
		_logVisualy = true;
	};
	default {
		_logType = "";
		_logColor = "#1111";
	};
};
if (_component != "") then {
	_logMsg = format ["[%1-%2] - ", _logType, _component];
} else {
	_logMsg = format ["[%1] - ", _logType];
};
_strText = (_logMsg + _msg);

if (_global && isMultiplayer) then {
	if (isServer) then {
		{
			[_strNumbers, _strText, GVARMAIN(MACHINE)] remoteExecCall [QFUNCMAIN(LogAdmin), _x];
		} forEach EGVAR(main,activeAdmins);
	} else {
		[[_strNumbers, _strText, GVARMAIN(MACHINE)], {
			{
				[(_this select 0),(_this select 1),(_this select 2)] remoteExecCall [QFUNCMAIN(LogAdmin), _x];
			} forEach EGVAR(main,activeAdmins);
		}] remoteExecCall [QFUNCMAIN(remoteCommand), 2];
	};
};

if (GVARMAIN(canUseDevConsole)) then {
	DEVCONSOLE(str(_strNumbers) + _strText + _logColor);
};
diag_log (_strText);
if (_logVisualy) then {
	systemChat (_strText);
};
true
