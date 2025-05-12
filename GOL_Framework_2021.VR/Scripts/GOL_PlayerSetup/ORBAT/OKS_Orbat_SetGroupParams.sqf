
/*

	[_PlatoonLeader,"Infantry",missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon"] execVM "Scripts\GOL_PlayerSetup\OKS_Orbat_SetGroupParams.sqf";

*/
Params [
	"_Unit",
	"_OrbatPath",
	["_CustomCallsign",nil,["",objNull]],
	["_Composition",nil,[""]]
];
private _Side = (str OKS_FRIENDLY_SIDE);
private ["_CustomName","_CustomRank"];
if(isNil "_Unit") then {
	_CustomName = "Unassigned";
	_CustomRank = "";
} else {
	_CustomName = (name _Unit);
	_CustomRank = (rank _Unit);
};

_AssignedCallsign = _Unit getVariable ["OKS_Callsign",nil];
if(!isNil "_AssignedCallsign") then {
	_CustomCallsign = _AssignedCallsign;
};
_AssignedComposition = _Unit getVariable ["OKS_Composition",nil];
if(!isNil "_AssignedComposition") then {
	_Composition = _AssignedComposition;
};

if(!isNil "_CustomCallsign") then {
	if(!isNil "_Composition") then {
		[
			_OrbatPath,
			nil, nil, _Composition, _Side, _CustomCallsign, _CustomCallsign, nil, nil, nil, nil, _CustomName, _CustomRank, nil, 
			[
				typeof (vehicle _Unit)
			]
		] call BIS_fnc_ORBATSetGroupParams;
	} else {	
		[
			_OrbatPath,
			nil, nil, nil, _Side, _CustomCallsign, _CustomCallsign, nil, nil, nil, nil, _CustomName, _CustomRank, nil, 
			[
				typeof (vehicle _Unit)
			]
		] call BIS_fnc_ORBATSetGroupParams;	
	};
} else {
	if(!isNil "_Composition") then {	
		[
			_OrbatPath,
			nil, nil, _Composition, _Side, nil, nil, nil, nil, nil, nil, _CustomName, _CustomRank, nil, 
			[
				typeof (vehicle _Unit)
			]
		] call BIS_fnc_ORBATSetGroupParams;	
	} else {
		[
			_OrbatPath,
			nil, nil, nil, _Side, nil, nil, nil, nil, nil, nil, _CustomName, _CustomRank, nil, 
			[
				typeof (vehicle _Unit)
			]
		] call BIS_fnc_ORBATSetGroupParams;	
	}	
};

// If unit doesn't exist.
_ORBATOverlayId = missionNamespace getVariable [str _OrbatPath,-1];
if(_ORBATOverlayId > -1) then {	
	[_OrbatPath, _ORBATOverlayId] call BIS_fnc_ORBATRemoveGroupOverlay;
};

// If unit exists.
_ORBATOverlayId = _Unit getVariable ["ORBATOverlayId",-1];	
if(_ORBATOverlayId > -1) then {	
	[_OrbatPath, _ORBATOverlayId] call BIS_fnc_ORBATRemoveGroupOverlay;
};