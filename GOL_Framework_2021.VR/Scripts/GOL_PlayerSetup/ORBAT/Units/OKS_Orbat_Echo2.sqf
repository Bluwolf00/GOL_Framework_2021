
// Set FAC
// [] spawn OKS_Orbat_Hammer;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "Echo2";

/// Change Commander name if applicable
if(!isNil "wecho2") exitWith {
	if((alive wecho2)) then {	
		[wecho2,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[wecho2,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "eecho2") exitWith {
	if((alive eecho2)) then {	
		[eecho2,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[eecho2,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;