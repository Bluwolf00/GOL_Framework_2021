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

	execVM "Scripts\OKS_Vehicles\Init.sqf";	
	execVM "Scripts\OKS_Vehicles\OKS_StaticPacking.sqf";	

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
				waitUntil {sleep 1; !isNil "OKS_RemoveVehicleHE"};
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
	if(GOL_OKS_Tracker isEqualTo 1) then {
		[] execVM "Scripts\OKS_Tracker\Init.sqf";
	};
	if(GOL_OKS_Stealth_Mission isEqualTo 1) then {
		player setUnitTrait ["camouflageCoef",0.4];
	};

Sleep 10;

	if(GOL_OKS_TASK isEqualTo 1) then {
		[] execVM "Scripts\OKS_TASK\Init.sqf";
		waitUntil{sleep 1; !(isNil "OKS_TASKSETUP") && !(isNil "OKS_FRIENDLY_SIDE")};
		/*	[Task_Object_1,1,GetMarkerPos "Task_1",west,O_Task] spawn OKS_TASKSETUP;	*/
	};