	MISSION_ROOT = call { private "_arr"; _arr = toArray __FILE__; _arr resize (count _arr - 8); toString _arr};
	// Team Map Intel - Added for testing.. do not enable, unless you want potentially massive lag.
	// We have no idea. Yet.
	//execVM "Scripts\GOL_PlayerSetup\TeamMapIntel\init.sqf";

	/* Set GOL Mission Settings */
	_Complete = call Compile PreProcessFileLineNumbers "MissionSettings.sqf";
	waitUntil{_Complete};

	execVM "Scripts\GOL_PlayerSetup\init.sqf";
	execVM "Scripts\OKS_Vehicles\Init.sqf";	
	if(GOL_NEKY_SERVICESTATION isEqualTo 1) then { execVM "Scripts\NEKY_ServiceStation\Init.sqf"};
	if(GOL_NEKY_AIRDROP isEqualTo 1) then {	execVM "Scripts\NEKY_AirDrop\Init.sqf"};
	if(GOL_NEKY_HUNT isEqualTo 1) then { execVM "Scripts\NEKY_Hunt\Init.sqf"};
	if(GOL_OKS_AMBIENCE isEqualTo 1) then { execVM "Scripts\OKS_Ambience\Init.sqf"};
	if(GOL_OKS_SPAWN isEqualTo 1) then { execVM "Scripts\OKS_Spawn\Init.sqf"};
	if(GOL_OKS_DYNAMIC isEqualTo 1) then { execVM "Scripts\OKS_Dynamic\Init.sqf"};
	if(GOL_NEKY_TASK isEqualTo 1) then { execVM "Scripts\NEKY_Tasks\Init.sqf"};	
	if(GOL_OKS_TASK isEqualTo 1) then { execVM "Scripts\OKS_TASK\Init.sqf"};

	// Framework Missing Objects Check.
	OKS_CheckFrameworkObjects = compile preprocessFileLineNumbers "Scripts\GOL_PlayerSetup\OKS_CheckFrameworkObjects.sqf";
	if(isServer && !(isDedicated)) then {
		waitUntil {sleep 1; !isNil "OKS_CheckFrameworkObjects"};
		_Return = call OKS_CheckFrameworkObjects;
		systemChat _Return;

		if(_Return != "This template is not missing any NEW template items.") then {
			copyToClipboard _Return;
		};
	};

	// Run the ORBAT Group - Requires the ORBAT Module to be present on the map.
	if(!isNil "ORBAT_GROUP") then {
		// This value is set in missionSettings.sqf;
		if(!isNil "GOL_Composition") then {
			[GOL_Composition] execVM "Scripts\GOL_PlayerSetup\OKS_DynamicOrbat.sqf";
		} else {
			if(isServer) then {
				systemChat "GOL_Composition variable is undefined. If you want to use the orbat, make sure to assign it in missionSettings.sqf."
			}
		}
	} else {
		if(isServer) then {
			systemChat "The ORBAT Group module is missing.";
		};
	};

