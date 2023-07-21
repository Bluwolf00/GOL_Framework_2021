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

// Scoreboard Loop
[] spawn {
	while {true} do {
		execVM "Scripts\OKS_Ambience\OKS_DeathScore.sqf";
		sleep 20;
	};
};

/* Set GOL Mission Settings */
Call Compile PreProcessFileLineNumbers "MissionSettings.sqf";
Sleep 5;

	if (GOL_BLU_AUTO_TS_CHANNEL isEqualTo 1) then {
		execVM "Scripts\BLU_SetChannel.sqf";
	};

	{
		[_x] execVM "Scripts\BLU_HeliActions.sqf";
	} forEach (entities "Helicopter");

	if(GOL_NEKY_PARADROP isEqualTo 1 || GOL_NEKY_RESUPPLY isEqualTo 1 || GOL_NEKY_PICKUP isEqualTo 1 || GOL_OKS_SUPPORT isEqualTo 1 || GOL_NEKY_FASTROPE isEqualTo 1 || GOL_NEKY_REINSERT isEqualTo 1 || GOL_OKS_TentMHQ isEqualTo 1) then {
		if (hasInterface) then {
			_condition = {player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4]};
			// _condition = {true}; // If you want everyone to have access to support tab (required for tent mhq to be available to all)
     	 	_action = ["Request_Support", "Request Support","\A3\ui_f\data\map\VehicleIcons\iconCrateVeh_ca.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
     		[typeOf player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		};

		if(GOL_NEKY_PARADROP isEqualTo 1) then {
			execVM "Scripts\NEKY_Paradrop\Init.sqf";
			sleep 2;
			[] spawn NEKY_ACE_AddAction;
		};
	};

	if(GOL_EnableHelicopterScriptToAllVehicles isEqualTo 1) then {
		[objNull,false,false] execVM "Scripts\OKS_Vehicles\OKS_Helicopter.sqf";
	};
	if(GOL_NEKY_SERVICESTATION isEqualTo 1) then {
		[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";
	};
	if(GOL_NEKY_RESUPPLY isEqualTo 1) then {
		execVM "Scripts\NEKY_Supply\Ace_Resupply.sqf";
		execVM "Scripts\NEKY_Supply\Ace_Med.sqf";

		if(!isNil "Vehicle_1") then {
			execVM "Scripts\NEKY_Supply\Ace_VehicleDrop.sqf";
		};
		if(!isNil "MHQ_1") then {
			execVM "Scripts\NEKY_Supply\Ace_MHQDrop.sqf";
		};				
	};
	if(GOL_OKS_SUPPORT isEqualTo 1) then {
		[] execVM "Scripts\OKS_Support\Init.sqf";
	};
	if(GOL_NEKY_PICKUP isEqualTo 1) then {
		execVM "Scripts\NEKY_Pickup\ACE_PickUp.sqf";
	};
	if(GOL_OKS_REINFORCEMENT isEqualTo 1) then {
		execVM "Scripts\OKS_Reinforcement\ACE_Reinforcement.sqf";
	};
	if(GOL_NEKY_FASTROPE isEqualTo 1) then {
		if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
			[flag_west_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
		};
		if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
			[flag_east_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
		};
		if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
			[flag_independent_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
		};
	};
	if(GOL_NEKY_REINSERT isEqualTo 1) then {
		if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
			[flag_west_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
		};
		if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
			[flag_east_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
		};
		if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
			[flag_independent_1,NEKY_PARADROP_TRIGGER,30] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
		};
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

		/* TFAR Jammer - Object, Range & Strength Parameters
			Requires script from the folder additional scripts
			waitUntil {!isNil "TFAR_Scrambler"};
			[[JAMMER],500,50] spawn TFAR_Scrambler;
		*/
	};
	if(GOL_OKS_TentMHQ isEqualTo 1 && !isNil "Tent_MHQ") then {
		execVM "Scripts\OKS_TentMHQ\ACE_MoveMHQ.sqf";
	};
	if(GOL_OKS_SPAWN isEqualTo 1) then {
		execVM "Scripts\OKS_Spawn\Init.sqf";
		[GOL_Remove_HE_From_StaticAndVehicle] spawn {
			Params ["_Value"];
			if(_Value) then {
				sleep 2;
				{
					_vehicle = _X;
					if({_vehicle distance _X < 200} count AllPlayers == 0) then {[_X] spawn OKS_RemoveVehicleHE}
				} foreach Vehicles;
			}
		};
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

		if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
			[flag_west_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
		if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
			[flag_east_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
		if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
			[flag_independent_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
		};
	};
	if(GOL_OKS_MHQ_PARADROP isEqualTo 1) then {
		OKS_MHQ_Paradrop = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
		waitUntil {sleep 1; !(isNil "OKS_MHQ_Paradrop") && !(isNil "OKS_FRIENDLY_SIDE")};
		private _AMHQ = AMHQ_1;     /* The Air Mobile Headquarters Vehicle */
		private _Steerable = true; /* Decide if parachute should be steerable or not */
		private _Height = 200;      /* Altitude in meters where parachute is opened automatically */

		if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
			[flag_west_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
		};
		if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
			[flag_east_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
		};
		if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
			[flag_independent_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
		};
	};

Sleep 10;

/* !! IGNORE AND DO NOT EDIT ALL OF THE ABOVE !! */
	/*
		Requires script from the folder additional scripts

		if(GOL_OKS_HUNT isEqualTo 1) then {
			[] execVM "Scripts\OKS_HUNT\Init.sqf";
			// Run in SpawnList.sqf: [EAST,500,1000,90] spawn OKS_Dynamic_Hunt;
		};

	*/
	if(GOL_OKS_TASK isEqualTo 1) then {
		[] execVM "Scripts\OKS_TASK\Init.sqf";
		waitUntil{sleep 1; !(isNil "OKS_TASKSETUP") && !(isNil "OKS_FRIENDLY_SIDE")};
		/*	[Task_Object_1,1,GetMarkerPos "Task_1",west,O_Task] spawn OKS_TASKSETUP;	*/
	};

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

		/*
		   Dynamic Script Params
		   0 - Trigger Name (Object)
		   1 - Disabled - Keep False
		   2 - Number of Infantry - [Static Integer,Patrol Integer,CreateSectorObjective?,LocalPatrols?] (Array) -
		   3 - Wheeled Patrols (Integer/Number)
		   4 - APC Patrols (Integer/Number)
		   5 - Tank Patrols (Integer/Number)
		   6 - Roadblocks [RoadBlocksCount,OnlyOnTarmac,LocalPatrols?,NumberChanceForVehicle(0-1)] (Array)
		   7 - Mortar Pits [MortarCount,LocalPatrols?] (Array)
		   8 - Random Objectives [ObjectiveCount,LocalPatrols?] (Array)
		   9 - Hunt Array Bases [Infantry,Wheeled,APC,Tank,Helicopter]
		   10 - Dynamic Civilians on? (Boolean)

			Local Patrols - This means that the strongpoints / roadblocks / mortar pits / objectives have their own local patrols near their position.
			If you use it on Parameter 2, 30% of the static contacts will be turned into patrols.

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
		   [Trigger_1,false,[0,0,false,false],east,0,0,0,[0,true,false,0],[0,false],[0,false],[0,0,0,0,0],false] spawn OKS_CreateZone;
		*/

		/* Example of Dynamic Scripts */
		/*
		if(isServer) then {
			waitUntil{sleep 5; !(isNil "OKS_CreateZone")};

			//// START OF ZONE /////
			[	Trigger_1,  // Name of Trigger used as Spawn Area
				false, 		// DO NOT EDIT
				[
					8,      // Number of Static Infantry - Preferred Game Logic Location 'Outpost'"
					25,		// Number of Patrolling Infantry
					false,  // Create Sector Objective on Garrison?
					false   // Should have dedicated patrols near static positions
				],
				east, // Side of Enemy
				0,    // Number of Wheeled on Patrol
				0,    // Number of APCs on Patrol
				0,    // Number of Tanks on Patrol
				[
					0,     // Number of Roadblocks - Preferred Game Logic Location 'FOB'"
					true,  // Should be on tarmac.
					false, // Should have dedicated patrol.
					0  	   // Chance for Static Vehicle (1 = 100%, 0.5 = 50%)
				],
				[
					0,     // Number of Mortars
					false  // Should have dedicated patrols around it
				],[
					0,    // Number of Random Objectives - Preferred Game Logic Location 'Camp'"
					false // Should have dedicated patrols around it
				],
				[0,0,0,0,0] // Infantry, Wheeled, APCs, Tanks, Air Assault - Hunt Bases - Preferred Game Logic Location 'Respawn Point'"
				,false      // Should Enable Civilian Presence - Required Game Logic Location 'Village'"
			] spawn OKS_CreateZone;
			//// END OF ZONE ////

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
			[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,600+(random 300),east,6,120+(120)] spawn NEKY_Hunt_HuntBase;
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




