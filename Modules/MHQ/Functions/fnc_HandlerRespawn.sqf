/*
	Author: GuzzenVonLidl
	Moves all players to first assembled mhq upon respawn
	Blacklisted will players will not be affected

	Usage:
	[player] call GW_MHQ_Fnc_HandlerRespawn;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
#define	BLACKLIST ["echo1","echo2","echo3","echo4","echo4","echo5","echo6"]

params [["_unit", objNull, [objNull]]];
if (!(isPlayer _unit) && !(local _unit)) exitWith {false};
if (([format ["%1", _unit], 1] call BIS_fnc_trimString) in BLACKLIST) exitWith {false};

{
	if ((_x getVariable QGVAR(Side)) isEqualTo toLower(str([_unit] call EFUNC(Common,getSide)))) exitWith {
		(boundingBoxReal _x) params ["_p1","_p2"];
		_maxLength = abs ((_p2 select 1) - (_p1 select 1));
		_pos = (_x getRelPos [_maxLength + 2, 180]);
		_pos set [2, ((getPos _x) select 2)];
		_unit setPosATL _pos;
		_unit setDir (getDir _x) + 180;
	};
} count GVAR(AssembledArray);
