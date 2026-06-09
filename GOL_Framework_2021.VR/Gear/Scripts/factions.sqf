// GW Gear — Thin Faction Switcher (Mission Local, Addon-Aware)
// Used by fnc_Handler_Addon.sqf when the GW_Gear addon is present.
// Only the mission-specific CUSTOM-* factions are dispatched locally;
// all standard factions are delegated to the addon's factions_standard.sqf.

switch (_side) do {
	case "CUSTOM-W": {
		#include "..\..\CustomGear\CUSTOM-W.sqf"
	};
	case "CUSTOM-I": {
		#include "..\..\CustomGear\CUSTOM-I.sqf"
	};
	case "CUSTOM-E": {
		#include "..\..\CustomGear\CUSTOM-E.sqf"
	};
	default {
		#include "\x\gw\addons\gear\scripts\factions_standard.sqf"
	};
};


