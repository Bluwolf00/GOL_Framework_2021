
private ["_nearbyLocations","_town","_time","_month"];
_town = "Unknown";
_nearbyLocations = nearestLocations [position player, ["NameCityCapital","NameCity","NameMarine","NameVillage","NameLocal","Hill"], 1000];
if (count _nearbyLocations > 0) then {_town = text (_nearbyLocations select 0)};
_time = [((date select 3) * 3600) + ((date select 4) * 60), "H:MM:SS"] call CBA_fnc_formatElapsedTime;

[{
	params ["_time","_town"];
	[
		["TITLE", "Local Time and Date:"],
		["TEXT", format ["%1 - %2: %3/%4", _time,(date select 2),(date select 1),(date select 0)]],
		["TEXT", format ["Location: %2 - %1", _town, toUpper(worldName)]]
	] call FUNC(startText);
}, [_time,_town], 2] call CBA_fnc_waitAndExecute;

[{
	[
		["TITLE", format ["%1", briefingName]],
		["TEXT", format ["By: %1", getText(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Author")]],
		["TEXT", format ["Version: %1", getNumber(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "Version")]]
	] call FUNC(startText);
}, [], 8] call CBA_fnc_waitAndExecute;
