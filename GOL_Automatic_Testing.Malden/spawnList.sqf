/*
	AUTHOR: GuzzenVonLidl
	Description:
		What case tha should be called for the zone player is in
	Usage:
		null = [1] spawn GW_Fnc_spawnList;
	Parameters:
		#0: Number:	Activate zone
	Returning Value:
		None
*/



#include "\OKS_GOL_Misc\script_Component.hpp"
#define	COMPONENT spawnList

if !(isServer) exitWith {false};

params [
	"_case"
];

switch (_case) do {

	case 1: {

		[Trigger_1,false,[35,25,false,false],east,2,2,2,[4,true,false,1],[2,false],[4,false],[1,1,1,0,0],false] spawn OKS_fnc_CreateZone;
		[convoy_1,convoy_2,convoy_3,east,[4,["rhs_btr60_msv"], 6, 25],[true,6],[], false, false] spawn OKS_fnc_Convoy_Spawn;
		[reinforce_1,reinforce_2,reinforce_3,west,[4,["rhs_btr60_msv"], 6, 25],[true,6], false, "variable", "small", true, true] spawn OKS_fnc_Convoy_Reinforce;
		[[barricade_1],nil,true] spawn OKS_fnc_Destroy_Barricade;

		[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,east,6,30] spawn OKS_fnc_HuntBase;
		[Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,east,"O_APC_Tracked_02_cannon_F",30] spawn OKS_fnc_HuntBase;
		[Base_3, Spawn_3, NEKY_Hunt_Trigger_1, 5,30,east,["O_APC_Tracked_02_cannon_F","O_Truck_03_transport_F"],30] spawn OKS_fnc_HuntBase;
		[Base_4,Spawn_4, NEKY_Hunt_Trigger_1,east,"O_Heli_Light_02_dynamicLoadout_F","unload",[2,1]] spawn OKS_fnc_Airbase;

		[east,arty_1,[7635.51,11268.9,0],7,300,180,false] spawn OKS_fnc_ArtyFire;
		[arty_2,[getPos ArtySuppress_1,getPos ArtySuppress_2,getPos ArtySuppress_3],east,1,1,true,true,300,true] spawn OKS_fnc_ArtySuppression;
		[arty_3,[getPos ArtySuppress_1,getPos ArtySuppress_2,getPos ArtySuppress_3],east,1,1,true,true,300,true] spawn OKS_fnc_ArtySuppression;

		[aaa_1,east,false,1500,true] spawn OKS_fnc_Ambient_AAA;
		[aaa_2,east,0] call OKS_fnc_AddVehicleCrew;

		[aaa_1] spawn OKS_fnc_Destroy_Task;
		[aaa_2] spawn OKS_fnc_Destroy_Task;
		[arty_1] spawn OKS_fnc_Destroy_Task;
		[arty_2] spawn OKS_fnc_Destroy_Task;

		[Group HVT_1,getMarkerPos "respawn_west",west,false,nil,true] spawn OKS_fnc_Evacuate_HVT;
		[Generator_1,true,true,1000] spawn OKS_fnc_PowerGenerator;

		[lambs_1,"rush",4,east,500,[]] spawn OKS_fnc_Lambs_SpawnGroup;
		[lambs_2,"hunt",4,east,500,[]] spawn OKS_fnc_Lambs_SpawnGroup;
		[lambs_3,"ambushhunt",4,east,500,[]] spawn OKS_fnc_Lambs_SpawnGroup;
		[lambs_4,"ambushrush",4,east,500,[]] spawn OKS_fnc_Lambs_SpawnGroup;

		[bomb_1,60,bombTarget_1,nil,true,false,"VariableOnSuccess","VariableOnFail"] spawn OKS_fnc_Defuse_Explosive;
		[Object_1,"sector",300,EAST,false,false,false] spawn OKS_fnc_CreateObjectives;

		// Patrols.
		[[],[["O_APC_Tracked_02_cannon_F",[6315.12,10674.2,7.62939e-05],0,[["driver",-1,[]],["cargo",-1,[0]],["cargo",-1,[0,0]]],[[6,["Hex",1]],[7,["showTracks",0,"showCamonetHull",0,"showBags",0,"showSLATHull",0]]]]],[[[6285.6,10840.7,3.8147e-05],[[0,"Move"]]],[[6046.86,10759.8,1.52588e-05],[[0,"Move"]]],[[6259.58,10697.1,0],[[0,"Cycle"]]]]] call GW_Common_fnc_spawnGroup;
		[[[[6226.85,10712,0],0,[]],[[6231.85,10707,0],0,[]],[[6221.85,10707,7.62939e-06],0,[]],[[6236.85,10702,0],0,[]],[[6216.85,10702,0],0,[]],[[6241.85,10697,7.62939e-06],0,[]],[[6211.85,10697,0],0,[]],[[6246.85,10692,7.62939e-06],0,[]]],[],[[[6272.44,10813.6,0],[[0,"Move"]]],[[6172.78,10834.1,2.14225],[[0,"Move"]]],[[6152.47,10668,0.000152588],[[0,"Move"]]],[[6216.59,10659.3,0],[[0,"Cycle"]]]]] call GW_Common_fnc_spawnGroup;

		// Static.
		[[[[6269.4,10746.8,0.931793],6,"Auto",[]],[[6276.18,10727.6,1.02114],94,"Auto",[]],[[6251.97,10774.8,0.891426],119,"Auto",[]],[[6285.37,10782.7,4.31754],31,"Auto",[]],[[6242.36,10778.6,13.4004],9,"Auto",[]],[[6235.93,10774.1,5.10952],104,"Auto",[]],[[6239.97,10774.9,18.5405],325,"Auto",[]],[[6243.77,10779.9,18.4107],306,"Auto",[]],[[6233.26,10772.9,16.0695],354,"Auto",[]],[[6238,10782.9,13.3099],328,"Auto",[]],[[6232.87,10779.1,15.9849],350,"Auto",[]],[[6236.83,10783.9,18.306],286,"Auto",[]],[[6232.56,10782.1,18.3301],137,"Auto",[]],[[6234.9,10658.7,7.62939e-06],265,"Auto",[]],[[6204.9,10658.7,0],0,"Auto",[]],[[6239.9,10653.7,0],0,"Auto",[]]],[],[]] call GW_Common_fnc_spawnGroup;
	
		// AA ISLAND.
		{
			[getPos _X, east, 50, 500, 3000, 60] spawn OKS_fnc_IR_AA;
		} foreach [aa_1, aa_2, aa_3, aa_4, aa_5];

		{
  			[_X, ["UK3CB_ADM_O_V3S_Zu23"], 2000, 2500, 100] spawn OKS_fnc_Radar;
		} foreach [radar_1,radar_2,radar_3];

		{
 			[_X, radar_1, 20, 4, 30] spawn OKS_fnc_SAM;
		} foreach [SAM_1,SAM_2,SAM_3];

		[[],[["UK3CB_ADM_O_V3S_Zu23",[9660.29,3487.79,0],221,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]],["UK3CB_ADM_O_V3S_Zu23",[9480.74,3301.27,0],221,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]],["UK3CB_ADM_O_V3S_Zu23",[9344.62,3841.23,0],221,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]],["UK3CB_ADM_O_V3S_Zu23",[9710.2,3944.7,0],280,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]],["UK3CB_ADM_O_V3S_Zu23",[10528.8,4050.07,0],221,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]],["UK3CB_ADM_O_V3S_Zu23",[11329.3,4681.83,0],320,[["driver",-1,[]],["gunner",-1,[1]]],[[6,["ADM",1]],[7,["ClanLogo_Hide",1]]]]],[]] call GW_Common_fnc_spawnGroup;
	
	};

	case 2: {
	};

	case 3: {
	};

	case 4: {
	};

	case 5: {
	};

	case 6: {
	};

	default {
		ERROR(FORMAT_1("Case missing: %1", _case));
	};
};
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*
	GOL SCRIPT EXAMPLES

	=======================================

	OKS_fnc_Createobjectives - Creates an objective based on OKS_fnc_Dynamic settings with task creation/completion.

	[Object_1,"sector",300,EAST,false,false,false] spawn OKS_fnc_CreateObjectives;

	Params: Position, Type, Range, Side, Patrols?, PlaceObjects?, OverrideTaskNotification?

	Types Available:
	sector (Clear an area)
	neutralize (Clear a building)
	cache (destroy weapons cache)
	motorpool (destroy supply vehicle)
	ammotruck (destroy a patrolling supply vehicle)
	radiotower (destroy a radiotower - decreases hunt response/respawn delay)
	hvttruck (destroy a patrolling vehicle with an HVT)
	artillery (destroy an active artillery piece)
	antiair (destroy an active anti-air position)
	hostage (secure a building with hostiles & two hostages)

    =======================================

	GW_Ambient_AAA

	Setup a scripted AAA that fires randomly into the air until it finds a target and locks on. It has less accuracy than standard AAA positions for balance.

	Code:
	[aaa_1,east,false,1500,true] spawn OKS_fnc_Ambient_AAA;

	Params:
	AAA Object, side of crew, Is an HMG, Range of AAA, Should be assisted by nearby radar

    =======================================

	OKS_fnc_ArtyFire

	Setup an artillery to fire into the sky until destroyed. Take note that it is supposed to delete the rounds from landing to save performance.
	This might fail, so make sure the target is not near friendly positions or bases.

	Code:
	[east,arty_1,getpos ArtyTarget_1,7,300,180,false] spawn OKS_fnc_ArtyFire;

	Params:
	Side of Crew, Artillery Object, Artillery Target, Rounds per Salvo, Rearm Delay, Reload Delay, Should give full crew.

    =======================================

	OKS_fnc_ArtySuppression

	Setup an active artillery barrage on specified targets until destroyed.

	Code:
	[livearty_1,[getPos ArtySuppress_1,getPos ArtySuppress_2,getPos ArtySuppress_3],east,1,1,true,true,300,true] spawn OKS_fnc_ArtySuppression;

	Params:
	Artillery Object, Array with Target positions, Side of Crew, Rounds per target, Delay per target, Unlimited Ammo, Should Loop until Destroyed, Delay per Salvo, Mark with Red Smoke on Target.

	=======================================

	OKS_fnc_Destroy_Task

	Setup a destroy/kill objective on a target.

	Code:
	[officer_1,"Kill the Officer","Enemy Officer","You need to kill this %1 because it needs to happen","kill",nil,true,true] spawn OKS_fnc_Destroy_Task;

	Params:
	Target Object, Task Title, Target Type, Task Description, Task Icon, Task Parent, Should Mark Position on Map, Should Show Popup when created/completed

	=======================================

	OKS_fnc_Evacuate_HVT

	Setup a HVT Capture Objective. The last variable sets true/false if they target should be set to captive (tied hands). False for enemy officers, true for friendly captives.

	Code:
	[Group HVT_1,getMarkerPos "respawn_west",west,false,nil,true] spawn OKS_fnc_Evacuate_HVT;

	Params:
	Group of HVT, Exfil Position (Either pickup (Extract On) or dropoff (Extract off)), Side of Extract Helicopter, Should Send AI Helicopter Evac, Parent Task, Is Captive

	=======================================

	OKS_fnc_Destroy_Barricade

	Setup Barricade Objective. Objective to destroy objects lined up as a blockade on a road. Make sure the object is destructible by testing it.

	Code:
	[[barricade_1,barricade_2],nil,false] spawn OKS_fnc_Destroy_Barricade;

	Params:
	Array with Barricade Objects

	=======================================

	OKS_fnc_Convoy_Spawn

	Spawn a convoy that moves until engaged, they will dismount, armed vehicles will hunt and dismounts will rush.

	Code:
	[spawn_1,waypoint_1,end_1,west,[4,["rhs_btr60_msv"], 6, 25],[true,6],[], false, false] spawn OKS_fnc_Convoy_Spawn;

	Params:
	Spawn Position, First Waypoint, End Waypoint (Scattered formation), Side of Convoy, Convoy Array [](Number, [TypeArray]), Speed meters/second, dispersion]
	Dismount Array (Should have dismount, how many), ConvoyArray to populate variable, forced careless (ignore everything), delete on arrival.

	=======================================

	OKS_fnc_Lambs_SpawnGroup

	Spawns a team that either creep/rush/hunt based on LAMBS. Used for quick and intense counter-attacks by enemy infantry.

	Code:
	[SpawnPos,"rush",UnitsPerBase,Side,Range,[]] spawn OKS_fnc_Lambs_SpawnGroup;

	Params:
	Position, Type of Waypoint (rush,creep,hunt), Units to spawn, Side of units, Range of waypoint (around the spawn), unit array that gets populated with the units.


	=======================================

	OKS_fnc_Defuse_Explosive

	Creates a defuse explosive objective with 600 (10 minutes) seconds to complete on the "SatchelCharge" object with the name bomb_1.
	This can be replaced with a position to create an explosive on the position using getPos bomb_1.

	Code:
	[bomb_1,600] spawn OKS_fnc_Defuse_Explosive;
	[explosive_1,60,targetObject,"Task_Main",true,false,"VariableOnSuccess","VariableOnFail"] spawn OKS_fnc_Defuse_Explosive;

	Params:
	Bomb Object or Position, Time Delay (Seconds), Target Object (Destroyed upon detonation), VariableName to set to true if failed, VariableName to set to true if succeeded.

	=======================================

	OKS_fnc_PowerGenerator

	Sets up a generator to be disabled by action to turn off light sources in the area around it. 

	Code:
	[Generator_1,true,true,1000] spawn OKS_fnc_PowerGenerator;

	Params:
	Generator Object, Should Add Action to disable, Turn Off Lights when disabled, Range of disabled lights from Generator
	
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
		   [Trigger_1,false,[0,0,false,false],east,0,0,0,[0,true,false,0],[0,false],[0,false],[0,0,0,0,0],false] spawn OKS_fnc_CreateZone;
		*/

		/* Example of Dynamic Scripts */
		/*
		if(isServer) then {
			waitUntil{sleep 5; !(isNil "OKS_fnc_CreateZone")};

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
			] spawn OKS_fnc_CreateZone;
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

			[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,east,6,30] spawn OKS_fnc_HuntBase;
			[Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,east,"O_APC_Tracked_02_cannon_F",30] spawn OKS_fnc_HuntBase;
			[Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,east,"O_APC_Tracked_02_cannon_F","O_Truck_03_transport_F"],30] OKS_fnc_HuntBase;
		*/
		/* Example of Hunt Bases */
		/*
		if(isServer) then {
			waitUntil{sleep 5; !(isNil "OKS_fnc_HuntBase")};
			[Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,600+(random 300),east,6,120+(120)] spawn OKS_fnc_HuntBase;
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

		   [Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn OKS_fnc_Airbase;
		*/
		/* Example of Air Bases */
		/*
		if(isServer) then {
			waitUntil{sleep 5; !(isNil "OKS_fnc_Airbase")};
			[Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn OKS_fnc_Airbase;
		};

