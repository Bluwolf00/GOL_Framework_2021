/*
	OKS_Createobjectives

	[GetPos player,"sector",300,EAST,_Settings] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[GetPos player,"sector",300,EAST,_Settings] spawn OKS_CreateObjectives;

	[Position,TypeOfObjective,Range,EAST] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[Position,TypeOfObjective,Range,EAST] spawn OKS_CreateObjectives;
*/

if(!isServer) exitWith {};

	Params ["_Position","_TypeOfObjective","_Range","_Side"];
	private ["_marker","_Condition","_playerSide","_trg","_EnemySideString","_playerSideString","_playerColor","_Area","_SpawnPos","_Repetitions","_Debug_Variable"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];
	_Civilian Params ["_CivilianUnits","_HVT"];
	_Vehicles Params ["_Wheeled","_APC","_Tank","_Artillery","_Transport","_Supply"];

	_Debug_Variable = true;

	switch(typeName _Position) do {

		case "OBJECT":{
			_Area = _Position;
			_Position = getPos _Position;
		};
		default {

		}
	};

_playerSide = OKS_FRIENDLY_SIDE;

switch (_TypeOfObjective) do {

	case "sector": {

		switch(_playerSide) do {
			case west:{
				_playerSideString = "WEST";
				_playerColor = "ColorBLUFOR";
				_Condition = Format["%1 SEIZED",_playerSideString];
			};
			case independent:{
				_playerSideString = "GUER";
				_playerColor = "ColorIndependent";
				_Condition = Format["%1 SEIZED",_playerSideString];
			};
			case east:{
				_playerSideString = "EAST";
				_playerColor = "ColorEast";
				_Condition = Format["%1 SEIZED",_playerSideString];
			};
		};

		_marker = createMarker [format ["oks_Sector_Marker_%1",str round(random 80000 + random 9999)],_Position,0];
		_marker setMarkerShape "ELLIPSE";
		_marker setMarkerSize [_Range,_Range];
		_marker setMarkerDir 0;

		switch(_Side) do {
			case WEST:{
				_EnemySideString = "blufor";
			};
			case independent:{
				_EnemySideString = "independent";
			};
			case east:{
				_EnemySideString = "opfor";
			};
		};

		//systemChat format["Enemy Marker: color%1",_EnemySideString];
		_marker setMarkerColor format["color%1",_EnemySideString];
		_marker setMarkerBrush "SolidBorder";

		//systemChat str _Position;
		//systemChat format["Player Condition: %1",_Condition];
		_trg = createTrigger ["EmptyDetector", _Position, true];
		_trg setTriggerArea [_Range,_Range, 0, false];
		_trg setTriggerActivation [_Condition,"PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg setVariable ["isSectorTrigger",true];

		if(_Debug_Variable) then {
			systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		};
		_Task = [true,format["OKS_Sector_Objective_%1",(round(random 9000))], ["The Enemy is in control of this area. To secure the objective, you must seize the area and destroy the majority of enemy forces.", "Seize Sector", "Seize Sector"], getPos _trg,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"attack"] call BIS_fnc_taskSetType;

		//systemchat format ["%1 setMarkerColor '%2' - Task %3",_marker,_playerColor,_Task];
		_trg setTriggerStatements ["this", format ["'%1' setMarkerColor '%2'; ['%3','SUCCEEDED'] call BIS_fnc_taskSetState;",_marker,_playerColor,_Task], ""];


	};

	case "cache": {

		private ["_ammoCrate"];

		switch(_Side) do {
			case west: {
				_ammoCrate = "Box_FIA_Wps_F";
			};

			case east: {
				_ammoCrate = "Box_FIA_Wps_F";
			};

			case independent:{
				_ammoCrate = "Box_FIA_Wps_F";
			};
		};

		if(!isNull _Area) then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 12, 0, 0.1, 0] call BIS_fnc_findSafePos;
				if(_SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
				if(_Repetitions > 100) exitWith {};
			};
		} else {
			_SpawnPos = [_Position, 1, 100, 30, 0, 0, 0] call BIS_fnc_findSafePos;
		};

		if(_Repetitions > 100) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Cache Objective"} };
		_Crate = CreateVehicle [_ammoCrate, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "NONE"];
		_Crate setDir (random 360);
		_Crate setVehicleVarName format["OKS_Crate_%1",round(random 9999)];
		_Crate allowDamage true;
		_Crate enableSimulation true;
		_Crate setMass 9999;

		_AmmoCamp = selectRandom ["AmmoCampSite_1","AmmoCampSite_2"];
		[_AmmoCamp,getPos _Crate, [0,0,0], getDir _Crate] call LARs_fnc_spawnComp;
		_trg = createTrigger ["EmptyDetector", GetPos _Crate, true];
		_trg setTriggerArea [15000,15000,0,false,1000];
		_trg setTriggerActivation ["STATIC","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Crate];

		[_SpawnPos,_Side,(3 + (random 3)),15] spawn OKS_Populate_Sandbag;

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_Cache_Objective_%1",(round(random 9000))], ["The Enemy forces have access to weapons and ammunitions caches in the area of operations. Find them and destroy them.", "Destroy Ammo Cache", "Destroy Ammo Cache"], getPos _Crate,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"destroy"] call BIS_fnc_taskSetType;
		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];
		[_Crate getPos [25,(random 360)],5,150,_Side,_Units] spawn OKS_Patrol_Spawn;

	};

	case "ammotruck": {

		private ["_SupplyTruck","_Road","_RandomPos"];
		_SupplyTruck = selectRandom(_Supply);

		if(!isNull _Area) then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [getPos ([_RandomPos, 300] call BIS_fnc_nearestRoad), 1, 100, 15, 0.2, 0, 0] call BIS_fnc_findSafePos;

				if(_SpawnPos inArea _Area) exitWith {};
				if(_Repetitions > 30) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Ammo Truck Objective"}} ;
		_Truck = CreateVehicle [_SupplyTruck, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "NONE"];
		_Truck setDir (random 360);
		_Truck setVehicleVarName format["OKS_AmmoTruck_%1",round(random 9999)];

		_Group = CreateGroup _Side;
		_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
		_Unit setRank "SERGEANT";
		_Unit MoveInDriver _Truck;

		[_Truck] spawn {
			Params["_Vehicle"];
			_vehicle forceSpeed 10;
			waitUntil {sleep 5; behaviour (driver _Vehicle) isEqualTo "COMBAT"};
			_vehicle forceSpeed 15;
		};
		[_Area,_Group,6] spawn OKS_Vehicle_Waypoints;


		_trg = createTrigger ["EmptyDetector", GetPos _Truck, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Truck];
		_trg setTriggerArea [15000,15000,0,false,1000];

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_AmmoTruck_Objective_%1",(round(random 9000))], ["The Enemy forces have access to supply trucks in the area of operations. Intercept the truck and destroy it", "Destroy Supply Truck", "Destroy Supply Truck"], getPos _Truck,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

			[_Task,"truck"] call BIS_fnc_taskSetType;
			[_Task,[_Truck,true]] call BIS_fnc_taskSetDestination;
		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];


	};

	case "hvttruck": {

		private ["_Vehicles","_Road","_RandomPos","_CargoCount"];
		_Wheeled = selectRandom(_Transport);

		if(!isNull _Area) then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [getPos ([_RandomPos, 300] call BIS_fnc_nearestRoad), 1, 100, 15, 0.2, 0, 0] call BIS_fnc_findSafePos;

				if(_SpawnPos inArea _Area) exitWith {};
				if(_Repetitions > 30) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: HVT Truck Objective"}} ;
		_Truck = CreateVehicle [_Wheeled, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "NONE"];
		_Truck setDir (random 360);
		_Truck setVehicleVarName format["OKS_HVTTruck_%1",round(random 9999)];

		private _CargoSeats = (([TypeOf _Truck,true] call BIS_fnc_crewCount) - ([TypeOf _Truck,false] call BIS_fnc_crewCount) - 1);
		if(_CargoSeats > 6) then {_CargoSeats = 6};
		_Group = CreateGroup _Side;
		_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
		_Unit setRank "SERGEANT";
		_Unit MoveInDriver _Truck;

		for "_i" to (_CargoSeats - 1) do {
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
			_Unit setRank "PRIVATE";
			_Unit moveInAny _Truck;
		};

		[_Truck] spawn {
			Params["_Vehicle"];
			_vehicle forceSpeed 10;
			waitUntil {sleep 5; behaviour (driver _Vehicle) isEqualTo "COMBAT"};
			_vehicle forceSpeed 15;
		};
		[_Area,_Group,6] spawn OKS_Vehicle_Waypoints;

		_HVTGroup = CreateGroup _playerSide;
		_Civilian = _HVTGroup CreateUnit [(_HVT call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
		[_Civilian, true] call ACE_captives_fnc_setHandcuffed;
		_Civilian moveInCargo _Truck;
		_Civilian setCaptive true;
		_Civilian setBehaviour "CARELESS";
		_Civilian disableAI "MOVE";

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_HVTTruck_Objective_%1",(round(random 9000))], ["Intel suggests that an enemy officer is patrolling the area of operations and reviewing their positions. Take this opportunity to undermine their leadership. Capture the HVT alive and bring him to your base.", "Capture HVT", "Capture HVT"], getPos _Truck,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

		[_Task,"kill"] call BIS_fnc_taskSetType;
		[_Task,[_Civilian,true]] call BIS_fnc_taskSetDestination;

		_trg = createTrigger ["EmptyDetector", GetPos _Truck, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Civilian];
		_trg setTriggerArea [15000,15000,0,false,1000];

		_trg setTriggerStatements ["this", format ["['%1','FAILED'] call BIS_fnc_taskSetState;",_Task], ""];

		private "_base";
		switch(_playerSide) do {
			case west:{
				_base = getMarkerPos "respawn_west";
			};
			case independent:{
				_base = getMarkerPos "respawn_resistance";
			};
			case east:{
				_base = getMarkerPos "respawn_east";
			};
		};

		_exfil = createTrigger ["EmptyDetector", _base, true];
		_exfil setTriggerActivation ["VEHICLE","PRESENT",false];
		_exfil setTriggerTimeout [5, 7, 10, true];
		_exfil triggerAttachVehicle [_Civilian];
		_exfil setTriggerArea [200,200,0,false,5];
		_exfil setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];
	};

	case "artillery": {

		private ["_Road","_RandomPos","_Target","_SpawnPos","_Arty"];
		_Artillery = selectRandom(_Artillery);

		if(!isNull _Area) then {
			_Repetitions = 0;
			while{true} do {
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 15, 0, 0, 0] call BIS_fnc_findSafePos;
				if(_Repetitions > 100) exitWith {};

				if(_Debug_Variable) then {
					systemChat str [_SpawnPos inArea _Area,{_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1,{_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1,{_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1]
				};
				if(_SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0.1, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Artillery Objective"}};
		if(_SpawnPos distance [0,0,0] < 300) exitWith { if(_Debug_Variable) then {SystemChat "Location found near SW edge of map. Exiting..."}};

		_Arty = CreateVehicle [_Artillery, [_SpawnPos select 0,_SpawnPos select 1,1], [], 0, "NONE"];
		_Arty setDir (random 360);
		_trg = createTrigger ["EmptyDetector", GetPos _Arty, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Arty];
		_trg setTriggerArea [15000,15000,0,false,1000];

		_Task = [true,format["OKS_Artillery_Objective_%1",(round(random 9000))], ["The Enemy have set up artillery positions that shell nearby friendly positions. Locate the artillery and spike it! Destroy to complete.", "Destroy Artillery", "Destroy Artillery"], getPos _Arty,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

			[_Task,"destroy"] call BIS_fnc_taskSetType;
			[_Task,[_Arty,true]] call BIS_fnc_taskSetDestination;
			[_Arty getPos [25,(random 360)],5,150,_Side,_Units] spawn OKS_Patrol_Spawn;

		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];

		if(!isNil "OKS_ArtyFire") then {

			switch(_playerSide) do {
				case west:{
					_Target = getMarkerPos "respawn_west";
				};

				case east:{
					_Target = getMarkerPos "respawn_east";
				};

				case independent:{
					_Target = getMarkerPos "respawn_resistance";
				};
			};
			sleep 10;
			if(_Debug_Variable) then {
				systemChat "RemoteExec Artillery..";
			};
			[_Side,_Arty,_Target,6,300,30,true] remoteExec ["OKS_ArtyFire",0];
		} else {

			createVehicleCrew _Arty;

		};

		["ArtilleryCamp",getPos _Arty, [0,0,0], getDir _Arty] call LARs_fnc_spawnComp;
		sleep 5;
		[getPos _Arty,_Side,(random 4),15] spawn OKS_Populate_Sandbag;
		[getPos _Arty,40,_Side] spawn OKS_Populate_StaticWeapons;
	 	[getPos _Arty,_Side,(3+(round random 4)),40] spawn OKS_Populate_Bunkers;

	};

		default{

		};
	};