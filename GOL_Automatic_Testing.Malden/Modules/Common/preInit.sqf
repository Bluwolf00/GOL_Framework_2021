#include "script_Component.hpp"

PREP(buildingPop);
PREP(empty);
PREP(getGroupType);
PREP(setAttributes);
PREP(setGroupAction);
PREP(setGroupColor);
PREP(setGroupid);
PREP(simpleRoster);
PREP(spawnGroup);
PREP(spawnHandler);
PREP(spawnObjects);

if (is3DEN) then {
	PREP(setAttributes3DEN);
	PREP(spawn3DEN);
	PREP(spawn3DENObjects);
};

GVAR(spawnActive) = false;
GVAR(spawnQueue) = [];

[
	QGVAR(Faction), "LIST",
	["AI Spawn Side", "Side for units to spawn on"],
	QUOTE(ADDON),
	[
		[
			"west",
			"east",
			"independent",
			"civilian"
		],
		[
			"West",
			"East",
			"Independent",
			"Civilian"
		],
		0
	],
	1
] call FUNCMAIN(settingsInit);

[QGVAR(AutoLock), "CHECKBOX", ["Auto Lock Vehicles", "Note: Only effects vehicles with units in and spawned though the framework"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
[QGVAR(BlockAIGear), "CHECKBOX", ["Blocks access to ai Inventories", "Stops players from being able to scavenge dead AI"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
[QGVAR(autoDelete), "CHECKBOX", ["Auto Delete Forgotten Units", "Automaticly deletes units and objects located at [0,0,0] after 10 seconds if not moved"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
[QGVAR(autoQueue), "CHECKBOX", ["Queue Spawnlist", "Queue spawned units to prevent lag and will autotmaticly delay next group until current is finished"], QUOTE(ADDON), true, CBA_SERVEROVERWRITE] call FUNCMAIN(settingsInit);
