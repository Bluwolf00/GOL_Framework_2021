#include "script_Component.hpp"

PREP(startText);
PREP(weaponLock);

GVAR(Enabled) = false;

[
	QGVAR(TimeLimit), "LIST",
	["Starting Protection", "Disables all weapons during the first minutes of the mission"],
	QUOTE(ADDON), [[-1,1,3,5,10,15,20], ["Disabled","1 Min","3 Min","5 Min","10 Min","15 Min","20 Min"], 3], CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

[
	QGVAR(DistanceLimit), "LIST",
	["Removing Protection", "Remove weapon safety when player moves from respawn location"],
	QUOTE(ADDON), [[-1,25,50,100], ["Disabled","25 Meters","50 Meters","100 Meters"], 2], CBA_SERVEROVERWRITE
] call FUNCMAIN(settingsInit);

/*
[
	QGVAR(autoProtection), "LIST",
	["Protection Area", "Always activeates protection when in the area"],
	QUOTE(ADDON), [[0,1,2], ["Disabled","Respawn position","Airbase"], 0], false
] call FUNCMAIN(settingsInit);
*/
