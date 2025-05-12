
// Set FAC
// [] spawn OKS_Orbat_Hammer;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "Echo3";

/// Change Commander name if applicable
if(!isNil "wecho3") exitWith {
	if((alive wecho3)) then {	
		[wecho3,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[wecho3,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "eecho3") exitWith {
	if((alive eecho3)) then {	
		[eecho3,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[eecho3,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;