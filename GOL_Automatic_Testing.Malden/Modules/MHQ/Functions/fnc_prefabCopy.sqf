/*
	Author: GuzzenVonLidl
	Copies all selected objects in 3den editor to setup a prefab for a mhq
	NOTE: First object will only be used as center and will not be copied

	Usage:
	[] call GW_MHQ_Fnc_prefabCopy;

	Arguments: NO

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

if (isNil QGVAR(object)) then {
	["First object copied as a reference", 0, 5, true] call BIS_fnc_3DENNotification;
	GVAR(object) = ((get3DENSelected "object") select 0);
} else {
	private _CopyObjects = [];

	{
		if (!(_x isKindOf "CAManBase") && !(_x isEqualTo GVAR(object))) then {
			_pos = GVAR(object) worldToModel (position _x);
			_CopyObjects pushBack [(typeOf _x), round(getDir _x), _pos];
		};
	} forEach (get3DENSelected "object");

//	copyToClipboard str(_CopyObjects);
	copyToClipboard (("_return = ") + str(_CopyObjects) + (";"));

	[format ["%1 Objects copied relative to First Object", (count _CopyObjects)], 0, 5, true] call BIS_fnc_3DENNotification;
	GVAR(object) = objNull;
	_CopyObjects
};
