//	[] execVM "Scripts\OKS_Dynamic\Init.sqf";
//
//	This initializes all the functions for OKS Dynamic Spawns.
//
//	Made by Oksman
OKS_AllUnits = [];
OKS_Logics = (allMissionObjects "all") select {typeOf _X in ["LocationCamp_F","LocationResupplyPoint_F","LocationRespawnPoint_F","LocationEvacPoint_F","LocationFOB_F","LocationCityCapital_F","LocationCity_F","LocationVillage_F","LocationArea_F","LocationBase_F","LocationOutpost_F","LocationCamp_F","LocationRespawnPoint_F"]};

OKS_Locations = OKS_Logics select {typeOf _X in ["LocationResupplyPoint_F","LocationEvacPoint_F","LocationCityCapital_F","LocationCity_F","LocationArea_F"]};
OKS_Compounds = OKS_Logics select {typeOf _X in ["LocationOutpost_F"]};
OKS_Strongholds = OKS_Logics select {typeOf _X in ["LocationBase_F"]};
OKS_Objectives = OKS_Logics select {typeOf _X in ["LocationCamp_F"]};
OKS_HuntLocations = OKS_Logics select {typeOf _X in ["LocationRespawnPoint_F"]};
OKS_RoadBlocks = OKS_Logics select {typeOf _X in ["LocationFOB_F"]};
OKS_Villages = OKS_Logics select {typeOf _X in ["LocationVillage_F"]};

// Functions
OKS_Dynamic_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\Settings.sqf";
OKS_Hunt_Setting = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_HuntSettings.sqf";
OKS_CreateMarker = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateMarker.sqf";
OKS_CreateTrigger = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateTrigger.sqf";
OKS_Civilians = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Civilians.sqf";
OKS_Populate_Sandbag = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Populate_Sandbag.sqf";
OKS_CreateUnitMarker = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateUnitMarker.sqf";
OKS_SetStatic = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_SetStatic.sqf";
OKS_EnablePath = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_EnablePath.sqf";
OKS_Finale =  compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Finale.sqf";

//OKS_CreateComposition = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateComposition.sqf";
//OKS_GetComposition = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_GetComposition.sqf";
OKS_CheckIfTarmac = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CheckIfTarmac.sqf";
OKS_CheckRoadConnections = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CheckRoadConnections.sqf";
OKS_Find_Roadblocks = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Find_Roadblocks.sqf";
OKS_Find_Mortars = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Find_Mortars.sqf";
OKS_Find_Huntbase = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Find_Huntbase.sqf";
OKS_AddVehicleCrew = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_AddVehicleCrew.sqf";

OKS_Garrison = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Garrison.sqf";
OKS_Garrison_Compound = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Garrison_Compound.sqf";
OKS_Vehicle_Waypoints = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Vehicle_Waypoints.sqf";
OKS_Check_Waypoints = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Check_Waypoints.sqf";
OKS_Vehicle_Patrol = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Vehicle_Patrol.sqf";
OKS_Patrol_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Patrol_Spawn.sqf";
//OKS_Rush_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Rush_Spawn.sqf";
OKS_Populate_Strongpoints = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Populate_Strongpoints.sqf";
OKS_Populate_StaticWeapons = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Populate_StaticWeapons.sqf";
OKS_Populate_Bunkers = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_Populate_Bunkers.sqf";
OKS_CreateObjectives = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateObjectives.sqf";
OKS_CreateZone = compile preprocessFileLineNumbers "Scripts\OKS_Dynamic\OKS_CreateZone.sqf";

OKS_RoadBlock_Positions = [];
OKS_Mortar_Positions = [];
OKS_Objective_Positions = [];
OKS_Hunt_Positions = [];



