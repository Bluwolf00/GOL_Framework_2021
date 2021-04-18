/*
	Author: GuzzenVonLidl
	Cretes objects around a selected vehicle from a base template

	Usage:
	[mhq, "small"] call GW_MHQ_Fnc_prefabCreate;

	Arguments:
	0: MHQ <OBJECT>
	1: Objects to be created <ARRAY>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
if (!isServer) exitWith {false};

params ["_mhq"];

private _objects = [(_mhq getVariable QGVAR(Info)) select 4] call FUNC(getDeployType);
private _objectsCreated = [];
private _can = createVehicle ["Land_Compass_F", [0,0,0], [], 0, "CAN_COLLIDE"];

_can setDir (getdir _mhq);
_can setPosATL (getPos _mhq);

{
	_x params ["_type","_dir","_pos","_inventory"];
	_veh = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
	_veh setDir (_dir + (getdir _mhq));
	_veh setVehiclePosition [(_can modelToWorld _pos), [], 0, "CAN_COLLIDE"];
	_veh setVectorUp surfaceNormal position _veh;
	_veh enableSimulationGlobal false;
	_veh allowDamage false;
	if (count _x isEqualTo 4) then {
		[_veh, _inventory] call EFUNC(Gear,Init);
	};
	_objectsCreated pushBack _veh;
} forEach _objects;
_mhq setVariable [QGVAR(objectsCreated), _objectsCreated, true];
deleteVehicle _can;
