	MISSION_ROOT = call { private "_arr"; _arr = toArray __FILE__; _arr resize (count _arr - 8); toString _arr};

	/* Set GOL Mission Settings */
	OKS_MissionSettings = Compile PreProcessFileLineNumbers "MissionSettings.sqf";
	if(isServer) then {
		[] remoteExec ["OKS_MissionSettings",0]
	};
	Sleep 5;

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
