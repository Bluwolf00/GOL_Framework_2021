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

	// MHQ Marking Code
	_mhqMarkerId = format["GOL_MHQ_Marker_%1",round(random 9999)];
	_mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
	_mhq setVariable ["MHQ_MarkerId",_mhqMarkerId,true];
	private _type = "respawn_inf";
	private _color = "colorBlufor";
	if(_mhq isKindOf "Tank") then {
		_type = "respawn_armor";
	};
	if(_mhq isKindOf "Car") then {
		_type = "respawn_motor";
	};
	switch (_side) do {
		case "west": { _color = "colorBlufor"};
		case "east": { _color = "colorOpfor"};
		default { _color = "colorBlufor"};
	};
	_mhqMarker = createMarker [_mhqMarkerId, _mhq];
	_mhqMarker setMarkerShape "ICON";
	_mhqMarker setMarkerType _type;
	_mhqMarker setMarkerText " MHQ";
	_mhqMarker setMarkerColor _color;
	_mhqMarker setMarkerSize [0.8,0.8];
	_mhqMarker setMarkerAlpha 0;

	_mhqMarkerArea = createMarker [_mhqMarkerAreaId, _mhq];
	_mhqMarkerArea setMarkerShape "ELLIPSE";
	_mhqMarkerArea setMarkerSize [100,100];
	_mhqMarkerArea setMarkerColor _color;
	_mhqMarkerArea setMarkerAlpha 0;
	_mhqMarkerArea setMarkerBrush "Border";
	// End MHQ Marking Code

	if (GVARMAIN(mod_ACE3)) then {
		_mhq setVariable ["ACE_isrepairVehicle", true];
		_mhq setVariable ["GOL_isMHQ",true];
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;

		_fuelCan1 = "Land_CanisterFuel_F" createVehicle [0,0,0];
		[_fuelCan1,30] call ace_refuel_fnc_makeJerryCan;
		[_fuelCan1,_mhq,true] call ace_cargo_fnc_loadItem;
		_fuelCan2 = "Land_CanisterFuel_F" createVehicle [0,0,0];
		[_fuelCan2,30] call ace_refuel_fnc_makeJerryCan;
		[_fuelCan2,_mhq,true] call ace_cargo_fnc_loadItem;
	};

	_mhq addEventHandler ["Killed", {
		[{
			params ["_mhqOld"];
			removeAllActions _mhqOld;

			_mhqMarkerId = _mhqOld getVariable ["MHQ_MarkerId",""];
			_mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
			deleteMarker _mhqMarkerId;
			deleteMarker _mhqMarkerAreaId;
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
