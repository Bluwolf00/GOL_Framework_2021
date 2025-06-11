/*
	Author: GuzzenVonLidl
	From array spawns objects and vehicles and adds them to a array

	Usage:
	[] call GW_Common_fnc_spawnObjects;

	Arguments:
	#0:	ARRAY - objects location and dir

	Return Value: <ARRAY>
	Objects spawned

	Public: NO
*/
#include "script_Component.hpp"

if (is3DEN) exitWith {
	_this call FUNC(spawn3DENObjects);
	false
};

private _objects = [];
{
	private "_object";
	_x params ["_class","_pos","_vectors","_specials",["_simpleObject", false]];
	_vectors params ["_vector","_vector3DEN"];
	if (_simpleObject) then {
		_object = _class createVehicleLocal [0,0,0];
		_object setPosWorld _pos;
		_model = ((getModelInfo _object) select 1);
		deleteVehicle _object;
		_object = createSimpleObject [_model, _pos];
	} else {
		_object = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
		_object setPosWorld _pos;
	};
	_object setDir (_vector select 2);
	[_object, (_vector select 0), (_vector select 1)] call BIS_fnc_setPitchBank;

	[_object, _specials] call FUNC(setAttributes);
	_objects pushBack _object;
} forEach _this;

_objects
