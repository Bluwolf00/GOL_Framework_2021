#include "script_Component.hpp"

params [
	"_object",
	"_specials"
];

{
	_x params ["_switch","_value"];
	switch (_switch) do {
		case 0: {
			_object set3DENAttribute ["init", _value];
		};
		case 1: {
			_object set3DENAttribute ["allowDamage", _value];
		};
		case 2: {
			_object set3DENAttribute ["enableSimulation", _value];
		};
		case 3: {
			_object set3DENAttribute ["lock", _value];
		};
		case 4: {	// addToDynSimGrid
			_object set3DENAttribute ["dynamicSimulation", _value];
		};
		case 5: {	// dynamicSimulation
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
			_object set3DENAttribute ["ReportRemoteTargets", _value];
		};
		case 10: {
			_object set3DENAttribute ["ReceiveRemoteTargets", _value];
		};
		case 11: {
			_object set3DENAttribute ["ReportOwnPosition", _value];
		};
		case 12: {
			_object set3DENAttribute ["RadarUsageAI", _value];
		};
		case 13: {
			_object set3DENAttribute ["GW_DisableHC", _value];
		};
		case 14: {
			_object set3DENAttribute ["GW_DisableGearInit", _value];
		};
		case 15: {
			_object set3DENAttribute ["GW_LoadoutSelector", _value];
		};
	};
} forEach _specials;
