/*
 * Author: Oksman
 * Custom daytime parameter function that allows "Mission Defined" option
 * 
 * Arguments:
 * 0: Hour override <NUMBER> (default: -1)
 *    -1 = Mission Defined (keep mission.sqm time)
 *    >= 0 = Override time with selected value
 *
 * Return Value:
 * None
 *
 * Example:
 * [-1] call GW_fnc_paramDaytime;  // Keep mission.sqm time
 * [12] call GW_fnc_paramDaytime;  // Set to noon
 *
 * Public: No
 */

params [["_hourOverride", -1]];

// Only override if value is >= 0 (not "Mission Defined")
if (_hourOverride >= 0) then {
    private _date = date;
    _date set [3, floor _hourOverride];
    _date set [4, (_hourOverride - floor _hourOverride) * 60];
    setDate _date;
    
    diag_log format ["[GW] Mission time overridden to: %1", _hourOverride];
} else {
    diag_log "[GW] Mission time kept as defined in mission.sqm";
};
