/*
 	execVM "Scripts\GOL_PlayerSetup\TeamMapIntel\init.sqf";
*/

SLT_fnc_enableScript = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\SLT_fnc_enableScript.sqf";
SLT_fnc_RE_Server = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\SLT_fnc_RE_Server.sqf";
SLT_fnc_init = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\SLT_fnc_init.sqf";
SLT_fnc_disableScript = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\SLT_fnc_disableScript.sqf";
RKAG_fnc_createMapTooltip = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_createMapTooltip.sqf";
RKAG_fnc_createMapHideMarkersCheckbox = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_createMapHideMarkersCheckbox.sqf";
RKAG_fnc_getGroupNATOMarkerType = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_getGroupNATOMarkerType.sqf";
RKAG_fnc_spawnRevealGroup = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_spawnRevealGroup.sqf";
RKAG_fnc_hideGroup = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_hideGroup.sqf";
RKAG_fnc_hideMapTooltip = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_hideMapTooltip.sqf";
RKAG_fnc_showMapTooltip = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_showMapTooltip.sqf";
RKAG_fnc_spawnLastKnownPositionMarker = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_spawnLastKnownPositionMarker.sqf";
RKAG_fnc_spawnFireEffect = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_spawnFireEffect.sqf";
RKAG_fnc_tryInitUnit = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\TeamMapIntel\RKAG_fnc_tryInitUnit.sqf";

with uiNamespace do {SLTScriptDisplayName = "Team Map Intel";}; 

if (time < 1) then  
{ 
 	[] call SLT_fnc_enableScript; 
} 
else  
{ 
 	[false] call SLT_fnc_init; 
};