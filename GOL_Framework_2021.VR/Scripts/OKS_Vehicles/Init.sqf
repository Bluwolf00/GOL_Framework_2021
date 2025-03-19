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
OKS_Retexture = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Retexture.sqf";
OKS_AdjustDamage = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_AdjustDamage.sqf";
OKS_DAP_Config = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_DAP_Config.sqf";
OKS_Interact_Apply = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Apply.sqf";
OKS_Interact_Copilot = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Copilot.sqf";
OKS_Interact_DoorGunner = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_DoorGunner.sqf";
OKS_Interact_Pilot = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_Interact_Pilot.sqf";
OKS_AbandonVehicle = compile preprocessFileLineNumbers "Scripts\OKS_Vehicles\OKS_AbandonVehicle.sqf";

sleep 5;

if(isServer) then {
	_whitelistedVehicles = vehicles select { 
		(["T34", typeOf _X] call BIS_fnc_inString || ["T55", typeOf _X] call BIS_fnc_inString ||
		["T72", typeOf _X] call BIS_fnc_inString || ["T80", typeOf _X] call BIS_fnc_inString) && ["UK3CB", typeOf _X] call BIS_fnc_inString
	};
	{
		[_X] spawn OKS_AdjustDamage; sleep 0.25;
	} foreach _whitelistedVehicles;
	{
		[_X] spawn OKS_AbandonVehicle;
	} foreach vehicles;
};

[nil,GOL_AAC_DoorGunReplacement] spawn OKS_DAP_Config;




