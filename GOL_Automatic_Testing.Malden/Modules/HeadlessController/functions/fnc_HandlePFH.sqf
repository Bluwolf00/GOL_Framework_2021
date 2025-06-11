#include "script_Component.hpp"

{
	_x params ["_group"];
	private _headlessArray = [];
//	private _groupOwner = (_group getVariable [QGVAR(currentOwner), GVARMAIN(Gamelogic)]);

	if !(count GVAR(headlessList) isEqualTo 0) then {
		{
			_headlessArray pushBack [(_x getVariable QGVAR(currentUnits)), _x];
		} forEach GVAR(headlessList);
		_headlessArray sort true;
		_headless = ((_headlessArray select 0) select 1);
		_headless setVariable [QGVAR(currentUnits), ((_headless getVariable QGVAR(currentUnits)) + 1), true];

		_group setGroupOwner (owner _headless);
		_group setVariable [QGVAR(currentOwner), _headless, true];

		[{
			params ["_group","_headless"];
			{
				if (_x getVariable [QEGVAR(Common,disableAI_Path), false]) then {
					[QEGVAR(Common,disableAICommand), _x, _headless] call CBA_fnc_targetEvent;
				};
			} forEach (units _group);
		}, [_group,_headless], 3] call CBA_fnc_waitAndExecute;

		GVAR(groupsTransfered) pushBack _group;
		LOG(FORMAT_2("%2 moved to %1", _headless, _group));
	} else {
		if !((count (units _group)) isEqualTo 0) then {
			LOG_ADMIN("Forcing Server as owner - Could not find any Headless clients");
			_group setGroupOwner 2;
		} else {
			LOG_ADMIN("No members in group, Transfer not completed");
		};
	};
} forEach GVAR(ToTransfer);

{
	GVAR(Transfered) pushBack _x;
	GVAR(ToTransfer) deleteAt (GVAR(ToTransfer) find _x);
} forEach GVAR(groupsTransfered);
