#include "script_Component.hpp"

[QGVAR(setSafetyMode), {
	GVAR(Enabled) = _this;
	if (isServer) then {
		publicVariable QGVAR(Enabled);
	};
	if (hasInterface) then {
		TRACE_1("QGVAR(setSafetyMode)", _this);
		_this call FUNC(WeaponLock);
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(DisplayTime), {
	if (hasInterface) then {
		params["_number"];
		TRACE_1("QGVAR(DisplayTime)", _number);
		if (_number isEqualTo -1) then {
			systemChat "SAFE START: Weapons are now active";
		} else {
			systemChat format ["SAFE START: Time Remaining until weapons are live: %1 min", _number];
		};
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(serverReady), {
	if !(GVAR(TimeLimit) isEqualTo -1) then {
		GVAR(Enabled) = true;
		publicVariable QGVAR(Enabled);
		for "_i" from 0 to GVAR(TimeLimit) do {
			[{
				if (GVAR(Enabled)) then {
					params ["_value"];
					[QGVAR(DisplayTime), [_value]] call CBA_fnc_globalEvent;
					if (_value isEqualTo 0) then {
						[QGVAR(setSafetyMode), false] call CBA_fnc_globalEvent;
					};
				};
			}, [(GVAR(TimeLimit) - _i)], (60 * _i)] call CBA_fnc_waitAndExecute;
		};

	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(playerReady), {
	[QGVAR(setSafetyMode), GVAR(Enabled)] call CBA_fnc_localEvent;
	["AllVehicles", "Fired", {
		if (GVAR(Enabled)) then {
			if (GVARMAIN(mod_ACE3)) then {
				[_this select 6] call ACE_FRAG_Fnc_addBlackList;
			};
			deleteVehicle (_this select 6);
		};
	}, true, [], true] call CBA_fnc_addClassEventHandler;

	if !(GVAR(DistanceLimit) isEqualTo -1) then {
		[{(player distance (getMarkerPos (format ["respawn_%1", GETSIDESTRING(player)])) > GVAR(DistanceLimit))},{
			[QGVAR(setSafetyMode), false] call CBA_fnc_localEvent;
		}, []] call CBA_fnc_waitUntilAndExecute;
	};
	#include "postInitPlayer.sqf"
}] call CBA_fnc_addEventHandler;
