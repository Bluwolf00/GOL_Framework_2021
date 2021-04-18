/*
	Author: GuzzenVonLidl
	Because you cant use some commands with remoteExec

	Usage:
	[ARRAY pushBack player] remoteExecCall [QFUNCMAIN(remoteCommand), 2];

	Arguments:
	0: Code to be used <ARRAY>

	Return Value:
	None

	Public: No

*/
#include "script_Component.hpp"
params [["_params", []], ["_code", []]];

if (_code isEqualType []) then {
	ERROR("Code is nil");
	false
} else {
	_params call _code;
	true
};
