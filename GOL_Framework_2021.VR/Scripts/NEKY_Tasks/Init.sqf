//	[] execVM "Scripts\NEKY_Tasks\Init.sqf";
//
//	This defines all functions.
//
//	Made by NeKo-ArroW

// DO NOT TOUCH ANYTHING BELOW \\
NEKY_Tasks_Run = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Run.sqf";

if !(isServer) exitWith {}; // To avoid script errors if clumsily running NEKY_Tasks_Run in a trigger.

NEKY_Tasks_SetTaskState = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Functions\SetTaskState.sqf";
NEKY_Tasks_AvoidCasualties = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Functions\AvoidCasualties.sqf";
NEKY_Tasks_AvoidCasualties_Killed = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Functions\AvoidCasualtiesKilled.sqf";
NEKY_Tasks_AvoidDeaths = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Functions\AvoidDeaths.sqf";
NEKY_Tasks_AvoidDeaths_Killed = Compile PreprocessFileLineNumbers "Scripts\NEKY_Tasks\Functions\AvoidDeathsKilled.sqf";
// DO NOT TOUCH ANYTHING ABOVE \\


// Map screen tasks
[] Spawn
{
	UISleep 1; // Without this sleep, no tasks will be created in the briefing screen. Do not place ANY more sleeps, just place all the tasks one after the other.

	// YOU CAN EDIT THINGS BELOW THIS LINE \\
	// Tasks
	[1,["NEKY_Task1",["Hearts and Minds: Avoid causing civilian casualties as that will turn the enemy against us.","Avoid Civilian Casualties"],civilian,{}],true] spawn NEKY_Tasks_Run;
	[2,["NEKY_Task2",["War Support: Dont die, we will lose war support back home.","Avoid Deaths"],sideEmpty,{}],true] spawn NEKY_Tasks_Run;
};