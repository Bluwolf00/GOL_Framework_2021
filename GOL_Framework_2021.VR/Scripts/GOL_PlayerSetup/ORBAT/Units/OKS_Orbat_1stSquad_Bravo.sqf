
// Set Platoon Leader
// [] spawn OKS_Orbat_1stSquad_Bravo;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad" >> "BravoTeam";

private _CustomCallsign = objNull;
private _Composition = "Infantry";
switch (GOL_Composition) do {
	case 1: {
		_CustomCallsign = "1-1 Foxtrot";
		_Composition = "MechanizedInfantry";
	};
};

/// Change Commander name if applicable
if(!isNil "w1b1") exitWith {
	if((alive w1b1)) then {	
		[w1b1,_OrbatPath,_CustomCallsign,_Composition] spawn OKS_Orbat_SetGroupParams;
	} else {
		[w1b1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "e1b1") exitWith {
	if((alive e1b1)) then {	
		[e1b1,_OrbatPath,_CustomCallsign,_Composition] spawn OKS_Orbat_SetGroupParams;
	} else {
		[e1b1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;