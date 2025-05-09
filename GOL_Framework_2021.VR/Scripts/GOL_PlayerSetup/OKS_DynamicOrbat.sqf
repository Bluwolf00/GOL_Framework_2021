// [1] execVM "Scripts\GOL_PlayerSetup\OKS_DynamicOrbat.sqf";
/*

		[
			missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon", // Target
			nil, // IdTypenil, // Size
			_PlatoonType, // Type
			nil, // Side
			nil, // Name
			nil, // Short Name
			nil, // Texture
			nil, // TextSizeCoef (Default 1)
			nil, // Insignia
			nil, // textColour
			nil,  // Commander Name
			nil, // Commander Rank "Private" "Corporal" "Sergeant" "Lieutenant"
			nil, // Description
			nil // Assets
		] call BIS_fnc_ORBATSetGroupParams;

*/
// Set Platoon Leader
Params ["_MissionComposition"];
private _Side = (str OKS_FRIENDLY_SIDE);

Private ["_PlatoonType","_SquadType","_BravoType","_1stSquadAlphaName","_2ndSquadAlphaName","_1stSquadBravoName","_2ndSquadBravoName"];
Private [
	"_PlatoonLeader","_PlatoonLeaderString","_PlatoonFAC","_PlatoonFACString","_1SquadLeader","_1SquadLeaderString","_2SquadLeader","_2SquadLeaderString",
	"_1SquadAlphaLeader","_1SquadAlphaLeaderString","_1SquadBravoLeader","_1SquadBravoLeaderString",
	"_2SquadAlphaLeader","_2SquadAlphaLeaderString","_2SquadBravoLeader","_2SquadBravoLeaderString",
	"_Echo1","_Echo1String","_Echo2","_Echo2String","_Echo3","_Echo3String",
	"_Crew1","_Crew1String","_Crew2","_Crew2String"
];
switch (toLower (_Side)) do {
	case "west": { 
		if(!isNil "wpl") then {
			_PlatoonLeader = wpl;
			_PlatoonLeaderString = "wpl";
		};
		if(!isNil "wfac") then {
			_PlatoonFAC = wfac;
			_PlatoonFACString = "wfac";
		};
		if(!isNil "w1a") then {
			_1SquadLeader = w1a;
			_1SquadLeaderString = "w1a";
		};		
		if(!isNil "w2a") then {
			_2SquadLeader = w2a;
			_2SquadLeaderString = "w2a";
		};	
		if(!isNil "w1a1") then {
			_1SquadAlphaLeader = w1a1;
			_1SquadAlphaLeaderString = "w1a1";
		};		
		if(!isNil "w2a1") then {
			_2SquadAlphaLeader = w2a;
			_2SquadAlphaLeaderString = "w2a";
		};	
		if(!isNil "w1b1") then {
			_1SquadBravoLeader = w1b1;
			_1SquadBravoLeaderString = "w1b1";
		};		
		if(!isNil "w2b1") then {
			_2SquadBravoLeader = w2b1;
			_2SquadBravoLeaderString = "w2b1";
		};
		if(!isNil "wecho1") then {
			_Echo1 = wecho1;
			_Echo1String = "wecho1";
		};	
		if(!isNil "wecho2") then {
			_Echo2 = wecho2;
			_Echo2String = "wecho2";
		};	
		if(!isNil "wecho3") then {
			_Echo3 = wecho3;
			_Echo3String = "wecho3";
		};
		if(!isNil "wcrew1") then {
			_Crew1 = wcrew1;
			_Crew1String = "wcrew1";
		};	
		if(!isNil "wcrew4") then {
			_Crew2 = wcrew4;
			_Crew2String = "wcrew4";
		};											
	};
	case "east": {
		if(!isNil "epl") then {
			_PlatoonLeader = epl;
			_PlatoonLeaderString = "epl";
		};
		if(!isNil "efac") then {
			_PlatoonFAC = efac;
			_PlatoonFACString = "efac";
		};
		if(!isNil "e1a") then {
			_1SquadLeader = e1a;
			_1SquadLeaderString = "e1a";
		};		
		if(!isNil "e2a") then {
			_2SquadLeader = e2a;
			_2SquadLeaderString = "e2a";
		};	
		if(!isNil "e1a1") then {
			_1SquadAlphaLeader = e1a1;
			_1SquadAlphaLeaderString = "e1a1";
		};		
		if(!isNil "e2a1") then {
			_2SquadAlphaLeader = e2a;
			_2SquadAlphaLeaderString = "e2a";
		};	
		if(!isNil "e1b1") then {
			_1SquadBravoLeader = e1b1;
			_1SquadBravoLeaderString = "e1b1";
		};		
		if(!isNil "e2b1") then {
			_2SquadBravoLeader = e2b1;
			_2SquadBravoLeaderString = "e2b1";
		};
		if(!isNil "eecho1") then {
			_Echo1 = eecho1;
			_Echo1String = "eecho1";
		};	
		if(!isNil "eecho2") then {
			_Echo2 = eecho2;
			_Echo2String = "eecho2";
		};	
		if(!isNil "eecho3") then {
			_Echo3 = eecho3;
			_Echo3String = "eecho3";
		};
		if(!isNil "ecrew1") then {
			_Crew1 = ecrew1;
			_Crew1String = "ecrew1";
		};	
		if(!isNil "wcrew4") then {
			_Crew2 = ecrew4;
			_Crew2String = "ecrew4";
		};			
	};
	default { 
		SystemChat "Failed to find ORBAT side";
	};
};

