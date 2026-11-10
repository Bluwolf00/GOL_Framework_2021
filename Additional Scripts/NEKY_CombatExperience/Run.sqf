//	Call Compile PreProcessFileLineNumbers "Scripts\NEKY_CombatExperience\Run.sqf";
//	
//	This function will apply the effects selected in Settings.sqf.
//
//	Made by NeKo-ArroW
//	Version 1.03

#include "Settings.sqf"

// List of Functions
_Functions = [
	"Scripts\NEKY_CombatExperience\Modules\Medical\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\Menu\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\KeyPress\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\Animations\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\Tracker\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\HUD\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\AI\Init.sqf",
	"Scripts\NEKY_CombatExperience\Modules\Misc\Init.sqf"
];

// Execute functions based upon settings file.
{
	if (_x) then { Call Compile PreProcessFileLineNumbers (_Functions Select _ForEachIndex) };
} forEach _Modules;

// Miscellaneous functions
if !(hasInterface) exitWith {};

// Set weight
[_Weight] Spawn 
{
	Params ["_Weight"];
	WaitUntil {Sleep 0.1; !isNull Player && Time > 0};

	if (TypeName _Weight == "SCALAR") then { Player setunittrait ["loadCoef",_Weight] };
};

// Create Note
//	[_Modules, _Weight] call NEKY_CombatExperience_CreateNote;