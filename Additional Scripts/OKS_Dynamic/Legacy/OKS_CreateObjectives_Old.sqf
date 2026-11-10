/*
	OKS_Createobjectives

	[GetPos player,"sector",300,EAST,_Settings] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[GetPos player,"sector",300,EAST,_Settings] spawn OKS_CreateObjectives;

	[Position,TypeOfObjective,Range,EAST] execVM "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
	[Position,TypeOfObjective,Range,EAST] spawn OKS_CreateObjectives;
*/



	Params ["_Position","_TypeOfObjective","_Range","_Side","_Settings"];
	private ["_marker","_Condition","_playerSide","_trg","_EnemySideString","_playerSideString","_playerColor","_Area","_SpawnPos"];
	_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles"];

	switch(typeName _Position) do {

		case "OBJECT":{
			_Area = _Position;
		};

		default {
			exit;
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

		systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
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

			while{true} do {
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 100, 30, 0, 0.1, 0] call BIS_fnc_findSafePos;
				if(_SpawnPos inArea _Area) exitWith {};
			};

		} else {
			_SpawnPos = [_Position, 1, 100, 30, 0, 0, 0] call BIS_fnc_findSafePos;
		};

		if(isServer) then {

			_Crate = CreateVehicle [_ammoCrate, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "CAN_COLLIDE"];
			_Crate setDir (random 360);
			_Crate setVehicleVarName format["OKS_Crate_%1",round(random 9999)];
			_Crate allowDamage true;
			_Crate enableSimulation true;
			_Crate setMass 9999;

			["AmmoCamp",getPos _Crate, [0,0,0], getDir _Crate] call LARs_fnc_spawnComp;
		};

		_trg = createTrigger ["EmptyDetector", GetPos _Crate, true];
		_trg setTriggerArea [15000,15000,0,false,1000];
		_trg setTriggerActivation ["STATIC","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Crate];

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_Cache_Objective_%1",(round(random 9000))], ["The Enemy forces have access to weapons and ammunitions caches in the area of operations. Find them and destroy them.", "Destroy Ammo Cache", "Destroy Ammo Cache"], getPos _Crate,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"destroy"] call BIS_fnc_taskSetType;
		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];
		[_Crate getPos [25,(random 360)],5,150,_Side,_Units] execVM "Scripts\OKS_Dynamic\OKS_Patrol_Spawn.sqf";

	};

	case "ammotruck": {

		private ["_SupplyTruck","_Road","_RandomPos"];
		_SupplyTruck = selectRandom(_Vehicles select 4);

		if(!isNull _Area) then {
			while{true} do {
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = getPos ([ [_RandomPos, 1, 100, 30, 0, 0.1, 0] call BIS_fnc_findSafePos, 300] call BIS_fnc_nearestRoad);
				if(_SpawnPos inArea _Area) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};

		if(isServer) then {
			_Truck = CreateVehicle [_SupplyTruck, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "CAN_COLLIDE"];
			_Truck setDir (random 360);
			_Truck setVehicleVarName format["OKS_AmmoTruck_%1",round(random 9999)];

			_Group = CreateGroup _Side;
			_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
			_Unit setRank "SERGEANT";
			_Unit MoveInDriver _Truck;
		};
		[_Area,_Group,6] spawn OKS_Vehicle_Waypoints;

		_trg = createTrigger ["EmptyDetector", GetPos _Truck, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Truck];
		_trg setTriggerArea [15000,15000,0,false,1000];

		//systemChat format["OKS_Sector_Objective_%1",(round(random 9000))];
		_Task = [true,format["OKS_AmmoTruck_Objective_%1",(round(random 9000))], ["The Enemy forces have access to supply trucks in the area of operations. Intercept the truck and destroy it", "Destroy Supply Truck", "Destroy Supply Truck"], getPos _Truck,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"destroy"] call BIS_fnc_taskSetType;
		[_Task,[_Truck,true]] call BIS_fnc_taskSetDestination;

		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];


	};

	case "artillery": {

		private ["_Artillery","_Road","_RandomPos","_Target"];
		_Artillery = selectRandom(_Vehicles select 3);

		if(!isNull _Area) then {
			while{true} do {
				_RandomPos = _Area call BIS_fnc_randomPosTrigger;
				_SpawnPos = [_RandomPos, 1, 500, 30, 0, 0.1, 0] call BIS_fnc_findSafePos;
				if(_SpawnPos inArea _Area) exitWith {};
			};
		} else {
			_SpawnPos = getPos([([_Position, 1, 100, 15, 0, 0.1, 0] call BIS_fnc_findSafePos), 300] call BIS_fnc_nearestRoad);
		};
		if(isServer) then {
			_Arty = CreateVehicle [_Artillery, [_SpawnPos select 0,_SpawnPos select 1,0.5], [], 0, "CAN_COLLIDE"];
			_Arty setDir (random 360);
		};

		_trg = createTrigger ["EmptyDetector", GetPos _Arty, true];
		_trg setTriggerActivation ["VEHICLE","NOT PRESENT",false];
		_trg setTriggerTimeout [5, 7, 10, true];
		_trg triggerAttachVehicle [_Arty];
		_trg setTriggerArea [15000,15000,0,false,1000];

		_Task = [true,format["OKS_Artillery_Objective_%1",(round(random 9000))], ["The Enemy have set up artillery positions that shell nearby friendly positions. Locate the artillery and spike it! Destroy to complete.", "Destroy Artillery", "Destroy Artillery"], getPos _Arty,"AUTOASSIGNED",-1,false] call BIS_fnc_taskCreate;
		[_Task,"destroy"] call BIS_fnc_taskSetType;
		[_Task,[_Arty,true]] call BIS_fnc_taskSetDestination;

		_trg setTriggerStatements ["this", format ["['%1','SUCCEEDED'] call BIS_fnc_taskSetState;",_Task], ""];
		[_Arty getPos [25,(random 360)],5,150,_Side,_Units] execVM "Scripts\OKS_Dynamic\OKS_Patrol_Spawn.sqf";

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
			[_Side,_Arty,_Target,7,300,2500] execVM "Scripts\OKS_Ambience\OKS_ArtyFire.sqf";
		} else {

			createVehicleCrew _Arty;

		};
		["ArtilleryCamp",getPos _Arty, [0,0,0], getDir _Arty] call LARs_fnc_spawnComp;
		sleep 5;

		[getPos _Arty,40,_Side] spawn OKS_Populate_StaticWeapons;
	 	[getPos _Arty,_Side,(3+(round random 4)),40] spawn OKS_Populate_Bunkers;
	};

};