//	Call CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Init.sqf";
//	
//	Add this to NEKY_CombatExperience\init.sqf:
//	Call CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Init.sqf";
//	
//	This initiates the AI module and its functions.
//	
//	Made by NeKo-ArroW
//	Version 1.02

// Define Functions
NEKY_AI_Run = CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Run.sqf";
NEKY_AI_LaserLoop = CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Functions\LaserLoop.sqf";
NEKY_AI_LaserScan = CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Functions\LaserScan.sqf";

if (isServer or !HasInterface) then 
{
	NEKY_AI_Surrender = CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Functions\Surrender.sqf";
	NEKY_AI_ShareInfo = CompileFinal preProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Modules\AI\Functions\ShareInfo.sqf";
};

// Run functions when loaded through
if (!HasInterface && !isServer && isMultiplayer) exitWith {}; // Exit HC

[] Spawn
{
	WaitUntil {Sleep 0.1; !IsNull Player or (isServer && !HasInterface)}; // Let server load through instantly and players wait until loaded through.
	
	Call NEKY_AI_Run;
};

