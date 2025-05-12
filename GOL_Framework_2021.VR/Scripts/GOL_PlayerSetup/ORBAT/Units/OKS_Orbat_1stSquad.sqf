
// Set Platoon Leader
// [] spawn OKS_Orbat_Platoon;
Private _OrbatPath = missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad";

/// Change Commander name if applicable
if(!isNil "w1a") exitWith {
	if((alive w1a)) then {	
		[w1a,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[w1a,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};
if(!isNil "e1a") exitWith {
	if((alive e1a)) then {	
		[e1a,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
	} else {
		[e1a,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
	};
};

if(GOL_Composition isEqualTo 1) exitWith {
	if(!isNil "w1a1") exitWith {
		if((alive w1a1)) then {	
			[w1a1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
		} else {
			[w1a1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
		};
	};
	if(!isNil "e1a1") exitWith {
		if((alive e1a1)) then {	
			[e1a1,_OrbatPath] spawn OKS_Orbat_SetGroupParams;
		} else {
			[e1a1,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
		};
	};
	[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;
};

// None active - Set to Inactive
[objNull,_OrbatPath] spawn OKS_Orbat_SetGroupInactive;