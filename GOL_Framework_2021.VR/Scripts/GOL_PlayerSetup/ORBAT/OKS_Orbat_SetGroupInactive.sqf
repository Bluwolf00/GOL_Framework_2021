
/*

	[
		_PlatoonLeader,
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon"
	] execVM "Scripts\GOL_PlayerSetup\OKS_DynamicOrbat_SetGroupInactive.sqf";

*/

Params ["_Unit","_OrbatPath"];

_ORBATOverlayId = [_OrbatPath, "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
if(!isNil "_Unit") then {
	_Unit setVariable ["ORBATOverlayId",_ORBATOverlayId,true];
} else {
	missionNamespace setVariable [str _OrbatPath,_ORBATOverlayId];
};