//	[] execVM "Scripts\OKS_Vehicles\Init.sqf";
//
//	This initializes all the functions for OKS Vehicles.
//
//	Made by Oksman

// Global Execution'
// Setup Script for Packing/Unpacking Static Weapons.
execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";

// Setup Scripted Resupply of Ammo/MHQ/Vehicles
if(GOL_NEKY_RESUPPLY isEqualTo 1) then {
	execVM "Scripts\NEKY_Supply\Ace_Resupply.sqf";
	//execVM "Scripts\NEKY_Supply\Ace_Med.sqf";

	if(!isNil "Vehicle_1") then {
		execVM "Scripts\NEKY_Supply\Ace_VehicleDrop.sqf";
	};
	if(!isNil "MHQ_1") then {
		execVM "Scripts\NEKY_Supply\Ace_MHQDrop.sqf";
	};				
};

// Add Helicopter Setup Script to all Helicopters on Start.
if(GOL_EnableHelicopterScriptToAllVehicles isEqualTo 1) then {
	[objNull,false,false] execVM "Scripts\OKS_Vehicles\OKS_Helicopter.sqf";
};

// Server & Headless Execution
if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script

// Functions
//OKS_Tanker = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Tanker.sqf";
//OKS_CreateCrew = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_CreateCrew.sqf";
OKS_Helicopter = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Helicopter.sqf";
OKS_Mechanized = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Mechanized.sqf";
OKS_ReduceDamage = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_ReduceDamage.sqf";
OKS_DAP_Config = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_DAP_Config.sqf";
OKS_Interact_Apply = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Apply.sqf";
OKS_Interact_Copilot = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Copilot.sqf";
OKS_Interact_DoorGunner = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_DoorGunner.sqf";
OKS_Interact_Pilot = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Pilot.sqf";

sleep 5;

[nil,GOL_AAC_DoorGunReplacement] spawn OKS_DAP_Config;




