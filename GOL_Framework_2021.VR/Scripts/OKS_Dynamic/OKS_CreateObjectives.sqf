/*
	OKS_Createobjectives
	Params: Position, Type, Range, Side, Patrols?

	[GetPos player,"sector",300,EAST,false] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[GetPos player,"sector",300,EAST,false] spawn OKS_CreateObjectives;

	[Position,TypeOfObjective,Range,EAST,Patrols?] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[Position,TypeOfObjective,Range,EAST,Patrols?] spawn OKS_CreateObjectives;
*/

if(!isServer) exitWith {};

	Params ["_Position","_TypeOfObjective","_Range","_Side","_ObjectivePatrols"];
	private ["_marker","_Condition","_playerSide","_trg","_EnemySideString","_playerSideString","_playerColor","_Area","_SpawnPos","_Repetitions","_Debug_Variable"];

	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];
	_Civilian Params ["_CivilianUnits","_HVT"];
	_Vehicles Params ["_Wheeled","_APC","_Tank","_Artillery","_Helicopter","_Transport","_Supply","_AntiAir"];

	_Debug_Variable = false;

	switch(typeName _Position) do {
		case "OBJECT":{
			_Area = _Position;
			_Position = getPos _Position;
		};
		default {

		}
	};

switch (_TypeOfObjective) do {

	case "sector": {

		switch(OKS_FRIENDLY_SIDE) do {
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

		if(_Debug_Variable) then {systemChat format["Enemy Marker: color%1",_EnemySideString]};
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
			systemChat format["OKS_Sector_Objective: Player %1 - Enemy %2 - Condition %3",_playerSideString,_EnemySideString,_Condition];
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

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos;

				if((_SpawnPos nearRoads 35) isEqualTo [] && !(_SpawnPos isFlatEmpty  [-1, -1, 0.07, 20, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
				if(_Repetitions > 100) exitWith {};
			};
		} else {
			_SpawnPos = [_Position, 1, 100, 30, 0, 0, 0] call BIS_fnc_findSafePos;
		};

		if(_Repetitions > 100) exitWith { systemChat "Unable to find position: Cache Objective" };

		OKS_Objective_Positions pushBackUnique _SpawnPos;
		publicVariable "OKS_Objective_Positions";

		_Crate = CreateVehicle [_ammoCrate, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "NONE"];
		_Crate setDir (random 360);
		_Crate setVehicleVarName format["OKS_Crate_%1",round(random 9999)];
		_Crate allowDamage true;
		_Crate enableSimulation true;
		_Crate setMass 9999;

		_AmmoCamp = selectRandom ["AmmoCampSite_1","AmmoCampSite_2","AmmoCampSite_3","Bunker_2","Bunker_3","Bunker_4"];
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

		if(_ObjectivePatrols) then {
			[_Crate getPos [25,(random 360)],5,150,_Side,_Units] spawn OKS_Patrol_Spawn;
		};
	};

	case "motorpool": {

		private ["_SupplyTruck","_Repetitions","_Crate","_SpawnPos","_trg","_Task"];

		_SupplyTruck = selectRandom _Supply;

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos;
				if((_SpawnPos nearRoads 35) isEqualTo [] && !(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 5, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
				if(_Repetitions > 50) exitWith {};
			};
		} else {
			_Repetitions = 0;
			_SpawnPos = [_Position, 1, 100, 30, 0, 0, 0] call BIS_fnc_findSafePos;
		};

		if(_Repetitions > 50) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Motor Pool Objective"} };

		OKS_Objective_Positions pushBackUnique _SpawnPos;
		publicVariable "OKS_Objective_Positions";
		_Crate = CreateVehicle [_SupplyTruck, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "NONE"];
		_Crate setDir (random 360);
		_Crate setVehicleVarName format["OKS_MotorPool_%1",round(random 9999)];
		_Crate allowDamage true;
		_Crate enableSimulation true;

		_AmmoCamp = selectRandom ["AmmoCampSite_3"];
		[_AmmoCamp,getPos _Crate, [0,0,0], getDir _Crate] call LARs_fnc_spawnComp;
		_trg = createTrigger ["EmptyDetector", GetPos _Crate, true];
		_trg setTriggerArea [15000,15000,0,false,1000];
		_trg setTriggerActivation ["STATIC","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Crate];
		SystemChat str _SpawnPos;
		[_SpawnPos,_Side,(3 + (random 3)),15] spawn OKS_Populate_Sandbag;

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_MotorPool_Objective_%1",(round(random 9000))], ["The Enemy forces use a motor pool located in the area of operations to resupply and repair their combat vehicles. Move in on the position and destroy the motorpool.", "Destroy Motorpool", "Destroy Motorpool"], getPos _Crate,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"refuel"] call BIS_fnc_taskSetType;
		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];

		if(_ObjectivePatrols) then {
			[_Crate getPos [25,(random 360)],4,150,_Side,_Units] spawn OKS_Patrol_Spawn;
			[_Crate getPos [25,(random 360)],4,150,_Side,_Units] spawn OKS_Patrol_Spawn;
		};
	};

	case "ammotruck": {

		private ["_SupplyTruck","_Road","_RandomPos"];
		_SupplyTruck = selectRandom(_Supply);

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				private _Road = [_RandomPos, 300] call BIS_fnc_nearestRoad;
				_SpawnPos = getPos _Road;
				if(_SpawnPos inArea _Area) exitWith {};
				if(_Repetitions > 30) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 5, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 50) exitWith { systemChat "Unable to find position: Ammo Truck Objective" };

		OKS_Objective_Positions pushBackUnique _SpawnPos;
		publicVariable "OKS_Objective_Positions";

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

	case "radiotower": {

		private ["_towerclass","_Repetitions","_Tower","_SpawnPos","_trg","_Task"];

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 0.05, 0, 0, 0] call BIS_fnc_findSafePos;
				if((_SpawnPos nearRoads 25) isEqualTo [] && !(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 5, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
				if(_Repetitions > 50) exitWith {};
			};
		} else {
			_Repetitions = 0;
			_SpawnPos = [_Position, 1, 100, 30, 0, 0, 0] call BIS_fnc_findSafePos;
		};

		OKS_Objective_Positions pushBackUnique _SpawnPos;
		publicVariable "OKS_Objective_Positions";

		if(_Repetitions > 50) exitWith { systemChat "Unable to find position: Radio Tower Objective" };

		_towerclass = selectRandom ["radiotower_1"];

		systemChat str [_towerclass,_SpawnPos];
		[_towerclass,[_SpawnPos select 0,_SpawnPos select 1,0], [0,0,0], random 360] call LARs_fnc_spawnComp;
		sleep 2;
		_Tower = nearestObject [_SpawnPos, "Land_Vysilac_FM"];
		systemChat str _Tower;
		_Tower setVehicleVarName format["OKS_RadioTower_%1",round(random 9999)];
		_Tower allowDamage true;
		_Tower enableSimulation true;

		[_SpawnPos,_Side,(3 + (random 3)),15] spawn OKS_Populate_Sandbag;

		_Task = [true,format["OKS_RadioTower_Objective_%1",(round(random 9000))], ["The Enemy forces have installed a radio tower in the area to boost their signal to relay information and request support. Destroy the radio tower.", "Sabotage Radio Tower", "Sabotage Radio Tower"], getPos _Tower,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

		[_Task,"radio"] call BIS_fnc_taskSetType;

		if(_ObjectivePatrols) then {
			[_SpawnPos getPos [25,(random 360)],3,150,_Side,_Units] spawn OKS_Patrol_Spawn;
			[_SpawnPos getPos [25,(random 360)],3,150,_Side,_Units] spawn OKS_Patrol_Spawn;
		};
		[_Tower,_Task] spawn { waitUntil{sleep 10; !Alive (_this select 0) || getDammage (_this select 0) > 0.8}; [_this select 1,'SUCCEEDED'] call BIS_fnc_taskSetState };
	};

	case "hvttruck": {

		private ["_Vehicles","_Road","_RandomPos","_CargoCount"];
		_Wheeled = selectRandom(_Transport);

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				sleep 0.25;
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				private _Road = [_RandomPos, 300] call BIS_fnc_nearestRoad;
				_SpawnPos = getPos _Road;
				if(_SpawnPos inArea _Area && !(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 15, 0] isEqualTo [])) exitWith {};
				if(_Repetitions > 30) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: HVT Truck Objective"}};

		if(_Debug_Variable) then { systemChat format ["Spawning %1 at %2",_Wheeled,_SpawnPos]; };
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

		_HVTGroup = CreateGroup _Side;
		_Civilian = _HVTGroup CreateUnit [(_HVT call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
		[_Civilian, true] call ACE_captives_fnc_setHandcuffed;
		_Civilian setVariable ["ace_map_hideBlueForceMarker", true, true];
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
		switch(OKS_FRIENDLY_SIDE) do {
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

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 10, 0, 0, 0] call BIS_fnc_findSafePos;
				if(_Repetitions > 100) exitWith {};

				if(_Debug_Variable) then {
					systemChat str [_SpawnPos inArea _Area,{_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1,{_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1,{_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1]
				};
				if((_SpawnPos nearRoads 35) isEqualTo [] && !(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 10, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 10, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Artillery Objective"}};
		if(_SpawnPos distance [0,0,0] < 300) exitWith { if(_Debug_Variable) then {SystemChat "Location found near SW edge of map. Exiting..."}};
		OKS_Objective_Positions pushBackUnique _SpawnPos;

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

			if(_ObjectivePatrols) then {
				[_Arty getPos [25,(random 360)],5,150,_Side,_Units] spawn OKS_Patrol_Spawn;
			};

		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];

		if(!isNil "OKS_ArtyFire") then {
			switch(OKS_FRIENDLY_SIDE) do {
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
			[_Side,_Arty,_Target,8,300,30] remoteExec ["OKS_ArtyFire",0];
		} else {
			createVehicleCrew _Arty;
		};

		["ArtilleryNest",getPos _Arty, [0,0,0], getDir _Arty] call LARs_fnc_spawnComp;
		sleep 5;
		[getPos _Arty,_Side,(round random 4),15] spawn OKS_Populate_Sandbag;
		[getPos _Arty,40,_Side] spawn OKS_Populate_StaticWeapons;
	 	//[getPos _Arty,_Side,(1+(round random 3)),40] spawn OKS_Populate_Bunkers;
	};

	case "antiair": {

		private ["_Road","_RandomPos","_Target","_SpawnPos","_AA"];
		_AntiAir = selectRandom(_AntiAir);

		if(!isNil "_Area") then {
			_Repetitions = 0;
			while{true} do {
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 10, 0, 0, 0] call BIS_fnc_findSafePos;
				if(_Repetitions > 100) exitWith {};

				if(_Debug_Variable) then {
					systemChat str [_SpawnPos inArea _Area,{_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1,{_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1,{_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1]
				};
				if((_SpawnPos nearRoads 35) isEqualTo [] && !(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 10, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 10, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(_Repetitions > 30) exitWith { if(_Debug_Variable) then {systemChat "Unable to find position: Artillery Objective"}};
		if(_SpawnPos distance [0,0,0] < 300) exitWith { if(_Debug_Variable) then {SystemChat "Location found near SW edge of map. Exiting..."}};
		OKS_Objective_Positions pushBackUnique _SpawnPos;
		_AA = CreateVehicle [_AntiAir, [_SpawnPos select 0,_SpawnPos select 1,1], [], 0, "NONE"];
		_AA setDir (random 360);
		_trg = createTrigger ["EmptyDetector", GetPos _AA, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_AA];
		_trg setTriggerArea [15000,15000,0,false,1000];

		_Task = [true,format["OKS_AntiAir_Objective_%1",(round(random 9000))], ["The Enemy have set up anti-air positions that engage our air assets. Locate the anti-air and neutralize it!", "Destroy Anti-Air", "Destroy Anti-Air"], getPos _AA,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

			[_Task,"destroy"] call BIS_fnc_taskSetType;
			[_Task,[_AA,true]] call BIS_fnc_taskSetDestination;

			if(_ObjectivePatrols) then {
				[_AA getPos [25,(random 360)],5,150,_Side,_Units] spawn OKS_Patrol_Spawn;
			};

		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];

		if(!isNil "GW_Ambient_AAA") then {
			if(_Debug_Variable) then {
				systemChat "RemoteExec GW Ambient AAA..";
			};
			[_AA,_Side,3,false,1000] remoteExec ["GW_Ambient_AAA",0];
		} else {
			createVehicleCrew _AA;
		};
		sleep 2;
		["AntiAir_1",getPos _AA, [0,0,0], getDir _AA] call LARs_fnc_spawnComp;
		sleep 3;
		[getPos _AA,_Side,(round random 4),15] spawn OKS_Populate_Sandbag;
		[getPos _AA,40,_Side] spawn OKS_Populate_StaticWeapons;
		_Objects = nearestObjects [getpos _AA,[],35];
		_Objects = _Objects select { getPos _X select 2 > 0 && !(_X isKindOf "MAN") && !(_X isKindOf "StaticWeapon")};
		{_X setPos [getPos _X select 0,getpos _X select 1,-0.1]; _X setVectorUp [0,0,1] } foreach _Objects;
	 	//[getPos _Arty,_Side,(1+(round random 3)),40] spawn OKS_Populate_Bunkers;
	};

	case "hostage": {

		private ["_House","_GarrisonMaxSize","_GarrisonPositions","_Target","_HostageGroup","_Repetitions","_Task"];
		_Repetitions = 0;
		if(!isNil "_Area") then {
			while{true} do {
				_Repetitions = _Repetitions + 1;
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_House = nearestBuilding _RandomPos;
				_GarrisonPositions = [_House] call BIS_fnc_buildingPositions;
				_GarrisonMaxSize = count _GarrisonPositions;
				if(_Debug_Variable) then {systemChat format["Trigger - Finding Position - %1",_House]};
				if(_Repetitions > 30 || (_GarrisonMaxSize > 8 && _House inArea _Area && !(isObjectHidden _House) && !(_House getVariable ["OKS_HostageObjective",false]) && !(_House getVariable ["OKS_isGarrisoned",false]))) exitWith {};

				//if(!(_SpawnPos isFlatEmpty  [-1, -1, 0.05, 35, 0] isEqualTo []) && _SpawnPos inArea _Area && {_SpawnPos distance _X < 200} count OKS_Objective_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_Mortar_Positions < 1 && {_SpawnPos distance _X < 200} count OKS_RoadBlock_Positions < 1) exitWith {};
			};
		} else {
			_House = nearestBuilding _Position;
			_GarrisonPositions = [_House] call BIS_fnc_buildingPositions;
			_GarrisonMaxSize = count _GarrisonPositions;
			if(_Debug_Variable) then {systemChat format["No Trigger - Selecting Position - %1",_House]}
		};
		if(_Repetitions > 30) exitWith { systemChat "Unable to find position: Hostage Objective"};

		_House setVariable ["OKS_HostageObjective",true];
		_Group = CreateGroup _Side;
		_HostageGroup = CreateGroup civilian;
		_Hostage1 = _Group CreateUnit [(selectRandom _CivilianUnits), getPos _House, [], 0, "NONE"];
		_Hostage2 = _Group CreateUnit [(selectRandom _CivilianUnits), getPos _House, [], 0, "NONE"];
		_Hostage3 = _Group CreateUnit [(selectRandom _CivilianUnits), getPos _House, [], 0, "NONE"];

		{
			[_X, true] call ACE_captives_fnc_setHandcuffed;
			_X setCaptive true;
			_X setBehaviour "CARELESS";
			_X disableAI "MOVE";
		} foreach [_Hostage1,_Hostage2,_Hostage3];

		if (_GarrisonMaxSize > 10) then { _GarrisonMaxSize = 10 };

		for "_i" from 1 to (_GarrisonMaxSize - 3) do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_Position select 0,_Position select 1,0], [], 10, "NONE"];
				_Unit setRank "PRIVATE";
			};
		};

		[getPos _House, nil, units _Group, 1, 1, false, true] remoteExec ["ace_ai_fnc_garrison",0];
		sleep 0.5;

		{[_X] join _HostageGroup} foreach [_Hostage1,_Hostage2,_Hostage3];

		switch(OKS_FRIENDLY_SIDE) do {
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

		_Task = [true,format["OKS_Hostage_Objective_%1",(round(random 9000))], ["The Enemy have taken hostages and are keeping them inside a building under guard. Rescue the hostages and extract them back to base", "Rescue Hostages", "Rescue Hostages"], getPos _House,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;

		[_Task,"help"] call BIS_fnc_taskSetType;
		[_Task,[_House,true]] call BIS_fnc_taskSetDestination;

		if(_ObjectivePatrols) then {
			[_House getPos [35,(random 360)],3,120,_Side,_Units] spawn OKS_Patrol_Spawn;
			[_House getPos [35,(random 360)],3,120,_Side,_Units] spawn OKS_Patrol_Spawn;
		};

		waitUntil {sleep 10; {!alive _X || _X distance _Target < 300} count (units _HostageGroup) isEqualTo count (units _HostageGroup)};
		if( {Alive _X} count (units _HostageGroup) < 1 ) then {
			[_Task,'FAILED'] call BIS_fnc_taskSetState;
		} else {
			[_Task,'SUCCEEDED'] call BIS_fnc_taskSetState;
		};
	};

	default{

	};
};