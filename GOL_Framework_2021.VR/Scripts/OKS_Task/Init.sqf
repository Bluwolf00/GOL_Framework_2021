//	[] execVM "Scripts\OKS_TASK\Init.sqf";
//
//	This initializes all the functions for OKS TASK.
//
//	Made by Oksman

// Functions
//OKS_TASK = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Task.sqf";
//OKS_TASKSTATE = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_TaskState.sqf";
//OKS_TASKSETUP = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_TaskSetup.sqf";
OKS_TASK_Setting = compile preprocessFileLineNumbers "Scripts\OKS_TASK\Settings.sqf";
OKS_Defuse_Explosive = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Defuse_Explosive.sqf";
//OKS_Escort_Base = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Escort_Base.sqf";
//OKS_Escort_Spawn = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Escort_Spawn.sqf";
//OKS_Escort_Dropoff = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Escort_Dropoff.sqf";

OKS_Evacuate_HVT = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Evacuate_HVT.sqf";
//OKS_StaticGroup_NearestBuilding = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Relieve_Friendly\OKS_StaticGroup_NearestBuilding.sqf";
//OKS_Relieve_Friendly = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Relieve_Friendly\OKS_Relieve_Friendly.sqf";
OKS_Destroy_Barricade = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Destroy_Barricade.sqf";
OKS_Destroy_Task = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Destroy_Task.sqf";
OKS_ClearImmediateArea = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_ClearImmediateArea.sqf";
OKS_Fallback_Artillery = compile preprocessFileLineNumbers "Scripts\OKS_TASK\OKS_Fallback_Artillery.sqf";


execVM "Scripts\OKS_Task\OKS_RescueFriendly\init.sqf";