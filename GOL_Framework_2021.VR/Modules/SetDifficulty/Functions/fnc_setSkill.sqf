/*
	Author: GuzzenVonLidl
	Sets the difficulty read from mission configs

	Usage:
	[this, 2] call GW_SetDifficulty_fnc_setSkill;

	Arguments:
	0: Unit <OBJECT>
	1: BehaviorTree <NUMBER>	(OPTIONAL) - Use -1 for auto-detect from side settings
		0: Testing
		1: Specialforces
		2: Military
		3: Insurgents
		4: Dummy
		-1: Auto-detect from side (uses per-side or global settings) [DEFAULT]

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_behaviorTree", -1]
];
if (isPlayer _unit) exitWith {false};

// Get difficulty based on unit's side if not explicitly specified
if (_behaviorTree == -1) then {
	_behaviorTree = [_unit] call FUNC(getDifficultyForSide);
};

if ((side _unit) isEqualTo "CIV") then {
	_unit setskill 0;
} else {
	#define	BEHAVIOURS		(missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour")
	#define	BEHAVIOURTREE	(BEHAVIOURS >> _tree)
	private _list = [];
	for "_i" from 0 to ((count BEHAVIOURS) - 1) step 1 do {
		_list pushBack (configName (BEHAVIOURS select _i));
	};
	private _tree = (_list select _behaviorTree);

	{
		_x params ["_skill"];
		(getArray(BEHAVIOURTREE >> _skill)) params ["_min","_mid","_max"];
		private _value = _mid;

		if (GVAR(randomSkill)) then {
			_value = (random [_min, _mid, _max]);
			_value = (parseNumber (_value toFixed 3));
		};
		_unit setskill [_skill, _value];
	} forEach ["aimingAccuracy","aimingShake","aimingSpeed","commanding","courage","endurance","general","reloadSpeed","spotDistance","spotTime"];

	if (isClass(BEHAVIOURTREE >> "Fleeing")) then {
		(getArray(BEHAVIOURTREE >> "Fleeing")) params ["_min","_mid","_max"];
		private _value = _mid;
		if (GVAR(randomSkill)) then {
			_value = (random [_min, _mid, _max]);
			_value = (parseNumber (_value toFixed 2));
		};
		_unit allowFleeing _value;
	};

	private _stealthEnabled = missionNamespace getVariable ["GOL_Stealth_Enabled", false];
	private _group = group _unit;

	if (_stealthEnabled) then {
		// Stealth mode: cap AI spotting/coordination to reduce long-range instant visual detection.
		_unit setSkill ["spotDistance", ((_unit skill "spotDistance") min 0.15)];
		_unit setSkill ["spotTime", ((_unit skill "spotTime") min 0.15)];
		_unit setSkill ["commanding", ((_unit skill "commanding") min 0.15)];

		// Dampen LAMBS danger behavior/info propagation while stealth is active.
		_unit setVariable ["lambs_danger_disableAI", true, true];
		_unit setVariable [QGVAR(stealthLambsAppliedUnit), true, false];

		_group setVariable ["lambs_danger_disableAI", true, true];
		_group setVariable ["lambs_danger_disableGroupAI", true, true];
		_group setVariable [QGVAR(stealthLambsAppliedGroup), true, false];
	} else {
		if (_unit getVariable [QGVAR(stealthLambsAppliedUnit), false]) then {
			_unit setVariable ["lambs_danger_disableAI", false, true];
			_unit setVariable [QGVAR(stealthLambsAppliedUnit), false, false];
		};

		if (_group getVariable [QGVAR(stealthLambsAppliedGroup), false]) then {
			_group setVariable ["lambs_danger_disableAI", false, true];
			_group setVariable ["lambs_danger_disableGroupAI", false, true];
			_group setVariable [QGVAR(stealthLambsAppliedGroup), false, false];
		};
	};

	TRACE_3("Init", _unit, (_unit skill "aimingAccuracy"), (_unit skill "general"));
};

_unit setUnitPosWeak "UP";
_unit disableAI "MINEDETECTION";
