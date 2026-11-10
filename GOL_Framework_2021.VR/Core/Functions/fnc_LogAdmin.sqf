/*
	Author: GuzzenVonLidl
	Displays debugging info for admins in the systemChat, diag_Log but also DiaryRecords
	NOTE: This function should not be called manually but only from GW_Fnc_Log

	Usage:
	[[diag_frameNo, diag_tickTime, time, _line], "Hello World", GW_MACHINE, false] call GW_Fnc_LogAdmin

	Arguments:
	0: Array of info in numbers from when error happend <ARRAY>
	1: Error Text <STRING>
	2: Where it happend on <STRING>
	3: Type <BOOL>

	Return Value:
	true

	Public: Yes

*/
#include "script_Component.hpp"
params ["_strNumbers", "_strText", "_machine"];

//	_strNumbers pushBack ((format ["REMOTE: %1 - ", _machine]) + _strText);
diag_log _strNumbers;

if !(player diarySubjectExists QGVAR(adminLogging)) then {
	player createDiarySubject [QGVAR(adminLogging),"Admin Logging"];
};

player createDiaryRecord [QGVAR(adminLogging), [format ["REMOTE: %1 - %2", _machine, str(time)], _strText]];

if (GVARMAIN(canUseDevConsole)) then {
	DEVCONSOLE(str(_strNumbers) + _strText);
};