switch (_MissionComposition) do {
	case 0: {
		_PlatoonType = "Infantry";
		_SquadType = "Infantry";
		_BravoType = "Infantry";
		_1stSquadAlphaName = "1-1 Alpha";
		_2ndSquadAlphaName = "1-2 Alpha";		
		_1stSquadBravoName = "1-1 Bravo";
		_2ndSquadBravoName = "1-2 Bravo";		
	};
	case 1: {
		_PlatoonType = "MechanizedInfantry";
		_SquadType = "MechanizedInfantry";
		_BravoType = "MechanizedInfantry";
		_1stSquadAlphaName = "1-1 Alpha";
		_2ndSquadAlphaName = "1-2 Bravo";
		_1stSquadBravoName = "1-1 Foxtrot";
		_2ndSquadBravoName = "1-2 Golf";

		// Change Bravo to look at crew in case of mechanized.
		_1SquadBravoLeader = _Crew1;
		_1SquadBravoLeaderString = _Crew1String;		
		_2SquadBravoLeader = _Crew2;
		_2SquadBravoLeaderString = _Crew2String;
	};
	default {
	
	};
};

if(isNil "_PlatoonType") exitWith {
	systemChat "No Composition selected. Exiting";
};

/// Change Commander name if applicable
if(!isNil _PlatoonLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon",
		nil, nil, _PlatoonType, _Side, nil, nil, nil, nil, nil, nil, (name _PlatoonLeader), (rank _PlatoonLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _1SquadLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad",
		nil, nil, _SquadType, _Side, nil, nil, nil, nil, nil, nil, (name _1SquadLeader), (rank _1SquadLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _2SquadLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad",
		nil, nil, _SquadType, _Side, nil, nil, nil, nil, nil, nil, (name _2SquadLeader), (rank _2SquadLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

// Alpha Teams
if(!isNil _1SquadAlphaLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad" >> "AlphaTeam",
		nil, nil, nil, _Side, _1stSquadAlphaName, _1stSquadAlphaName, nil, nil, nil, nil, (name _1SquadAlphaLeader), (rank _1SquadAlphaLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad" >> "AlphaTeam", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _2SquadAlphaLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "AlphaTeam",
		nil, nil, nil, _Side, _2ndSquadAlphaName, _2ndSquadAlphaName, nil, nil, nil, nil, (name _2SquadAlphaLeader), (rank _2SquadAlphaLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "AlphaTeam", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

// Bravo Teams
if(!isNil _1SquadBravoLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad" >> "BravoTeam",
		nil, nil, _BravoType, _Side, _1stSquadBravoName, _1stSquadBravoName, nil, nil, nil, nil, name _1SquadBravoLeader, name _1SquadBravoLeader, nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "1stSquad" >> "BravoTeam", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _2SquadBravoLeaderString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "BravoTeam",
		nil, nil, _BravoType, _Side, _2ndSquadBravoName, _2ndSquadBravoName, nil, nil, nil, nil, (name _2SquadBravoLeader), (rank _2SquadBravoLeader), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "2ndSquad" >> "BravoTeam", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

// Hammer
if(!isNil _PlatoonFACString) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer",
		nil, nil, nil, _Side, nil, nil, nil, nil, nil, nil, (name _PlatoonFAC), (rank _PlatoonFAC), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

/// AAC Callsigns
if(!isNil _Echo1String) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1",
		nil, nil, nil, _Side, nil, nil, nil, nil, nil, nil, (name _Echo1), (rank _Echo1), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo1", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _Echo2String) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2",
		nil, nil, nil, _Side, nil, nil, nil, nil, nil, nil, (name _Echo2), (rank _Echo2), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo2", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};

if(!isNil _Echo3String) then {
	[
		missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3",
		nil, nil, nil, _Side, nil, nil, nil, nil, nil, nil, (name _Echo3), (rank _Echo3), nil, nil
	] call BIS_fnc_ORBATSetGroupParams;
} else {
	[missionconfigfile >> "CfgORBAT" >> "GuerrillasOfLiberation" >> "1stPlatoon" >> "Hammer" >> "echo3", "mil_destroy", [1,0,0,1], 1.2,1.2,45] call BIS_fnc_ORBATAddGroupOverlay;
};
