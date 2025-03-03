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

// Functions
GW_Ambient_AAA = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\GW_Ambient_AAA.sqf";
OKS_IR_AA = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_IR_AA.sqf";
OKS_Forced_Reload = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Forced_Reload.sqf";
OKS_Target_Finder = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Target_Finder.sqf";
OKS_Remove_InfantryWeapons = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Remove_InfantryWeapons.sqf";
OKS_Spawn_AntiAir_Soldier = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_IR\OKS_Spawn_AntiAir_Soldier.sqf";
OKS_AddVehicleCrew = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_AddVehicleCrew.sqf";
OKS_AI_Battle = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AI_Battle.sqf";
//OKS_AirCargoDrop = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirCargoDrop.sqf";
//OKS_AirSpawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirSpawn.sqf";
//OKS_AirStrike = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_AirStrike.sqf";
OKS_ArtyFire = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_ArtyFire.sqf";
OKS_ArtySupression = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_ArtySupression.sqf";
OKS_Attack_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Attack_SpawnGroup.sqf";
//OKS_Convoy_Patrol = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy_Patrol.sqf";
OKS_Convoy_Reinforce = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy_Reinforce.sqf";
OKS_Convoy_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Convoy_Spawn.sqf";
OKS_Dynamic_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\Settings.sqf";
//OKS_Flare_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Flare_Spawn.sqf";
//OKS_Helicopter_Attack = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Helicopter_Attack.sqf";
OKS_Lambs_ChargeSpawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs_ChargeSpawn.sqf";
OKS_Lambs_Spawner = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs_Spawner.sqf";
OKS_Lambs_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs_SpawnGroup.sqf";
OKS_Lambs_Wavespawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Lambs_Wavespawn.sqf";
OKS_Mechanized_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Mechanized_Spawn.sqf";
//OKS_PlayerWaypoint_SpawnGroup = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_PlayerWaypoint_SpawnGroup.sqf";
OKS_RemoveVehicleHE = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_RemoveVehicleHE.sqf";
OKS_ForceVehicleSpeed = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_ForceVehicleSpeed.sqf";
//OKS_ScudLaunch = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_ScudLaunch.sqf";
OKS_SpawnStatic = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_SpawnStatic.sqf";
OKS_SpawnPatrol = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_SpawnPatrol.sqf";
OKS_Scout = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Scout.sqf";
OKS_Hold_waypoint = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Hold_waypoint.sqf";
OKS_Civilian_Vehicle = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Civilian_Vehicle.sqf";
OKS_Radar = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_Radar.sqf";
OKS_SAM = compile preprocessFileLineNumbers "Scripts\OKS_Spawn\OKS_SAM.sqf";
