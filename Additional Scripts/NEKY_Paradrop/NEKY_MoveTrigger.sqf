//	[DropZone (Trigger), NewPos [0,0,0]] execVM "Scripts\NEKY_Paradrop\NEKY_MoveTrigger.sqf";
//	
//	1. DropZone, The trigger that you wish to move to a new location.
//	2. NewPos [0,0,0], The new position you want the DropZone at.
//	
//	Made by NeKo-ArroW

Params
[
	["_DropZone",ObjNull,[ObjNull]],
	["_NewPos",[0,0,0],[[]]]
];

player onMapSingleClick "";
SystemChat "HQ: Paradrop zone has been updated.";

[[_DropZone,_NewPos],{ (_This select 0) setPos (_This select 1) }] remoteExec ["BIS_FNC_SPAWN",0];
_Mrk = _DropZone getVariable ["NEKY_Paradrop_AttachedMarker",false];
if (typeName _Mrk != "BOOL") then 
{ 
	[[_NewPos,_DropZone],
	{
		_Mrk = (_This select 1) getVariable ["NEKY_Paradrop_AttachedMarker",false];
		_Mrk setMarkerPosLocal (_This select 0);
	}] remoteExec ["BIS_FNC_SPAWN",0];
};