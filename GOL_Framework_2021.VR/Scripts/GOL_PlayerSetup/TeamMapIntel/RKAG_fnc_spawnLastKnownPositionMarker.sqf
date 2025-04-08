
params["_group"]; 
	
private _mkr = createMarkerLocal ["marker_"+str(count allMapMarkers),getPos leader _group]; 
_mkr setMarkerTypeLocal "mil_unknown"; 

_colorName = switch (side _group) do  
{ 
	case west: {"colorBLUFOR"}; 
	case east: {"colorOPFOR"}; 
	case independent: {"colorIndependent"}; 
	case civilian: {"colorCivilian"}; 
	default {"ColorUNKNOWN"}; 
}; 
_mkr setMarkerColorLocal _colorName; 
_mkr setMarkerSizeLocal [0.5,0.5]; 

_time = 0; 
_maxTime = RKAGLastKnownLocationMarkerTime; 
while {!(_group isEqualTo grpNull) && !(_group in RKAGRevealedGroups)} do  
{ 
	uisleep 1; 
	_time=_time+1; 
	if (_time >= _maxTime) exitWith {}; 
};

deleteMarkerLocal _mkr; 
