MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};
[] execVM "Scripts\HeadlessClient\HeadlessClient.sqf";
[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";

/* Resupply & Medical Resupply Scripts */
execVM "Scripts\NEKY_Supply\Ace_Resupply.sqf";
execVM "Scripts\NEKY_Supply\Ace_Med.sqf";

/*	Initiate Paradrop / AI Helicopter Pickup Scripts	*/
 [] execVM "Scripts\NEKY_Paradrop\Init.sqf";
 [] execVM "Scripts\NEKY_Pickup\ACE_PickUp.sqf";

/* Neky ShareInfo Script for AI */
Call Compile PreProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Init.sqf";
/* Add this to bottom of script if you want to make AI share info

	if(isServer) then {
		[True,True] call NEKY_AI_ShareInfo;
	};
*/

// Do not remove these scripts ^
// Adds backup supply lines if AAC is not playing (Luke's Script)
// Sets up working Service Station

	OKS_FRIENDLY_SIDE = [player] call GW_Common_Fnc_getSide;
	publicVariable "OKS_FRIENDLY_SIDE";

	//Comment if you want to disable Neky_HuntBase / AirBase
	[] execVM "Scripts\NEKY_AirDrop\Init.sqf";
	[] execVM "Scripts\NEKY_Hunt\Init.sqf";
	// Set Max Count of Enemies spawned by bases
	NEKY_Hunt_MaxCount = 40;
	NEKY_Hunt_CurrentCount = [];
	publicVariable "NEKY_Hunt_MaxCount";
	publicVariable "NEKY_Hunt_CurrentCount";

	/// Use this if you want AAC to be able to switch seats in their helicopters and get better doorgunners - Comment if you want to disable this
	[] execVM "Scripts\OKS_AAC\Init.sqf";

	// Use this if you want the automatic hunt code, this takes all moving units and makes them attack the player if they are within range
	// Uncomment both lines and adjust the parameters below (Side,MinRange,MaxRange,RefreshRate)
	//[] execVM "Scripts\OKS_HUNT\Init.sqf";
	//[EAST,500,1000,90] spawn OKS_Dynamic_Hunt;

	// Use this if you want to use in-game intel tasks, you assign the details in the script below, find it at "Scripts\OKS_TASK\Init.sqf"
	// Below is an example, parameters: [originObject,numberID,Position,Side,ParentTask]
	//[] execVM "Scripts\OKS_TASK\Init.sqf";
	//[Task_Object_1,1,GetMarkerPos "Task_1",west,O_Task] spawn OKS_TASKSETUP;

	// Use this if you want to use OKS Ambience scripts, this initiates them, look into the specific functions to learn more on how to use.
	//[] execVM "Scripts\OKS_Ambience\Init.sqf";

	// Use this if you want OKS Mechanized Setup in your mission - This is only for the ACE-Interact action for creating AI crew
	[] execVM "Scripts\OKS_Vehicles\OKS_Tanker.sqf";

	// Use this if you want to make use of the Dynamic Functions by Oksman
	[] execVM "Scripts\OKS_Dynamic\Init.sqf";

		sleep 5;
		if(!isNil "NEKY_ACE_AddAction" && !isNil "NEKY_AddAction") then {
			[] spawn NEKY_ACE_AddAction;

			if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
				[flag_west_1, "Paradrop Reinsert", "DZ Alpha", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
			};
			if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
				[flag_east_1, "Paradrop Reinsert", "DZ Bravo", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
			};
			if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
				[flag_independent_1, "Paradrop Reinsert", "DZ Charlie", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
			};
		};

		/*
		   Params
		   0 - Trigger Name (Object)
		   1 - Split Trigger into 4 Sub-Triggers? (Boolean)
		   1 - Number of Infantry - [Static Integer,Patrol Integer,SearchLocationsAutomatically] (Array) - "Place Locations from Modules to decide the strongpoint position yourself"
		   2 - Side (WEST, EAST, INDEPENDENT)
		   3 - Wheeled Patrols (Integer/Number)
		   4 - APC Patrols (Integer/Number)
		   5 - Tank Patrols (Integer/Number)
		   6 - Roadblocks [RoadBlocksCount,OnlyOnTarmac] (Number/Bool)
		   7 - Mortar Pits (Integer/Number)
		   8 - Random Objectives (Integer/Number)
		   9 - Hunt Array Bases [Infantry,Wheeled,APC,Tank,Helicopter]

		   [Trigger_1,false,[30,40],independent,3,0,0,[2,true],1,2] spawn OKS_CreateZone;
		*/

		/* Example of Dynamic Scripts
			if(isServer) then {
				[Trigger_1,false,[75,0,true],east,1,1,1,[0,true],0,2,[0,0,0,0,0]] spawn OKS_CreateZone;
			};
		*/
		// Below are examples of how to use the hunt/airdrop bases
		// These codes should be put in SpawnList unless you want them to start "searching" from the start of the mission.
		// [Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,independent,6,30] spawn NEKY_Hunt_HuntBase;
		// [Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,independent,"CUP_I_LR_MG_AAF",30] spawn NEKY_Hunt_HuntBase;
		// [Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn NEKY_Airbase;

		if(isServer && !isNil "NEKY_AI_ShareInfo") then {
			[True,True] call NEKY_AI_ShareInfo;
		};