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

	if(isNil "_mhq") exitWith {
		"[DEBUG] MHQ Handler - MHQ was undefined." spawn OKS_fnc_LogDebug;
	};

	[QGVAR(Enabled), [_mhq, false]] call CBA_fnc_LocalEvent;
	_jipID = [QGVAR(Actions), [_mhq], format ["GW_MHQ_JIP_%1", _mhq]] call CBA_fnc_globalEventJIP;
	_mhq setVariable [QGVAR(Info), [(typeOf _mhq), (getPosATL _mhq), floor(getdir _mhq), (vehicleVarName _mhq), _type, _jipID], true];	// Store for respawn
	_mhq setVariable [QGVAR(Fuel), (fuel _mhq)];
	_mhq setVariable [QGVAR(Side), toLower(_side), true];
	_mhq setPlateNumber (vehicleVarName _mhq);

	// MHQ Marking Code
	private _mhqMarkerId = format["GOL_MHQ_Marker_%1",round(random 9999)];
	private _mhqMarkerAreaId = format["%1_Area",_mhqMarkerId];
	private _type = "respawn_inf";
	private _color = "colorBlufor";
	_mhq setVariable ["MHQ_MarkerId",_mhqMarkerId,true];
	if(_mhq isKindOf "Tank") then {
		_type = "respawn_armor";
	};
	if(_mhq isKindOf "Car") then {
		_type = "respawn_motor";
	};
	private _side = missionNamespace getVariable ["GOL_Friendly_Side",west];
	switch (toLower (str _side)) do {
		case "west": { _color = "colorBlufor"};
		case "east": { _color = "colorOpfor"};
		default {};
	};
	_mhqMarker = createMarker [_mhqMarkerId, _mhq];
	_mhqMarker setMarkerShape "ICON";
	_mhqMarker setMarkerType _type;
	_mhqMarker setMarkerText " Mobile HQ";
	_mhqMarker setMarkerColor _color;
	_mhqMarker setMarkerSize [0.8,0.8];
	_mhqMarker setMarkerAlpha 0;

	_mhqMarkerArea = createMarker [_mhqMarkerAreaId, _mhq];
	_mhqMarkerArea setMarkerShape "ELLIPSE";

	_SafeZone = missionNamespace getVariable ["GOL_MhqSafeZone",100];
	_mhqMarkerArea setMarkerSize [_SafeZone,_SafeZone];
	_mhqMarkerArea setMarkerColor _color;
	_mhqMarkerArea setMarkerAlpha 0;
	_mhqMarkerArea setMarkerBrush "Border";
	// End MHQ Marking Code

	if (true) then {
		_mhq setVariable ["ACE_isrepairVehicle", true, true];
		_mhq setVariable ["GOL_isMHQ",true, true];
		_mhq setVariable ["ace_repair_canRepair", 1, true];
		_mhq setVariable ["ace_isRepairFacility", 1, true];		
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Track", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;
		["ACE_Wheel", _mhq,true] call ace_cargo_fnc_loadItem;
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
