//	[] execVM "Scripts\OKS_Spawn\Init.sqf";
//
//	This initializes all the functions for OKS Spawn.
//
//	Made by Oksman

// Global Execution
// Remove HE rounds from Enemy Vehicles.
[GOL_Remove_HE_From_StaticAndVehicle] spawn {
	Params ["_Value"];
	if(_Value) then {
		waitUntil {sleep 1; !isNil "OKS_RemoveVehicleHE"};
		{
			_vehicle = _X;
			if({_vehicle distance _X < 200} count AllPlayers == 0) then {[_X] spawn OKS_RemoveVehicleHE}
		} foreach Vehicles;
	}
};

// Server & Headless Execution.
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Modules
execVM "Scripts\OKS_Spawn\OKS_IR\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Infantry_Pincer\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Radar\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Lambs\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Arty\Init.sqf";
execVM "Scripts\OKS_Spawn\OKS_Convoy\Init.sqf";

// Functions
OKS_Dynamic_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\Settings.sqf";
OKS_AddVehicleCrew = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_AddVehicleCrew.sqf";
OKS_AI_Battle = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AI_Battle.sqf";
OKS_Attack_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Attack_SpawnGroup.sqf";
OKS_Mechanized_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Mechanized_Spawn.sqf";
OKS_SpawnStatic = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_SpawnStatic.sqf";
OKS_SpawnPatrol = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_SpawnPatrol.sqf";
OKS_Scout = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Scout.sqf";
OKS_Hold_waypoint = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Hold_waypoint.sqf";
OKS_Civilian_Vehicle = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Civilian_Vehicle.sqf";

//OKS_AirCargoDrop = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf";
//OKS_AirSpawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirSpawn.sqf";
//OKS_AirStrike = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirStrike.sqf";
//OKS_Convoy_Patrol = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy_Patrol.sqf";
//OKS_Flare_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Flare_Spawn.sqf";
//OKS_Helicopter_Attack = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf";
//OKS_PlayerWaypoint_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_PlayerWaypoint_SpawnGroup.sqf";
//OKS_ScudLaunch = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_ScudLaunch.sqf";