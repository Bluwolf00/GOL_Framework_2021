	/*
		NOTE FOR SCRIPTS BELOW!

		All the scripts below are located in different folders where this file is located.
		If you wish to use these scripts you must import those scripts into their correct folders and uncomment the code.

		The code below belongs in the main init.sqf in the template.
	*/

	// This code should be added to the GOL_PlayerSetup init.sqf
	// if(GOL_NEKY_PARADROP isEqualTo 1) then {
	// 	execVM "Scripts\NEKY_Paradrop\Init.sqf";
	// 	sleep 2;
	// 	[] spawn NEKY_ACE_AddAction;
	// };

	// if(GOL_OKS_SUPPORT isEqualTo 1) then {
	// 	[] execVM "Scripts\OKS_Support\Init.sqf";
	// };
	// if(GOL_NEKY_PICKUP isEqualTo 1) then {
	// 	execVM "Scripts\NEKY_Pickup\ACE_PickUp.sqf";
	// };
	// if(GOL_OKS_REINFORCEMENT isEqualTo 1) then {
	// 	execVM "Scripts\OKS_Reinforcement\ACE_Reinforcement.sqf";
	// };
	// if(GOL_NEKY_FASTROPE isEqualTo 1) then {
	// 	if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
	// 		[flag_west_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
	// 	};
	// 	if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
	// 		[flag_east_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
	// 	};
	// 	if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
	// 		[flag_independent_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Fastrope_Insert.sqf";
	// 	};
	// };
	// if(GOL_NEKY_REINSERT isEqualTo 1) then {
	// 	if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
	// 		[flag_west_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
	// 	};
	// 	if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
	// 		[flag_east_1,30,NEKY_PARADROP_TRIGGER] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
	// 	};
	// 	if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
	// 		[flag_independent_1,NEKY_PARADROP_TRIGGER,30] execVM "Scripts\NEKY_PickUp\OKS_Reinsert.sqf";
	// 	};
	// };
	// if(GOL_NEKY_SHARE isEqualTo 1) then {
	// 	Call Compile PreProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Init.sqf";
	// };
	// if(GOL_AAC_SETUP isEqualTo 1) then {
	// 	[] execVM "Scripts\OKS_AAC\Init.sqf";
	// };
	// if(GOL_OKS_TANKER isEqualTo 1) then {
	// 	[] execVM "Scripts\OKS_Vehicles\OKS_Tanker.sqf";
	// };
	// if(isServer && GOL_NEKY_SHARE isEqualTo 1) then {
	// 	[True,True] call NEKY_AI_ShareInfo;
	// };
	// if(GOL_NEKY_PARADROP isEqualTo 1) then {
	// 	waitUntil {sleep 1; !(isNil "NEKY_ACE_AddAction") && !(isNil "OKS_FRIENDLY_SIDE")};		
	// 	if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
	// 		[flag_west_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
	// 	};
	// 	if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
	// 		[flag_east_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1400,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
	// 	};
	// 	if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
	// 		[flag_independent_1, "Paradrop Reinsert", " Dropsite", NEKY_PARADROP_TRIGGER, true,1000,100,false] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
	// 	};
	// };
	// if(GOL_OKS_MHQ_PARADROP isEqualTo 1) then {
	// 	OKS_MHQ_Paradrop = compile preprocessFileLineNumbers "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
	// 	waitUntil {sleep 1; !(isNil "OKS_MHQ_Paradrop") && !(isNil "OKS_FRIENDLY_SIDE")};
	// 	private _AMHQ = AMHQ_1;     /* The Air Mobile Headquarters Vehicle */
	// 	private _Steerable = true; /* Decide if parachute should be steerable or not */
	// 	private _Height = 200;      /* Altitude in meters where parachute is opened automatically */
	// 	if(!isNil "flag_west_1" && OKS_FRIENDLY_SIDE isEqualTo west) then {
	// 		[flag_west_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
	// 	};
	// 	if(!isNil "flag_east_1" && OKS_FRIENDLY_SIDE isEqualTo east) then {
	// 		[flag_east_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
	// 	};
	// 	if(!isNil "flag_independent_1" && OKS_FRIENDLY_SIDE isEqualTo independent) then {
	// 		[flag_independent_1, _AMHQ, _Steerable, _Height] execVM "Scripts\NEKY_Paradrop\OKS_MHQ_Paradrop.sqf";
	// 	};
	// };
	// if(GOL_OKS_Tracker isEqualTo 1) then {
	// 	[] execVM "Scripts\OKS_Tracker\Init.sqf";
	// };
	// if(GOL_OKS_Stealth_Mission isEqualTo 1) then {
	// 	player setUnitTrait ["camouflageCoef",0.4];
	// };