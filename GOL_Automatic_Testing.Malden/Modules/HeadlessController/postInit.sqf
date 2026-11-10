#include "script_Component.hpp"

[QGVARMAIN(playerReady), {
	[(group player), true] call FUNC(BlackList);
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(headlessReady), {
	[(group player), true] call FUNC(BlackList);
	[{
		[QGVAR(addHC), player] call CBA_fnc_serverEvent;
		[QGVAR(adjustViewDistance), []] call CBA_fnc_localEvent;
	}, [], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(serverReady), {
	[QGVAR(adjustViewDistance), []] call CBA_fnc_localEvent;

	["CAManBase", "init", {
		[{
			params ["_unit"];
			private _group = (_unit call CBA_fnc_getGroup);

			if ((_group getVariable [QGVAR(BlackList), false]) || !(({isPlayer _x} count (units _group)) isEqualTo 0)) exitWith {
				LOG(FORMAT_1("Group: %1 is blacklisted", _group));
				false
			};

			GVAR(ToTransfer) pushBackUnique _group;
		}, [], 5] call CBA_fnc_waitAndExecute;
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	["CAManBase", "Local", {
		params ["_unit", "_isLocal"];
		if (_unit getVariable [QEGVAR(Common,disableAI_Path), false]) then {
			[QEGVAR(Common,disableAICommand), _unit] call CBA_fnc_localEvent;
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	[{	// Add delay before first event
		GVAR(PFH) = [{
			if !((count GVAR(ToTransfer)) isEqualTo 0) then {
				[] call FUNC(HandlePFH);
			};
			if (call EFUNC(Common,isDevBuild)) then {
				publicVariable QGVAR(headlessList);
				publicVariable QGVAR(Transfered);
				publicVariable QGVAR(ToTransfer);
				publicVariable QGVAR(groupsTransfered);
			};
		}, 30, []] call CBA_fnc_addPerFrameHandler;
	}, [], 15] call CBA_fnc_waitAndExecute;

	addMissionEventHandler ["HandleDisconnect", {
		params ["_unit","_id","_uid","_name"];
		if !(_unit isKindOf "HeadlessClient_F") exitWith {false};

		GVAR(headlessList) deleteAt (GVAR(headlessList) find _unit);
		publicVariable QGVAR(headlessList);
		LOG_ADMIN(FORMAT_1("Headless Client: %1 Disconnected", _unit));
		LOG_ADMIN(FORMAT_1("There are %1 Headless left in the mission", count GVAR(headlessList)));
		if !((count GVAR(headlessList)) isEqualTo 0) then {
			[QGVAR(updateBalance), true] call CBA_fnc_serverEvent;
		} else {
			GVAR(Transfered) = [];
			{
				_x setVariable [QGVAR(Transfered), false];
			} forEach allGroups;
		};
	}];
}] call CBA_fnc_addEventHandler;

[QGVAR(addHC), {
	params ["_headless"];
	LOG_ADMIN(FORMAT_1("Headless Client: %1 Connected", _headless));
	_headless setVariable [QGVAR(currentUnits), 0, true];

	GVAR(headlessList) pushBack _headless;
	publicVariable QGVAR(headlessList);	// why share?

	if (didJIPOwner _headless) then {
		if !((count GVAR(headlessList)) isEqualTo 0) then {
			[QGVAR(updateBalance), true] call CBA_fnc_serverEvent;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(adjustViewDistance), {
	if ((count GVAR(headlessList)) > 0) then {
		if (isServer) then {
			setViewDistance 3000;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
		if (CBA_isHeadlessClient) then {
			setViewDistance 3000;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
	} else {
		if (isServer) then {
			setViewDistance 3000;
			setObjectViewDistance [1500,0];
			setTerrainGrid 25;
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(updateBalance), {
	params ["_rebalance"];
	if (_rebalance) then {
		GVAR(ToTransfer) = (GVAR(ToTransfer) + GVAR(Transfered));
		GVAR(Transfered) = [];
		LOG_ADMIN("Forcing a rebalance on all groups");
		{
			_x setVariable [QGVAR(currentUnits), 0, true];
		} forEach GVAR(headlessList);
	} else {
		{
			(_x select 1) setVariable [QGVAR(currentUnits), (_x select 0), true];
			TRACE_2("Headless Stats", (_x select 0), (_x select 1));
		} forEach (call FUNC(countBalance));
	};
}] call CBA_fnc_addEventHandler;
