	MISSION_ROOT = call {
		private "_arr";
		_arr = toArray __FILE__;
		_arr resize (count _arr - 8);
		toString _arr
	};

	/* Set GOL Mission Settings */
	Call Compile PreProcessFileLineNumbers "MissionSettings.sqf";
	
	Sleep 5;

	execVM "Scripts\GOL_PlayerSetup\init.sqf";
	if(GOL_NEKY_PARADROP isEqualTo 1 || GOL_NEKY_RESUPPLY isEqualTo 1 || GOL_NEKY_PICKUP isEqualTo 1 || GOL_OKS_SUPPORT isEqualTo 1 || GOL_NEKY_FASTROPE isEqualTo 1 || GOL_NEKY_REINSERT isEqualTo 1 || GOL_OKS_TentMHQ isEqualTo 1) then {
		if (hasInterface) then {
			_condition = {player in [wpl,wfac,w1m,w2m,epl,efac,e1m,e2m,ipl,ifac,i1m,i2m,w1a,w1a1,w1b1,wcrew1,wcrew4,e1a,e1a1,e1b1,ecrew1,ecrew4,i1a,i1a1,i1b1,icrew1,icrew4]};
			// _condition = {true}; // If you want everyone to have access to support tab (required for tent mhq to be available to all)
     	 	_action = ["Request_Support", "Request Support","\A3\ui_f\data\map\VehicleIcons\iconCrateVeh_ca.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
     		[typeOf player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
		};

		// if(GOL_NEKY_PARADROP isEqualTo 1) then {
		// 	execVM "Scripts\NEKY_Paradrop\Init.sqf";
		// 	sleep 2;
		// 	[] spawn NEKY_ACE_AddAction;
		// };
	};

	execVM "Scripts\OKS_Vehicles\Init.sqf";	
	
	if(GOL_NEKY_SERVICESTATION isEqualTo 1) then {
		[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";
	};
	if(GOL_NEKY_AIRDROP isEqualTo 1) then {
		[] execVM "Scripts\NEKY_AirDrop\Init.sqf";
	};
	if(GOL_NEKY_HUNT isEqualTo 1) then {
		[] execVM "Scripts\NEKY_Hunt\Init.sqf";
	};
	if(GOL_OKS_AMBIENCE isEqualTo 1) then {
		[] execVM "Scripts\OKS_Ambience\Init.sqf";	
	};
	if(GOL_OKS_SPAWN isEqualTo 1) then {
		execVM "Scripts\OKS_Spawn\Init.sqf";
	};
	if(GOL_OKS_DYNAMIC isEqualTo 1) then {
		[] execVM "Scripts\OKS_Dynamic\Init.sqf";
	};
	if(GOL_NEKY_TASK isEqualTo 1) then {
		[] execVM "Scripts\NEKY_Tasks\Init.sqf";
	};	
	if(GOL_OKS_TASK isEqualTo 1) then {
		[] execVM "Scripts\OKS_TASK\Init.sqf";
	};

	/*
		NOTE FOR SCRIPTS BELOW!

		All the scripts below are located in a separate folder outside the mission file in the template.
		If you wish to use these scripts you must import those scripts into their correct folders and uncomment the code.
	*/

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
	
Sleep 10;
