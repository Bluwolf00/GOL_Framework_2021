/*
	AUTHOR: GuzzenVonLidl
	Collects all positions and selects a random one to place a unit in

	Usage:
	[] call GW_Common_Fnc_spawn3DEN;

	Parameters:
	#0	OBJECT || STRING || ARRAY:	Center Location of buildings/positions
	#1	NUMBER:	Radius of area	(Optional: Default: 50)
	#2	NUMBER:	Amount of ai spawn

	Return Value: <GROUP>
	Group that spawned

	Public: NO
*/
#include "script_Component.hpp"

params ["_units","_vehicles","_waypoints"];

collect3DENHistory {
	([GVAR(Faction)] call FUNC(getGroupType)) params ["_side", "_leader","_unitList"];
	{
		_x params ["_pos","_dir"];
		_unitClass = (selectRandom _unitList);
		if (isNil QGVAR(spawn)) then {
			_unit = create3DENEntity ["Object", _unitClass, [0,0,0]];
			_unit set3DENAttribute ["position", _pos];
			_unit set3DENAttribute ["rotation", [0,0,_dir]];
			GVAR(spawn) = _unit;
		} else {
			_unit = (group GVAR(spawn)) create3DENEntity ["Object", _unitClass, [0,0,0]];
			_unit set3DENAttribute ["position", _pos];
			_unit set3DENAttribute ["rotation", [0,0,_dir]];
		};
		[_unit, _specials] call FUNC(setAttributes3DEN);
	} forEach _units;

	{
		_x params ["_class","_pos","_dir","_crew","_specials", "_veh"];
		if (isNil QGVAR(spawn)) then {
			_veh = create3DENEntity ["Object", _class, [0,0,0],true];
			_veh set3DENAttribute ["position", _pos];
			_veh set3DENAttribute ["rotation", [0,0,_dir]];
			GVAR(spawn) = _veh;
		} else {
			_veh = create3DENEntity ["Object", _class, [0,0,0],true];
			_veh set3DENAttribute ["position", _pos];
			_veh set3DENAttribute ["rotation", [0,0,_dir]];
		};

		{
			_x params ["_vehPos","_turretPos"];
			_unitClass = (selectRandom _unitList);
			if (isNil QGVAR(spawn)) then {
				_unit = create3DENEntity ["Object", _unitClass, [0,0,0]];
				_unit set3DENAttribute ["position", _pos];
				_unit set3DENAttribute ["rotation", [0,0,_dir]];
				GVAR(spawn) = _unit;
			} else {
				_unit = (group GVAR(spawn)) create3DENEntity ["Object", _unitClass, [0,0,0]];
				_unit set3DENAttribute ["position", _pos];
				_unit set3DENAttribute ["rotation", [0,0,_dir]];
			};
//			_unit moveInDriver _veh;	// Bi fucked this
		} forEach _crew;

		[_unit, _specials] call FUNC(setAttributes3DEN);
	} forEach _vehicles;

	{
		_waypointType = "Move";
		_x params ["_pos","_waypointConfigs"];
		{
			_x params ["_type","_setting"];
			switch (_type) do {
				case 0: {
					_waypointType = _setting;
				};
			};
		} forEach _waypointConfigs;

		_wp = (group GVAR(spawn)) create3DENEntity ["Waypoint", _waypointType, _pos];

		{
			_x params ["_type","_setting"];
			switch (_type) do {
				case 1: {
					_wp set3DENAttribute ["behaviour", _setting];
				};
				case 2: {
					_wp set3DENAttribute ["combatMode", _setting];
				};
				case 3: {
					_wp set3DENAttribute ["completionRadius", _setting];
				};
				case 4: {
					_setting = ["NO CHANGE","WEDGE","VEE","LINE","COLUMN","FILE","STAG COLUMN","ECH LEFT","ECH RIGHT","DIAMOND"] find _setting;
					_wp set3DENAttribute ["formation", _setting];
				};
				case 5: {
					_setting = ["UNCHANGED","LIMITED","NORMAL","FULL"] find _setting;
					_wp set3DENAttribute ["speedMode", _setting];
				};
				case 6: {
					_wp set3DENAttribute ["timeout", _setting];
				};
				case 7: {
					_wp set3DENAttribute ["condition", _setting select 0];
					_wp set3DENAttribute ["onActivation", _setting select 1];
				};
			};
		} forEach _waypointConfigs;
	} forEach _waypoints;
};

GVAR(spawn) = nil;
