//	#include "Settings.sqf"
//	
//	Settings for the main NEKY_CombatExperience script. You can turn modules on and off in here.
//	
//	Made by NeKo-ArroW
//	Version 1.01

// Enable and Disable modules.
_Modules = [	// TRUE = On. FALSE = Off.
	False,	// Module: Medical
	False,	// Module: Menu
	False,	// Module: KeyPress
	False,	// Module: Animations
	False,	// Module: Tracker
	False,	// Module: HUD
	True,	// Module: AI
	False	// Module: Misc
];

// Miscellanous settings (Applied when loading through). Enter FALSE to disable.
_Weight = FALSE; 			// This changes how much your characters weight affects your stamina. 1 = normal, 0 = Weight does not affect stamina.