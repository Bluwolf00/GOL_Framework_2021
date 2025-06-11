/*
	Author: GuzzenVonLidl

	Usage:
	["paradrop", [_group, Vehicle_1]] call GW_Common_Fnc_setGroupAction;

	Arguments:
	0: Event <STRING>
	2: Custom Variable <ARRAY,STRING,BOOL,NUMBER,GROUP,OBJECT>

	Return Value: BOOL

	Public: NO
*/
#include "script_Component.hpp"

if !(canSuspend) exitWith {
	_this spawn FUNC(setGroupAction);
};

params [
	["_mode", ""],
	"_custom"
];

switch (_mode) do {
	case "lights": {		// 80% chanse for each unit in the group to enable flashlight/laser
		{
			if (random 1 > 0.8) then {
				_x enableGunLights true;
			};
		} forEach (units _custom);
	};

	case "paradrop": {		// Does paradrop from vehicle
		_custom params [
			["_group", grpNull],
			["_veh", objNull],
			["_steerable", true]
		];

		if (_veh isKindOf "CAManBase") then {
			_veh = (objectParent _veh);
		};

		_class = "NonSteerable_Parachute_F";
		if (_steerable) then {
			_class = "Steerable_Parachute_F";
		};
		(boundingBoxReal _veh) params ["_p1","_p2"];
		_maxLength = abs ((_p2 select 1) - (_p1 select 1));
		_maxHeight = abs ((_p2 select 2) - (_p1 select 2));

		{
			_unit = _x;
			_pos = (_veh getRelPos [_maxLength, 180]);
			_pos set [2, ((getPosATL _veh) select 2) - _maxHeight - 1];
			_chute = createVehicle [_class, [0,0,0], [], 0, "FLY"];
			_chute setPosATL _pos;
			_chute setDir ((getDir _veh));
			_unit moveIndriver _chute;
			_delay = 1.5;
			if ((speed _veh) > 150) then {
				_delay = 1;
				if ((speed _veh) > 300) then {
					_delay = 0.7;
					if ((speed _veh) > 400) then {
						_delay = 0.4;
					};
				};
			};
			sleep _delay;
		} forEach (units _group);
	};

	case "rndWaypoints": {
		_custom params [
			["_group", grpNull],
			["_radius", 150]
		];

		_countWP = round(random [5, 8, 11]);
		_waypointList = [];
		if (_radius < 30) then {
			_radius = 30;
		};

		for "_i" from 0 to _countWP do {
			_waypointList pushBack ([getPos (leader _group), 25, _radius, 3, 0, 20, 0] call BIS_fnc_findSafePos);
		};

		for "_i" from 0 to _countWP do {
			_wp = _group addWaypoint [(_waypointList select _i), 0];
			_wp setWaypointCombatMode "YELLOW";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointSpeed "LIMITED";
			_wp setWaypointCompletionRadius 15;
			if (_countWP isEqualTo _i) then {
				_wp setWaypointType "CYCLE";
				_wp setWaypointPosition [[0,0,0], 0];
			} else {
				_wp setWaypointType "MOVE";
			};
		};
	};

	case "groupFlee": {		// Make the entire group escape from current situation, once complete will call event "GW_Common_groupFlee" to customize each group individually
//		[QGVAR(groupFlee), []] call CBA_fnc_localEvent;
	};

	default {
	};
};

true
