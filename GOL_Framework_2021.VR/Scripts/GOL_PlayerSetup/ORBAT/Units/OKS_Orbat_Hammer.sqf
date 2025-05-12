
// Set FAC
// [] spawn OKS_Orbat_Hammer;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer";

/// Change Commander name if applicable
if(!isNil "wfac") exitWith {
	if((alive wfac)) then {	
		[wfac,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[wfac,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "efac") exitWith {
	if((alive efac)) then {	
		[efac,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[efac,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;