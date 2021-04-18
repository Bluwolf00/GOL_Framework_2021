//	[player, systemChat "Pilot: Awaiting coordinates"] onMapSingleClick {[blufor,"","drop",["spawn",_pos,"despawn"],"",false] execVM "Scripts\NEKY_Supply\NEKY_SupplyInit.sqf"};
//	
//	A function to run the script on the server and creating a marker.
//	
//	Made By NeKo-ArroW

player onMapSingleClick "";
SystemChat "Pilot: Coordinates recieved, supplies inbound.";

Private ["_Side","_HeliClass","_Type","_STDs","_Waypoints1","_Waypoints2","_BoxCode","_Vulnerable","_Marker","_Name","_Index","_Temp"];

_Side = [_This, 0, BLUFOR, [SideUnknown]] call BIS_fnc_param;
_HeliClass = toLower ([_This, 1, "", [""]] call BIS_fnc_Param);
_Type = toLower ([_This, 2, "drop", [""]] call BIS_fnc_Param);
_STDs = [_This, 3, [""], [[""],[]]] call BIS_fnc_Param;
_BoxCode = [_This, 4, "Scripts\NEKY_Supply\NEKY_SupplyBox.sqf", ["", {}]] call BIS_fnc_Param;
_Vulnerable = [_This, 5, false, [false]] call BIS_fnc_Param;

//	Run main script
[[[_Side,_HeliClass,_Type,_STDs,_BoxCode,_Vulnerable], "Scripts\NEKY_Supply\NEKY_Supply.sqf"], "BIS_fnc_ExecVM", false] call BIS_fnc_MP;

//	Create Unique Marker Name
_Index = 0;
_Name = "NEKY_MARKER";
_Temp = Format ["%1%2",_Name,_Index];
While {!(((markerType _Temp) == "") && ((MarkerShape _Temp) == ""))} do
{
	_Index = _Index +1;
	_Temp = Format ["%1%2",_name,_Index];
};
_Name = Format ["%1%2",_Name,_Index];
sleep 0.5;

// Create Marker
_Marker = CreateMarkerLocal [_Name, (_STDs select 1)];
_Marker setMarkerTypeLocal "selector_selectedMission";
_Marker setMarkerColorLocal "ColorBlack";
_Marker SetMarkerTextLocal "Supply Drop";
_Marker SetMarkerSizeLocal [1,1];

Sleep 300;
DeleteMarker _Marker;