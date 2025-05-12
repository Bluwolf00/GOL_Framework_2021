
// Set FAC
// [] spawn OKS_Orbat_Hammer;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "Echo1";

/// Change Commander name if applicable
if(!isNil "wecho1") exitWith {
	if((alive wecho1)) then {	
		[wecho1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[wecho1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "eecho1") exitWith {
	if((alive eecho1)) then {	
		[eecho1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[eecho1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;