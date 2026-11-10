/*
	Author: GuzzenVonLidl
	Displays a starting text message lower right corner of the screen
	Messages are sorted the way they are inputted

	Usage:
	[
		["TITLE", format ["Mission: %1", briefingName]],
		["TEXT", format ["By: %1", (getMissionConfigValue "author")]],
		["TEXT", format ["Version: %1", getNumber (missionConfigFile >> "GW_FRAMEWORK" >> "CORE" >> "Version")]]
	] call FUNC(startText);

	Arguments:
	0: Messages <ARRAY>
		0: Type of format <TEXT>
		1: Message that will be displayed <TEXT>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
#define	ADDLINE _unparsedText = _unparsedText
#define	DELAY 5

private ["_town","_nearbyLocations","_month","_unparsedText"];
_unparsedText = "<t align='right' size='1.2'>";

{
	switch (_x select 0) do {
		case "TITLE": {
			ADDLINE + format ["<t font='PuristaBold' size='1.6'>%1</t>", _x select 1];
		};
		case "TEXT": {
			ADDLINE + format ["%1", _x select 1];
		};
	};
	ADDLINE + "<br/>";
} forEach _this;

[parsetext (_unparsedText + "</t>"), true, nil, DELAY, 0.7, 0] spawn BIS_fnc_textTiles;

if !(is3den) then {
	for "_i" from 1 to 10 step 1 do {
		[{
			playsound "ReadoutClick";
		}, [], (0.03 * _i)] call CBA_fnc_waitAndExecute;
		[{
			playsound "ReadoutClick";
		}, [], (DELAY.7 + (0.03 * _i))] call CBA_fnc_waitAndExecute;
	};
};
