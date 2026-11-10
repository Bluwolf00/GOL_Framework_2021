/*
	AUTHOR: GuzzenVonLidl
	Collects all positions and selects a random one to place a unit in

	Usage:
	[] call GW_Common_Fnc_spawn3DENObjects;

	Parameters:
	#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
	#1	NUMBER:	Radius of area	(Optional: Default: 50)
	#2	NUMBER:	Amount of ai spawn

	Return Value: <GROUP>
	Group that spawned

	Public: NO
*/
#include "script_Component.hpp"

collect3DENHistory {
	{
		_x params ["_class","_pos","_vector","_specials",["_simpleObject", false]];
		_obj = create3DENEntity ["Object", _class,[0,0,0], true];
		_obj setPosWorld _pos;
		_obj set3DENAttribute ["position", (getPosATL _obj)];
		_obj set3DENAttribute ["rotation", (_vector select 1)];
		_obj set3DENAttribute ["objectIsSimple", _simpleObject];

		[_obj, _specials] call FUNC(setAttributes3DEN);
	} forEach _this;
};

true
