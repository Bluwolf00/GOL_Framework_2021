//	[SIDE, NumberOfUnits, TriggerZone, Distance, UpdateFrequency, Repeat, {CODE}] Spawn NEKY_Hunt_Run;
//
/////////////////
/*	IMPORTANT  */
/////////////////
//
//	Put the code below in your init.sqf. If you do not have an init.sqf, create one in the mission folder.
//		[] execVM "Scripts\NEKY_Hunt\Init.sqf";
//	Make sure you put the NEKY_Hunt script folder in
//		yourmissionfolder\Scripts\
//
//////////////////
/*	Parameters	*/
//////////////////
//
//	1. Side.																				Side, Group, Unit
//		a) Side of which new AI will spawn. WEST/BLUFOR EAST/OPFOR INDEPENDENT
//		b) Can also be a pre-existing AI group. (Group Unit1)
//		c) Can also be a single unit (Script will select his group)
//	2. Number of units.																		Number
//		a) How many units you want to spawn in to this group.
//		b) Enter nil if you are using a pre-existing group or unit.
//	3. Trigger Zone.																		Object
//		a) The trigger which will be the "Hunting Grounds"
//		b) Give the trigger a Variable name.
//		c) Seelct "Anybody" in the Activation list.
//		d) Adjust the size of the zone.
//		e) AI will not hunt players outside of this zone.
//	4. Distance.																			Number
//		a) How far away from the player the AI will spawn (Roughly).
//		b) This will also be used to make sure no player is near the AI spawn position.
//		c) A pre-existing group may despawn and respawn closer to the target if target
//		   is outside (Distance * 2). Enter a very high value if you do not want it to
//		   despawn and respawn closer to the target.
//		d) OPTIONAL, Defaults as what is entered in settings.sqf
//	5. Update Frequency. 																	Number
//		a) How often the AI team will be updated with the player position.
//		b) OPTIONAL, Defaults as what is entered in settings.sqf
//	6. Repeat																				Number
//		a) How many times you hunting team to respawn.
//		b) 0 = no respawning. 100 = the hunting team will respawn up to 100 times.
//		c) This also works for a pre-existing group.
//		d) A disabled zone will disable respawning.
//		e) OPTIONAL, Defaults as 0.
//	7. {Code}																				{Code}
//		a) Code to be executed when the AI group has spawned and are hunting.
//		b) Passed arguments are [AI Group, Player, Zone]
//		c) This code is spawned
//		d) This code is only executed on HC or Server, depending on which runs it.
//		e) OPTIONAL, if you do not know what this is, don't use it.
//
//	Examples:
//	[EAST, 4, Zone1, 600] Spawn NEKY_Hunt_Run;
//	[MyUnit, 3, Trigger1] Spawn NEKY_Hunt_Run;
//	[EnemyGroup, 0, Trigger1, nil, nil, {SystemChat "Enemy Group: We're on the trace!"}] Spawn NEKY_Hunt_Run;
//	[Enemies, 0, Zone1, 0, 10] Spawn NEKY_Hunt_Run;
//
/////////////
/*	NOTES  */
/////////////
//
//	The hunting group will be given two waypoints, first one is about 300m before reaching the player. The second is randomly within 75m of the player.
//	The hunting group will move to the first waypoint in "AWARE" behaviour and combat mode "YELLOW". When moving to the second waypoint they will change behaviour to "COMBAT" while combat mode stays the same.
//	The hunting group will despawn if too far away from all players (based upon ForceRespawnMultiplier and MinDistance in Settings.sqf)
//	Every update (Update Freq) will give the hunting team updated information about the prey's group and position, this will improve how the hunting team engages the player.
//	If the script was run while a zone was enabled but does not have any players in it, it will loop until a player enters it or the zone is disabled.
//
//	Use:
//		TriggerZone SetVariable ["NEKY_Hunt_Disabled",True,True];
//	in order to disable a zone. (No units can be spawned when script is run for the zone)
//
//	Use:
//		TriggerZone SetVariable ["NEKY_Hunt_Disabled",False,True];
//	to enable it again. (Units can now be spawned when running the script)
//
//	You can change things in Settings.sqf to fit your preferences.
//
//////////////
//
//	This is the main script for NEKY_Hunt
//
//	Made by NeKo-ArroW
//	Version 1.0

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script
Private ["_Grp","_SkillVariables","_Skill","_Units","_Leaders","_MinDistance","_UpdateFreqSettings","_ForceRespawnMultiplier"];
Params
[
	["_Side", WEST, [SideUnknown, GrpNull, ObjNull]],
	["_Number", 3, [0]],
	["_Zone", ObjNull, [ObjNull]],
	["_Distance", 0, [0]],
	["_UpdateFreq", 0, [0]],
	["_Repeat", 0, [0]],
	["_Code", {}, [{}]]
];

_isSide = ((typeName _Side) == "SIDE");
if (_Number == 0 && _isSide) exitWith {SystemChat "NEKY_Hunt: ERROR, spawn 0 units"};
if (isNull _Zone) exitWith {SystemChat "NEKY_Hunt: ERROR, No trigger zone."};
if (_Zone getVariable ["NEKY_Hunt_Disabled",false]) exitWith {}; // Exit if Zone is disabled.

// Load settings
_Settings = [] Call NEKY_Hunt_Settings;
_Settings Params ["_MinDistance","_UpdateFreqSettings","_SkillVariables","_Skill","_Leaders","_Units"];
if (_UpdateFreq == 0) then {_UpdateFreq = _UpdateFreqSettings +1};
if (_Distance == 0) then {_Distance = _MinDistance +1};

// Scan zone for players
_Temp = [_Zone] Call NEKY_Hunt_ScanZone; // Returns players
WaitUntil {Sleep 1; !isNil "_Temp"};

// Select a player to hunt and find suitable position to spawn
_Players = _Temp;
_Temp = [_Players,_Zone,_Distance] Call NEKY_Hunt_SelectPlayer; // Returns [Number of Players too close, Position to spawn at, Selected player]
WaitUntil {Sleep 1; !isNil "_Temp"};

if (_Zone getVariable ["NEKY_Hunt_Disabled",false]) exitWith {};
_Temp Params ["_Count","_SpawnPos","_Player"];
if (_Count != 0) exitWith {_This Spawn NEKY_Hunt_Run};	// Exits and loops function.

if (_isSide) then
{
	/*
	_Temp = [_Side,_Number,_Leaders,_Units,_SpawnPos] Call NEKY_Hunt_Spawn; // Returns AI Group
	WaitUntil {Sleep 1; !isNil "_Temp"};

	// Set AI group skill
	_Grp = _Temp;
	[_Grp,_SkillVariables,_Skill] Call NEKY_Hunt_SetSkill;
	*/
} else {
	if ((typeName _Side) == "GROUP") then {_Grp = _Side};
};


// Start hunting
[_Grp,_Player,_Zone,_UpdateFreq,_Distance,_Number,_Code,_ForceRespawnMultiplier,_Repeat] Spawn NEKY_Hunt_Hunting;

// Execute code
[_Grp, _Player, _Zone] Spawn _Code;