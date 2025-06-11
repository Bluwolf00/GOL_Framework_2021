#include "script_Component.hpp"

[{
	{
		(_x select 1) setVariable [QGVAR(currentUnits), (_x select 0), true];
	} forEach (call FUNC(countBalance));

	{
		if ((count (units _x)) isEqualTo 0) then {
			private _groupOwner = (_x getVariable [QGVAR(currentOwner), GVARMAIN(Gamelogic)]);
			GVAR(Transfered) deleteAt (GVAR(Transfered) find _x);
			if (_groupOwner isKindOf "HeadlessClient_F") then {
				_groupOwner setVariable [QGVAR(currentUnits), ((_groupOwner getVariable QGVAR(currentUnits)) - 1), true];
			};
		};
	} forEach GVAR(Transfered);

	{
		LOG(FORMAT_2("Headless stats finished %1: %2", _x, (_x getVariable QGVAR(currentUnits))));
	} forEach GVAR(headlessList);
}, [], 1] call CBA_fnc_waitAndExecute;
