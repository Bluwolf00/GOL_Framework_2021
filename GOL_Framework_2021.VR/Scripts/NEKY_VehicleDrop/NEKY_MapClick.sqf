//	[side, "heli type classname" (default mid size heli of said side), ["spawn",_Pos,"despawn"], (Vulnerable, true or false), "Vehicle ClassName", [attach,to,adjustment], Vehicle Crew/cargo Side, % of cargo, [Waypoints], {CODE}] execVM "Scripts\NEKY_VehicleDrop\NEKY_MapClick.sqf";
//	
//	A function to run the script on the server
//	
//	Made By NeKo-ArroW

Private ["_Index","_Name","_Temp"];

_Pos = ((_This select 2) select 1);

SystemChat "Pilot: Coordinates recieved, Helicopter inbound.";

//	Run main script
[_This, "Scripts\NEKY_VehicleDrop\NEKY_VehicleDrop.sqf"] remoteExec ["BIS_fnc_ExecVM", 2];

//	Create Unique Marker Name for the first marker
_Index = 0;
_Name = "NEKY_MARKER";
_Temp = Format ["%1%2",_Name,_Index];
While {!(((markerType _Temp) == "") && ((MarkerShape _Temp) == ""))} do
{
	_Index = _Index +1;
	_Temp = Format ["%1%2",_Name,_Index];
};
_Name = Format ["%1%2",_Name,_Index];
sleep 0.5;

// Create Marker
_Marker = CreateMarker [_Name, _Pos];
_Marker setMarkerType "selector_selectedFriendly";
_Marker setMarkerColor "ColorBlack";
_Marker SetMarkerText "Vehicle Drop";
_Marker SetMarkerSize [1,1];
[_Marker] spawn {sleep 300; DeleteMarker (_This select 0)};