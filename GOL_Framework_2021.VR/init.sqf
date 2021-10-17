MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};

/* Define Player Side for Scripts */
if(HasInterface && isNil "OKS_FRIENDLY_SIDE") then {
	OKS_FRIENDLY_SIDE = [player] call GW_Common_Fnc_getSide;
	publicVariable "OKS_FRIENDLY_SIDE";
};

/* Headless & ServiceStation */
[] execVM "Scripts\HeadlessClient\HeadlessClient.sqf";
ExecVM "Modules\Callsigns\ACE_Action.sqf";
Call Compile PreProcessFileLineNumbers "MissionSettings.sqf";

Sleep 5;

	if(GOL_NEKY_SERVICESTATION isEqualTo 1) then {
		[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";
	};
	if(GOL_NEKY_RESUPPLY isEqualTo 1) then {
		execVM "Scripts\NEKY_Supply\Ace_Resupply.sqf";
		execVM "Scripts\NEKY_Supply\Ace_Med.sqf";
	};
	if(GOL_NEKY_PARADROP isEqualTo 1) then {
		execVM "Scripts\NEKY_Paradrop\Init.sqf";
	};
	if(GOL_NEKY_PICKUP isEqualTo 1) then {
		execVM "Scripts\NEKY_Pickup\ACE_PickUp.sqf";
	};
	if(GOL_NEKY_SHARE isEqualTo 1) then {
		Call Compile PreProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Init.sqf";
	};
	if(GOL_NEKY_AIRDROP isEqualTo 1) then {
		[] execVM "Scripts\NEKY_AirDrop\Init.sqf";
	};
	if(GOL_NEKY_HUNT isEqualTo 1) then {
		[] execVM "Scripts\NEKY_Hunt\Init.sqf";
	};
	if(GOL_AAC_SETUP isEqualTo 1) then {
		[] execVM "Scripts\OKS_AAC\Init.sqf";
	};
	if(GOL_OKS_AMBIENCE isEqualTo 1) then {
		[] execVM "Scripts\OKS_Ambience\Init.sqf";
	};
	if(GOL_OKS_TANKER isEqualTo 1) then {
		[] execVM "Scripts\OKS_Vehicles\OKS_Tanker.sqf";
	};
	if(GOL_OKS_DYNAMIC isEqualTo 1) then {
		[] execVM "Scripts\OKS_Dynamic\Init.sqf";
	};
	if(GOL_NEKY_TASK isEqualTo 1) then {
		[] execVM "Scripts\NEKY_Tasks\Init.sqf";
	};
	if(isServer && GOL_NEKY_SHARE isEqualTo 1) then {
		[True,True] call NEKY_AI_ShareInfo;
	};
	if(GOL_NEKY_PARADROP isEqualTo 1) then {
		waitUntil {sleep 1; !(isNil "NEKY_ACE_AddAction") && !(isNil "OKS_FRIENDLY_SIDE")};
		[] spawn NEKY_ACE_AddAction;

		if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
			[flag_west_1, "Paradrop Reinsert", "DZ Alpha", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
		if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
			[flag_east_1, "Paradrop Reinsert", "DZ Bravo", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
		if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
			[flag_independent_1, "Paradrop Reinsert", "DZ Charlie", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
	};

Sleep 10;

/* !! IGNORE AND DO NOT EDIT ALL OF THE ABOVE !! */

	if(GOL_OKS_HUNT isEqualTo 1) then {
		[] execVM "Scripts\OKS_HUNT\Init.sqf";
		/* Run in SpawnList.sqf: [EAST,500,1000,90] spawn OKS_Dynamic_Hunt; */
	};
	if(GOL_OKS_TASK isEqualTo 1) then {
		[] execVM "Scripts\OKS_TASK\Init.sqf";
		waitUntil{sleep 1; !(isNil "OKS_TASKSETUP") && !(isNil "OKS_FRIENDLY_SIDE")};
		/*	[Task_Object_1,1,GetMarkerPos "Task_1",west,O_Task] spawn OKS_TASKSETUP;	*/
	};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

		/*
		   Dynamic Script Params
		   0 - Trigger Name (Object)
		   1 - Split Trigger into 4 Sub-Triggers? (Boolean)
		   2 - Number of Infantry - [Static Integer,Patrol Integer,CreateSectorObjective?,LocalPatrols?] (Array) -
		   3 - Wheeled Patrols (Integer/Number)
		   4 - APC Patrols (Integer/Number)
		   5 - Tank Patrols (Integer/Number)
		   6 - Roadblocks [RoadBlocksCount,OnlyOnTarmac,LocalPatrols?,NumberChanceForVehicle(0-1)] (Array)
		   7 - Mortar Pits [MortarCount,LocalPatrols?] (Array)
		   8 - Random Objectives [ObjectiveCount,LocalPatrols?] (Array)
		   9 - Hunt Array Bases [Infantry,Wheeled,APC,Tank,Helicopter]
		   10 - Dynamic Civilians on? (Boolean)

		   Note:
		   The Dynamic Scripts does work on its own however is very limited in selecting positions for strongpoints.
		   You as an editor can assist the dynamic script by placing down locations for pinpointing different positions.
		   In Eden-Editor "Location"s can be found in Systems (F5) and Game Logics > Locations.

		   Area, Base, City, Evac Point, Resupply Point & Town -> Spawns Strongpoints & Sector Tasks (Selects Random Buildings in Area. Generally more contacts per building)
		   Outpost -> Spawns Compounds & Sector Tasks (Selects all buildings in range of compoundSize (Settings) and spawns even-spread over all buildings)
		   FOB -> Spawns Roadblocks, use the direction of the logic to define the direction of the roadblock.
		   Respawn Point -> If you use HuntBases these locations will be picked, use the direction of the logic to choose the spawn direction 15-25m away from logic.
		   Camp -> Static Objective positions, once again direction of logic defines direction of Objective compositions.
		   Village -> Defines village area for the Dynamic Civilian presence, radius is found in Settings.sqf

		   All Locations are not required, the script will find its own locations, however for the best experience and best result, help the dynamic script by placing these logics.

		   Example:
		   [Trigger_1,false,[30,15,true,false],east,0,0,0,[0,true,false,0.5],[0,false],[0,false],[0,0,0,0,0],false] spawn OKS_CreateZone;
		*/

		/* Example of Dynamic Scripts */
		/*
		if(isServer) then {
			waitUntil{sleep 5; !(isNil "OKS_CreateZone")};
			[Trigger_1,false,[30,15,true,false],east,0,0,0,[0,true,false,0],[0,false],[0,false],[0,0,0,0,0],false] spawn OKS_CreateZone;
		};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

		/*
		   	HuntBase Params

		   	0 - Base Object (Object)
		   	1 - Spawn Object (Object)
		   	2 - Hunt Trigger (Trigger)
		   	3 - Wave Count (Integer/Number)
		   	4 - Respawn Delay in Seconds (Integer/Number)
		   	5 - Enemy Side (Side)
		   	6 - Unit Selection - (Integer/String/Array with Strings)
		   	7 - Refresh Rate in Seconds (Integer/Number)

			[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,independent,6,30] spawn NEKY_Hunt_HuntBase;
			[Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,independent,"CUP_I_LR_MG_AAF",30] spawn NEKY_Hunt_HuntBase;
			[Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,independent,["CUP_I_LR_MG_AAF","CUP_I_LR_MG_AAF"],30] spawn NEKY_Hunt_HuntBase;
		*/
		/* Example of Hunt Bases */
		/*
		if(isServer && GOL_NEKY_HUNT isEqualTo 1) then {
			waitUntil{sleep 5; !(isNil "NEKY_Hunt_HuntBase")};
			[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,independent,6,30] spawn NEKY_Hunt_HuntBase;
		};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

		/*
		   AirBase Params

		   0 - Base Object (Object)
		   1 - Spawn Object (Object)
		   2 - Hunt Trigger (Trigger)
		   3 - Enemy Side (Side)
		   4 - Classname of Helicopter (String)
		   5 - Type of Insert (Unload ONLY) (String)
		   6 - Cargo Split - [How many teams,Procent of Cargo] (Array)

		   [Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn NEKY_Airbase;
		*/
		/* Example of Air Bases */
		/*
		if(isServer && GOL_NEKY_AIRDROP isEqualTo 1) then {
			waitUntil{sleep 5; !(isNil "NEKY_Airbase")};
			[Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn NEKY_Airbase;
		};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		/*
			Set AI Faces & Voices for Factions / Units

			Options:
			african
			asian
			english
			american
			middleeast
			russian
			french

			!! OKS_Ambience must be turned to 1 in MissionSettings.sqf !!
		*/

			if(isServer && GOL_OKS_AMBIENCE isEqualTo 1) then {

				waitUntil {sleep 1; !(isNil "OKS_FaceSwap")};
				[east,"russian"] spawn OKS_FaceSwap;
			};
		/*
		*/

