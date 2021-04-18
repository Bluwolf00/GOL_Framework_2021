/*
	Author: GuzzenVonLidl
	From array spawns Units in a group, vehicles are spawned and ocupied by group and waypoints are added

	Usage:
	[] call GW_Common_fnc_spawnHandler;

	Arguments:
	#0:	ARRAY - A shit ton of multidimensional arrays

	Return Value: <GROUP>

	Public: NO
*/
#include "script_Component.hpp"

if !(canSuspend) exitWith {
	_this spawn FUNC(spawnHandler);
	false
};

params [
	["_unitArray", []],
	["_vehicleArray", []],
	["_waypointArray", []],
	["_skipQueue", false],
	["_skipDelays", false],
	["_group", grpNull]
];

if (GVAR(spawnActive) && !_skipQueue) exitWith {
	GVAR(SpawnQueue) pushBack _this;
	false
};

if (GVAR(autoQueue) && !_skipQueue) then {
	GVAR(spawnActive) = true;
};

([GVAR(Faction)] call FUNC(getGroupType)) params ["_side", "_leader","_unitList"];

if (_group isEqualTo grpNull) then {
	_group = CreateGroup _side;
	_group setVariable [QEGVAR(Performance,autoDelete), false];
};

if !((count _unitArray) isEqualTo 0) then {
	private _unitClass = _leader;
	{
		_x params ["_pos","_dir",["_unitPos", [], [[],""]],["_specials", []]];
		if !(_forEachIndex isEqualTo 0) then {
			_unitClass = (selectRandom _unitList);
		};
		_unit = _group createUnit [_unitClass, [0,0,0], [], 10, "CAN_COLLIDE"];
		_unit enableSimulationGlobal false;
		_unit setRank "PRIVATE";
		_unit setPosATL _pos;
		_unit setVariable [QGVAR(isSpawned), true];
		_unit disableAI "MINEDETECTION";
		TRACE_1("Created", _unit);

		if (_unitPos isEqualType "") then {
			[QGVAR(disableAICommand), _unit] call CBA_fnc_localEvent;

			_unit setFormDir _dir;
			_unit setDir _dir;
			sleep 0.1;
			_unit setDir _dir;

			if (_unitPos isEqualTo "Auto") then {
				_unit setUnitPos (selectRandom ["Up","Middle"]);
			} else {
				_unit setUnitPos _unitPos;
			};
			doStop _unit;
		};

		_unit setPosATL _pos;
		[_unit, ([_unitPos, _specials] select (_unitPos isEqualType ""))] call FUNC(setAttributes);

		if !(_skipDelays) then {
			sleep 0.9;
		};
		_unit enableSimulationGlobal true;
	} forEach _unitArray;
};

if ((count _vehicleArray) > 0) then {
	private _vehicleList = [];

	{
		_x params ["_class","_pos","_dir","_crewList",["_specials", []]];
		private _collision = "CAN_COLLIDE";
		if (_pos select 2 > 20) then {
			_collision = "FLY";
		};
		_vehicle = createVehicle [_class, _pos, [], 0, _collision];
		_vehicle setDir _dir;
		_vehicle setPosATL _pos;
		_vehicle setVectorUp surfaceNormal (position _vehicle);
		_pos set [2, (_pos select 2) + 0.3];
		_vehicle setPosATL _pos;
		_group addVehicle _vehicle;

		if (GVAR(AutoLock)) then {
			_vehicle setVehicleLock "LOCKEDPLAYER";
		};

		if (_waypointArray isEqualTo []) then {
			_vehicle setFuel 0;
			_vehicle allowCrewInImmobile true;
		};

		if (_collision isEqualTo "FLY") then {
			_vehicle engineOn true;
			_vehicle flyInHeight (_pos select 2);
		};

		_vehicle setVariable [QEGVAR(gear,side), GVAR(Faction)];

		[_vehicle, _specials] call FUNC(setAttributes);
		_vehicleList pushBack [_vehicle, _crewList];
		TRACE_1("Created", _vehicle);

		if (_crewList isEqualTo []) then {
			{
				_crewList pushBack [(_x select 1), (_x select 2), (_x select 3)];
			} forEach ((fullCrew [_vehicle,"",true]) select {((_x select 1) in ["commander","gunner","turret"])});
		};

		_unitClass = _leader;

		{
			if !(count (units _group) isEqualTo 0) then {
				_unitClass = (selectRandom _unitList);
			};

			_unit = _group createUnit [_unitClass, [0,0,0], [], 10, "CAN_COLLIDE"];
			_unit enableSimulationGlobal false;
			_unit setRank "PRIVATE";
			_unit setVariable [QGVAR(isSpawned), true];
			TRACE_1("Created", _unit);
			switch (toLower(_x select 0)) do {
				case "driver": {
					_unit moveInDriver _vehicle;
				};
				case "commander": {
					_unit moveInCommander _vehicle;
				};
				case "gunner": {
					_unit moveInGunner _vehicle;
				};
				case "turret": {
					_unit moveInTurret [_vehicle, (_x select 2)];
				};
				case "cargo": {
					_unit moveInCargo [_vehicle, (_x select 1)];
				};
			};
			_unit enableSimulationGlobal true;
			TRACE_2("Unit Moved to", _vehicle, _x);
			if !(_skipDelays) then {
				sleep 1;
			};
		} forEach _crewList;
		TRACE_1("Units added to vehicle", _groupNew);
		if (((count _vehicleArray) > 1) && !_skipDelays) then {
			sleep 5;
		};
		TRACE_1("Created Finished", _vehicle);
	} forEach _vehicleArray;
};

if !(_waypointArray isEqualTo []) then {

	{
		_x params [["_position",[0,0,0]], ["_attributes",[]]];
		private _waypoint = _group addWaypoint [_position, 0];
		_waypoint setWaypointCompletionRadius 10;	// Sets default

		{
			_x params ["_type","_setting"];
			switch (_type) do {
				case 0: {
					_waypoint setWaypointType _setting;
				};
				case 1: {
					_waypoint setWaypointBehaviour _setting;
				};
				case 2: {
					_waypoint setWaypointCombatMode _setting;
				};
				case 3: {
					_waypoint setWaypointCompletionRadius _setting;
				};
				case 4: {
					_waypoint setWaypointFormation _setting;
				};
				case 5: {
					_waypoint setWaypointSpeed _setting;
				};
				case 6: {
					_waypoint setWaypointTimeout _setting;
				};
				case 7: {
					_waypoint setWaypointStatements _setting;
				};
			};
		} forEach _attributes;

	} forEach _waypointArray;
	TRACE_2("Waypoints added to ", _group, (waypoints _group));
};

if (GVAR(autoQueue) && !_skipQueue) then {
	GVAR(spawnActive) = false;
	if ((count GVAR(SpawnQueue)) > 0) then {
		(GVAR(SpawnQueue) select 0) spawn FUNC(spawnHandler);
		GVAR(SpawnQueue) deleteAt 0;
	};
};

_group setVariable [QEGVAR(Performance,autoDelete), true];

_group
