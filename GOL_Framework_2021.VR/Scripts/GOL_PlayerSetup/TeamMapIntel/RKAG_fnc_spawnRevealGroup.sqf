
params["_group"]; 

clearGroupIcons (_group); 
private _mkrType = [_group] call RKAG_fnc_getGroupNATOMarkerType; 
private _id = (_group) addGroupIcon [_mkrType, [0,0]]; 
_group setGroupIconParams [([side _group, false] call BIS_fnc_sideColor),"",1,true]; 

while {!(_group isEqualTo grpNull) && (_group in RKAGRevealedGroups)} do  
{ 
	_mkrType = [_group] call RKAG_fnc_getGroupNATOMarkerType; 
	_group setGroupIcon [_id, _mkrType]; 

	comment "Check if any units are alive"; 
	private _i = units _group findIf {alive _x}; 
	if (_i < 0) then {
		_group setGroupIconParams [[0,0,0,0.75],"",1,true];
	}; 
	sleep 1; 
}; 

comment "Show last location"; 
private _j = units _group findIf {alive _x}; 
if (!(_group isEqualTo grpNull) && (_j > -1) && (side _group != ([player] call GW_Common_Fnc_getSide))) then {
	[_group] spawn RKAG_fnc_spawnLastKnownPositionMarker
}; 

clearGroupIcons (_group); 
