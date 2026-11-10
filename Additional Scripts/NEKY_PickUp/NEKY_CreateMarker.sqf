//	[Position, "Marker Name", "Marker Type"] execVM "Scripts\NEKY_PickUp\NEKY_CreateMarker.sqf";
//	
//	This handles creating and removing markers when requesting extraction and insertion via radio commands.
//	
//	

Private ["_Temp","_Index"];

Params ["_Pos","_MName","_Type"];

Switch (_Type) do
{
	case "insert": {_Type = "hd_end"};
	case "extract": {_Type = "hd_pickup"};
	default {_Type = "selector_selectedFriendly"};
};

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
_Marker setMarkerType _Type;
_Marker setMarkerColor "ColorBlack";
_Marker SetMarkerText _MName;
_Marker SetMarkerSize [1,1];
[_Marker] spawn {sleep 300; DeleteMarker (_This select 0)};