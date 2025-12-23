/*	================================================================
	AUTHOR: GuzzenVonLidl
	Selects a new faction to spawn

	Usage:
	["West"] call GW_Common_Fnc_getGroupType;

	Parameters:
	#0:	STRING - Name of the faction to select

	Returning Value: ARRAY
	#0: SIDE - Side of group
	#1: STRING - Classname of team leader
	#2: ARRAY - Classnames

	#define NO_SIDE -1
	#define EAST 0
	#define WEST 1
	#define RESISTANCE 2
	#define CIVILIAN 3
	#define NEUTRAL 4
	#define ENEMY 5
	#define FRIENDLY 6
	#define LOGIC 7

	Public: NO
// ================================================================ */
#include "script_Component.hpp"

params ["_faction"];

if(_faction isEqualType sideUnknown) then {
	_faction = str _faction;
};
private _factionStr = toUpper _faction;
private _side = ([east,west,independent,civilian] select (getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "SpawnUnits" >> _factionStr >> "Side")));
private _leader = getArray(missionConfigFile >> "GW_FRAMEWORK" >> "SpawnUnits" >> _factionStr >> "Leaders");
private _unitList = getArray(missionConfigFile >> "GW_FRAMEWORK" >> "SpawnUnits" >> _factionStr >> "Units");

[_side, _leader, _unitList]