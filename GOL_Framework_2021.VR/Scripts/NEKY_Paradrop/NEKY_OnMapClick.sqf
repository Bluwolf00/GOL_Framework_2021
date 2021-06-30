//	[DropZone] execVM "Scripts\NEKY_Paradrop\NEKY_OnMapClick.sqf";
//
//	This handles recieving a new position and bypassing the position to NEKY_MoveTrigger.sqf
//
//	Made by NeKo-ArroW

Params [ ["_DropZone",ObjNull,[ObjNull]] ];

NEKY_Paradrop_NewPosReady = false;

[Player, SystemChat "HQ: Select a new paradrop zone."] onMapSingleClick {NEKY_Paradrop_NewPos = _pos; NEKY_Paradrop_NewPosReady = True};
[] execVM "Scripts\NEKY_Paradrop\NEKY_MapClose.sqf";
WaitUntil {!VisibleMap or NEKY_Paradrop_NewPosReady};

if (!VisibleMap && !NEKY_Paradrop_NewPosReady) exitWith {False};
[_DropZone,NEKY_Paradrop_NewPos] execVM "Scripts\NEKY_Paradrop\NEKY_MoveTrigger.sqf";
NEKY_Paradrop_NewPos = nil;
NEKY_Paradrop_NewPosReady = nil;