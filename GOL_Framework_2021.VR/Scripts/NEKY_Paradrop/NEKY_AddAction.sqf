//	[This, "AddAction name", "Visible Marker Text", Drop Zone (Trigger name), if steerable (true/false), Drop Height (number), deploy chute height (number), Allow Moving Trigger (True/False)] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
//
//	1. This, the object which the addaction will be attached to.
//	2. "AddAction name", the name you want the addaction to have. It will be in red and with a * at the start and end of the name. Default: "Reinsert by paradrop".
//	3. "Visible Marker Text", This is the text that will be seen next to the marker. Default: "Paradrop".
//	4. Drop Zone, Place a trigger and name it, adjust trigger size for how big the drop zone should be. (No further input neccessary)
//	5. if Steerable, type:   True    if you want a steerable parachute. if you want a non-steerable, type:   False.  Default: true
//	6. Drop Height, at what height (above land!) to be dropped off at. Default: 700m
//	7. Deploy Chute Height, the height (above land!) in meters that the parachute should start deploying. Default: 100m.
//	8. Allow Moving Trigger, This option adds an addaction for moving the trigger and marker for the Drop Zone. Default: False;
//
/////////////
//	EXAMPLES
/////////////
//
//	null = [This, nil, nil, NEKY_Paradrop,nil,700] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
//	null = [This, "Paradrop at forest", "Paradrop_Forest", ParadropTrigger, false, 500] execVM "Scripts\NEKY_Paradrop\NEKY_AddAction.sqf";
//
//	Made by NeKo-ArroW
//	Version 1.01

if !(hasInterface) exitWith {False};

WaitUntil {Sleep 1; Count AllPlayers > 0};

#include "NEKY_Settings.sqf";
Private ["_Color"];

Params
[
	["_Obj",ObjNull,[ObjNull]],
	["_Name","Reinsert by Paradrop",[""]],
	["_VisibleName","Paradrop",[""]],
	["_DropZone",ObjNull,[ObjNull]],
	["_Steerable",true,[true]],
	["_DropHeight",700,[0]],
	["_Height",100,[0]],
	["_AllowMove", false, [true]]
];

_NewName = Format ["<t color='#FF0000'>* %1 *</t>",_Name];

_Obj addAction [_NewName,
{
	_Obj = (_This select 0);
	_Player = (_This select 1);
	_Params = (_This select 3);
	_DropZone = (_Params select 0);
	_Steerable = (_Params select 1);
	_DropHeight = (_Params select 2);
	_Height = (_Params select 3);

	if (isNull _DropZone) exitWith {SystemChat "Debug: No paradrop position available."};

	[_Player, _DropZone, _Steerable, _DropHeight, _Height] execVM "Scripts\NEKY_Paradrop\NEKY_Paradrop.sqf";

},[_DropZone,_Steerable,_DropHeight,_Height],10,false,true,"","((_target distance _this) < 7) && !(vehicle player != player) && NEKY_Paradrop_AllowReinsert"];

if (_AllowMove) then
{
	_NewName = Format ["<t color='#58D3F7'>* Move drop zone: %1 *</t>",_Name];
	_Obj addAction [_NewName,
	{
		_Params = (_This select 3);
		_DropZone = (_Params select 0);

		OpenMap True;
		[_DropZone] execVM "Scripts\NEKY_Paradrop\NEKY_OnMapClick.sqf";
	},[_DropZone],0,false,true,"","((_target distance _this) < 7) && !(vehicle player != player) && NEKY_Paradrop_AllowReinsert"];
};

// Create and attach a marker to the dropzone trigger.
if (_Settings_MarkerColor == "AUTO") then
{
	Switch (Side (Group Player)) do
	{
		case BLUFOR: {_Color = "ColorBlufor"};
		case OPFOR: {_Color = "ColorOpfor"};
		case INDEPENDENT: {_Color = "ColorIndependent"};
		default {_Color = "ColorBlack"; systemChat "DEBUG - NEKY_Paradrop - AddAction - Faction not found"};
	};
} else {
	_Color = _Settings_MarkerColor;
};

_MarkerName = (Format ["NEKY_%1_Marker",_DropZone]);
_Mrk = CreateMarkerLocal [_MarkerName,[0,0,0]];
_DropZone setVariable ["NEKY_Paradrop_AttachedMarker",_MarkerName];
_Mrk setMarkerPosLocal (getPos _DropZone);
_Mrk setMarkerDirLocal 0;
_Mrk setMarkerShapeLocal "ICON";
_Mrk setMarkerTypeLocal "respawn_para";
_Mrk SetMarkerSizeLocal [1,1];
_Mrk SetMarkerColorLocal _Color;
_Mrk SetMarkerTextLocal _VisibleName;
_Mrk SetMarkerAlphaLocal 1;