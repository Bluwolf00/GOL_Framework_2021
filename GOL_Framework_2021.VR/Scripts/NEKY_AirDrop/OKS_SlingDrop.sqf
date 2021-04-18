// [west,"CUP_B_CH53E_VIV_USMC","B_LSV_01_armed_F",getPos start,getpos drop,getpos exit,trigger_1] execVM "Scripts\NEKY_AirDrop\SlingDrop.sqf"

params ["_OKS_Side","_Classname","_DropVehicle","_Start","_Drop","_Exit","_HuntZone"];
private ["_Unit","_UnitArray","_PilotClasses"];

systemchat str [_OKS_Side,_Classname,_DropVehicle,_Start,_Drop,_Exit,_HuntZone];


switch (_OKS_Side) do {

	case blufor:{
		_PilotClasses = ["B_Pilot_F"];
		_UnitArray = ["B_Soldier_TL_F","B_Soldier_TL_F","B_Soldier_LAT_F","B_Soldier_GL_F","B_medic_F","B_Soldier_AR_F","B_Soldier_A_F"];
	};
	case opfor:{
		_PilotClasses = ["O_Pilot_F"];
		_UnitArray = ["O_Soldier_TL_F","O_Soldier_TL_F","O_Soldier_LAT_F","O_Soldier_GL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F"];
	};
	case independent:{
		_PilotClasses = ["I_Pilot_F"];
		_UnitArray = ["I_Soldier_TL_F","I_Soldier_TL_F","I_Soldier_LAT_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
	};

};

	_heli = createVehicle [_Classname, _Start, [], 0, "NONE"];
	_crew = createGroup west;
	_cargo = createGroup west;
	_pilot = _crew CreateUnit [(_PilotClasses call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
	_pilot moveInDriver _heli;
	_pilot setBehaviour "CARELESS";
	_pilot setCombatMode "BLUE";
	_pilot disableAI "FSM";
	_Dir = _Drop getDir _Heli;
	_DropSite = createVehicle ["HeliHEmpty", _Drop, [], 0, "NONE"];
	_Move = _DropSite getRelPos [200,_Dir];
	_VehicleSpawn = _heli getRelPos [6, (getDir _Heli + 90)];

	_SlingLoad = _crew createUnit ["ModuleSlingload_F", [0,0,0],[],0,"NONE"];
	_SlingLoad synchronizeObjectsAdd [_heli];

	_vehicle = createVehicle [_DropVehicle, _VehicleSpawn, [], 0, "CAN_COLLIDE"];
	_vehicle setDir getDir _Heli;
	_vehicle setFuel 0;
	_vehicle enableRopeAttach true;
	createVehicleCrew _vehicle;
	_Cargo = group (driver _vehicle);

	//_driver = _Cargo CreateUnit [(_UnitTypes call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
	//_gunner = _Cargo CreateUnit [(_UnitTypes call BIS_fnc_selectRandom), [0,0,0], [], 0, "NONE"];
	//_driver moveInDriver _vehicle;
	//_gunner moveInGunner _vehicle;

	_MoveWP = _crew addWaypoint [_Move,0];
	_MoveWP setWaypointBehaviour "CARELESS";
	_MoveWP setWaypointCombatMode "BLUE";

	_SlingLoad = _crew createUnit ["ModuleSlingload_F", [0,0,0],[],0,"NONE"];
	_SlingLoad synchronizeObjectsAdd [_heli];
	_success = _heli setSlingLoad _vehicle;

	_vehicle enableSimulation true;

	_unloadWP = _crew addWaypoint [getPos _DropSite,1];
	_unloadWP setWaypointType "UNHOOK";


	waitUntil{sleep 5; _heli distance (getPos _DropSite) < 50};
	_vehicle setFuel 1;
	[_Cargo, nil, _HuntZone, 0, 30, 0, {}] Spawn NEKY_Hunt_Run;

	_exitWP = _crew addWaypoint [_Exit,2];
	waitUntil {Sleep 5; _heli distance _Exit < 400};
	deleteVehicle driver _heli;
	deleteVehicle _heli;
