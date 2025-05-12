
// Set Platoon Leader
// [] spawn OKS_Orbat_Platoon;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "AlphaTeam";

/// Change Commander name if applicable
if(!isNil "w2a1") exitWith {
	if((alive w2a1)) then {	
		[w2a1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[w2a1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "e2a1") exitWith {
	if((alive e2a1)) then {	
		[e2a1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[e2a1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;