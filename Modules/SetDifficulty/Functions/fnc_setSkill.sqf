/*
	Author: GuzzenVonLidl
	Sets the difficulty read from mission configs

	Usage:
	[this, 2] call GW_SetDifficulty_fnc_setSkill;

	Arguments:
	0: Unit <OBJECT>
	1: BehaviorTree <NUMBER>	(OPTIONAL)
		0: Testing
		1: Specialforces
		2: Military
		3: Insurgents
		4: Dummy

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_behaviorTree", GVAR(unitTraining)]
];
if (isPlayer _unit) exitWith {false};

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
	TRACE_3("Init", _unit, (_unit skill "aimingAccuracy"), (_unit skill "general"));
};

_unit setUnitPosWeak "UP";
_unit disableAI "MINEDETECTION";
