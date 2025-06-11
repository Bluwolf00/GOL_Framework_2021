/*
	Author: GuzzenVonLidl
	Sets the difficulty read from mission configs

	Usage:
	[this, 2] call GW_SetDifficulty_fnc_setSkill;

	Arguments:
	0: Unit <OBJECT>
	1: BehaviorTree <NUMBER>	(OPTIONAL)

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params [
	["_unit", objNull, [objNull]],
	["_behaviorTree", 2]
];

_useRandom = false;

if !(isPlayer _unit) then {
	if (isServer && !(GVAR(difficulty) isEqualTo 0)) then {
		if ((side _unit) isEqualTo "CIV") then {
			_unit setskill 0;
		} else {
			_tree = (["Testing","SpecialForces","Military","Insurgents","Dummy"] select _behaviorTree);
			{
				_x params ["_skill"];
				private _getValue = getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour" >> _tree >> _skill);
				private _value = (_getValue select 1);
				if (_useRandom) then {
					_value = (random [(_getValue select 0), (_getValue select 1), (_getValue select 2)]);
					_value = (parseNumber (_value toFixed 3));
				};
				_unit setskill [_skill, _value];
			} forEach ["aimingAccuracy","aimingShake","aimingSpeed","commanding","courage","endurance","general","reloadSpeed","spotDistance","spotTime"];

			_getValue = getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Behaviour" >> _tree >> "Fleeing");
			_value = (_getValue select 1);
			if (_useRandom) then {
				_value = (random [(_getValue select 0), (_getValue select 1), (_getValue select 2)]);
				_value = (parseNumber (_value toFixed 2));
			};
			_unit allowFleeing _value;

			TRACE_3("Init", _unit, (_unit skill "aimingAccuracy"), (_unit skill "general"));
		};
	};
};
