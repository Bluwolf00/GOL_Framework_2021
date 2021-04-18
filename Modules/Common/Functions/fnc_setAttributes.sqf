#include "script_Component.hpp"

params [
	"_object",
	"_specials"
];

{
	_x params ["_switch","_value"];
	switch (_switch) do {
		case 0: {
			[] call (compile (format ["%1", (toString(toArray(format ["%1", [_value, "this", "_object"] call CBA_fnc_replace])))]));
		};
		case 1: {
			_object allowDamage _value;
		};
		case 2: {
			if (_object isKindOf "CAManBase") then {
				[_object,_value] spawn {
					(_this select 0) enableSimulationGlobal (_this select 1);
				};
			} else {
				_object enableSimulationGlobal _value;
			};
		};
		case 3: {
			_object lock _value;
		};
		case 4: {	// addToDynSimGrid
			_object triggerDynamicSimulation _value;
		};
		case 5: {	// dynamicSimulation
			_object enableDynamicSimulation _value;
		};
		case 6: {	// Vehicle Texture
			[_object, _value, nil] call bis_fnc_initVehicle;
		};
		case 7: {	// Vehicle Animation
			[_object, nil, _value] call bis_fnc_initVehicle;
		};
		case 8: {	// Pylons
			_getPylons = (call EFUNC(Common,getPylonsAvailable));
			{
				_object setPylonLoadOut [_getPylons select _forEachIndex, _x];
			} forEach _value;
		};
		case 9: {
			_object setVehicleReportRemoteTargets _value;
		};
		case 10: {
			_object setVehicleReceiveRemoteTargets  _value;
		};
		case 11: {
			_object setVehicleReportOwnPosition _value;
		};
		case 12: {
			_object setVehicleRadar _value;
		};
		case 13: {
			(group _object) setVariable ["GW_DisableHC", _value, true];
		};
		case 14: {
			_object setVariable ["GW_DisableGearInit", _value, true];
		};
		case 15: {
			_object setVariable ["GW_LoadoutSelector", _value, true];
		};
	};
} forEach _specials;
