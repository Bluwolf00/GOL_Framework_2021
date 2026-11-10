Params ["_Unit","_Cache"];
//
//  [this,"Acts_PercMstpSlowWrflDnon_handup1b"] execVM "Scripts\OKS_Ambience\OKS_Loop_Animation.sqf";


if (HasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky


_Unit forceSpeed -1;
_Unit enableAI "PATH";
_Unit enableAI "MOVE";
[_Unit] join grpNull;

_Unit doMove (getPos _Cache);
_wp = (group _Unit) addWaypoint [getPos _Cache,0];

waitUntil {sleep 2; _Unit distance2D _Cache < 5};
_Unit switchMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
_Unit addWeapon "rhs_weap_ak74";
_Unit addVest "LOP_6sh46";
_Unit addMagazines ["rhs_30Rnd_545x39_7N6_AK",4];
_Unit setBehaviour "AWARE";
_Unit setUnitPos "AUTO";
deleteWaypoint [group _Unit,0];

if(!isNil "lambs_wp_fnc_taskRush") then{
	[group _Unit,500,30,[],[],true] spawn lambs_wp_fnc_taskRush;
};
