/*
	Author: GuzzenVonLidl
	initialize a vehicle to create a mhq

	Usage:
	[mhq, "car"] call GW_MHQ_Fnc_Handler;

	Arguments:
	0: Unit <OBJECT>
	1: MHQ when assembled <STRING>
		"car"
		"truck"

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
if (!isServer) exitWith {false};

[{
	params ["_mhq",["_type","",[""]],["_side","west",[""]]];

	[QGVAR(Enabled), [_mhq, false]] call CBA_fnc_LocalEvent;
	_jipID = [QGVAR(Actions), [_mhq], format ["GW_MHQ_JIP_%1", _mhq]] call CBA_fnc_globalEventJIP;
	_mhq setVariable [QGVAR(Info), [(typeOf _mhq), (getPosATL _mhq), floor(getdir _mhq), (vehicleVarName _mhq), _type, _jipID], true];	// Store for respawn
	_mhq setVariable [QGVAR(Fuel), (fuel _mhq)];
	_mhq setVariable [QGVAR(Side), toLower(_side), true];
	_mhq setPlateNumber (vehicleVarName _mhq);
	if (GVARMAIN(mod_ACE3)) then {
		[_mhq, 30] call ace_cargo_fnc_setSpace;
		[_mhq, 8, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		[_mhq, 6, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
		_mhq setVariable ["ACE_isrepairVehicle", true];
	};

	_mhq addEventHandler ["Killed", {
		[{
			params ["_mhqOld"];
			removeAllActions _mhqOld;
			private _mhqInfo = (_mhqOld getVariable QGVAR(Info));
			if ((_mhqOld distance (_mhqInfo select 1)) < 50) then {
				deleteVehicle _mhqOld;
			};
			private _mhq = createVehicle [(_mhqInfo select 0), [0,0,0], [], 10, "NONE"];
			_mhq setPosATL (_mhqInfo select 1);
			_mhq setDir (_mhqInfo select 2);
			_mhq setVehicleVarName (_mhqInfo select 3);
			Call Compile Format ["%1 = _mhq; PublicVariable '%1';", (_mhqInfo select 3)];
			[_mhq, (_mhqInfo select 4)] call FUNC(Handler);
		}, _this, 5] call CBA_fnc_waitAndExecute;
	}];
}, _this, 1] call CBA_fnc_waitAndExecute;
