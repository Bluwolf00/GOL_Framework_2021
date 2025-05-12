
// Set Platoon Leader
// [] spawn OKS_Orbat_1stSquad_Bravo;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "BravoTeam";

private _CustomCallsign = objNull;
private _Composition = "Infantry";
switch (GOL_Composition) do {
	case 1: {
		_CustomCallsign = "1-2 Golf";
		_Composition = "MechanizedInfantry";
	};
};

/// Change Commander name if applicable
if(!isNil "w2b1") exitWith {
	if((alive w2b1)) then {	
		[w2b1,_OrbatPath,_CustomCallsign,_Composition] spawn OKS_Orbat_SetGroupParams;
	} else {
		[w2b1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "e2b1") exitWith {
	if((alive e2b1)) then {	
		[e2b1,_OrbatPath,_CustomCallsign,_Composition] spawn OKS_Orbat_SetGroupParams;
	} else {
		[e2b1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;