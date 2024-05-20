	// OKS_Vehicle_Patrol
	// [Trigger_1,4,0,"WHEELED",civilian] spawn OKS_Vehicle_Patrol
	if(HasInterface && !isServer) exitWith {};

	Params["_Area","_NumberOfVehicles","_Range","_Type","_Side"];
	Private ["_SafePos","_nearRoads","_road","_roadConnectedTo","_connectedRoad","_direction","_VehicleWaypoints","_SelectedVehicles","_Debug_Variable","_Dir","_Group"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];

	_Debug_Variable = false;
	_Dir = round(Random 360);

	switch (_Type) do {
		case "WHEELED": {
			_SelectedVehicles = _Vehicles select 0;
		};
		case "APC": {
			_SelectedVehicles = _Vehicles select 1;
		};
		case "TANK":{
			_SelectedVehicles = _Vehicles select 2;
		};
		default {
			_SelectedVehicles = _Vehicles select 0;
		};
	};

	Private _VehicleCount = [];
	For [{_i = 0}, {_i < _NumberOfVehicles}, {_i = _i + 1}] do {
		_VehicleCount append [_i];
	};

	For "_i" to (_NumberOfVehicles - 1) do {

		_VehicleClass = _SelectedVehicles call BIS_fnc_selectRandom;
		Private _Repetitions = 0;
		while {true} do {
			sleep 0.25;
			_Repetitions = _Repetitions + 1;
			_RandomPos = _Area call BIS_fnc_randomPosTrigger;
			private _Road = [_RandomPos, 300] call BIS_fnc_nearestRoad;
			_SafePos = getPos _Road;
			private _info = getRoadInfo _Road;
			_Dir = (_info select 6) getDir (_info select 7);
			if(_SafePos inArea _Area && ((getRoadInfo _Road) select 0) != "TRAIL") exitWith {};
			if(_Repetitions > 30) exitWith {};
		};

		sleep 5;
		If(!isNil "_Road") then {
			_SafePos = _Road;
			if(_Debug_Variable) then {
				SystemChat "Spawning Vehicle - Road Found";
			};
		};

		waitUntil{sleep 5; count (nearestObjects [_SafePos,["LandVehicle"],30]) <= 0 };
		_Vehicle = CreateVehicle [_VehicleClass, _SafePos, [], 0, "NONE"];
		if(GOL_Remove_HE_From_StaticAndVehicle) then {
			[_Vehicle] spawn OKS_RemoveVehicleHE;	
		};	
		_Vehicle setDir _Dir;

		// Count (TypeOf _Vehicle call BIS_fnc_AllTurrets) == 0
		if((_Vehicle emptyPositions "gunner" == 0 && _Side != civilian)) then {
			if(_Debug_Variable) then {
				SystemChat "Vehicle is a transport";
			};
			_CargoSeats = ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - (["TypeOf _Vehicle",false] call BIS_fnc_crewCount);
			if(_CargoSeats > 4) then { _CargoSeats = 4 };

			if(_Vehicle emptyPositions "cargo" > 0) then {
					_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

					[_Vehicle] spawn OKS_ForceVehicleSpeed;  
					if(_Debug_Variable) then {
						SystemChat "Creating Transport Cargo...";
					};

					///Create Leader
					_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
					_Unit setRank "SERGEANT";
					_Unit MoveInCargo _Vehicle;
					_Group selectLeader _Unit;

					sleep 0.5;

				for "_i" from 1 to (_CargoSeats - 1) do
				{
					Private "_Unit";
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,50], [], 0, "NONE"];
					_Unit setRank "PRIVATE";
					_Unit MoveInCargo _Vehicle;

					sleep 0.5;
				};
				_Group setBehaviour "SAFE";
				_Group setSpeedMode "Limited";
				_Group setVariable ["GW_Performance_autoDelete", false, true];
				_Group AllowFleeing 0;
				{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
			};
		}
		else
		{
			_Group = [_Vehicle,_Side] call OKS_AddVehicleCrew;

			[_Vehicle] spawn OKS_ForceVehicleSpeed;  
		};

		if(count units _Group > 1 || _Side == civilian) then {

			[_vehicle] spawn {
				Params["_Vehicle"];
				_vehicle forceSpeed 10;
				waitUntil {sleep 5; behaviour (driver _Vehicle) isEqualTo "COMBAT"};
				_vehicle forceSpeed -1;
			};

			[_Area,_Group,6] spawn OKS_Vehicle_Waypoints;
			_Group setBehaviour "SAFE";
		} else {
			deleteVehicle driver _Vehicle;
			deleteVehicle _vehicle;
			if(_Debug_Variable) then {
				systemChat "Only Driver Active - Removing Vehicle..";
			};
		};
	};