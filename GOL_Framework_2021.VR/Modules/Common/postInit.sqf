#include "script_Component.hpp"

[QGVARMAIN(serverReady), {
	if (GVAR(autoDelete)) then {
		["CAManBase", "init", {
				[{
					params [
						"_unit"
					];
					if ((_unit distance [0,0,0]) < 30) then {
						deleteVehicle _unit;
					};
				}, _this, 10] call CBA_fnc_waitAndExecute;
		}, true, [], true] call CBA_fnc_addClassEventHandler;
	};
}] call CBA_fnc_addEventHandler;

[QGVAR(update), {
	[{
		[] call FUNC(simpleRoster);
	}, []] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(mapLoaded), {
	if !(didJip) then {
//		[QGVAR(update), []] call CBA_fnc_globalEvent;
		[QGVAR(update), []] call CBA_fnc_localEvent;
	};
}] call CBA_fnc_addEventHandler;

[QGVARMAIN(playerReady), {
	[player] call FUNC(setGroupColor);
	if (leader (group player) isEqualTo player) then {
		[player] call FUNC(setGroupID);
	};
	if (didJip) then {
		[QGVAR(update), []] call CBA_fnc_globalEvent;
	};

	player setVariable [QGVAR(isPlayer), true, true];
	player addEventHandler ["InventoryOpened", {
		params ["_unit","_container","_secondaryContainer"];
		if (GVAR(BlockAIGear)) then {
			if (((_container isKindOf "CAManBase") && !(_container getVariable [QGVAR(isPlayer), false])) || ((_secondaryContainer isKindOf "CAManBase") && (_secondaryContainer getVariable [QGVAR(isPlayer), false]))) then {
				true
			};
		} else {
			false
		};
	}];
}] call CBA_fnc_addEventHandler;

[QGVAR(disableAICommand), {
	params ["_unit"];
	_unit setVariable [QGVAR(disableAI_Path), true, true];
	_unit disableAI "PATH";
	_unit disableAI "MINEDETECTION";
//	_unit disableAI "TEAMSWITCH";

//	_unit disableAI 'SUPPRESSION';
//	_unit disableAI 'AUTOCOMBAT';			// AI run another FSM when in combat, this may reduce the calculations
//	_unit disableAI 'CHECKVISIBLE';			// Raycasting takes up a lot of CPU time, this will sharply reduce.
	_unit disableAI 'COVER';				// should disable some expensive cover calculations
//	_unit disableAI 'FSM';					// Will make the AI very dumb, and reduce some calculations. they may not shoot.
	_unit setSkill ['spotDistance',0.5];	// Reduce the distance at which AI can see enemy, reducing their calculations.
	_unit setBehaviour 'AWARE';				// Get the unit out of combat mode so some of the above can take effect.

	doStop _unit;
	(group _unit) enableAttack false;
}] call CBA_fnc_addEventHandler;

/*
AIAiming - shows vectors (lines) of AI aiming at known target
AIBrain - general informations about AI brain, combat mode and fsm state
AIDynamicError - shows value of dynamically calculated AI aiming error
AISkill - shows value of skill, plus global coefficients, as set by difficulty mode
AISuppression - shows value of suppression
AIDriving - Shows various information about AI driving and path in real time.

"AIAiming" diag_enable true;
"AIBrain" diag_enable true;
"AIDynamicError" diag_enable true;
"AISkill" diag_enable true;
"AISuppression" diag_enable true;
*/
