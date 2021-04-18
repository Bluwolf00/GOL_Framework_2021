MISSION_ROOT = call {
    private "_arr";
    _arr = toArray __FILE__;
    _arr resize (count _arr - 8);
    toString _arr
};
[] execVM "Scripts\HeadlessClient\HeadlessClient.sqf";
[] execVM "Scripts\NEKY_ServiceStation\Init.sqf";
execVM "Scripts\NEKY_Supply\Ace_Resupply.sqf";
execVM "Scripts\NEKY_Supply\Ace_Med.sqf";
// Do not remove these scripts ^
// Adds backup supply lines if AAC is not playing (Luke's Script)
// Sets up working Service Station




	//Comment if you want to disable Neky_HuntBase / AirBase
	[] execVM "Scripts\NEKY_AirDrop\Init.sqf";
	[] execVM "Scripts\NEKY_Hunt\Init.sqf";
	// Set Max Count of Enemies spawned by bases
	NEKY_Hunt_MaxCount = 40;
	NEKY_Hunt_CurrentCount = [];
	publicVariable "NEKY_Hunt_MaxCount";
	publicVariable "NEKY_Hunt_CurrentCount";

	/// Use this if you want AAC to be able to switch seats in their helicopters and get better doorgunners - Comment if you want to disable this
	[] execVM "Scripts\OKS_AAC\Init.sqf";

	// Use this if you want the automatic hunt code, this takes all moving units and makes them attack the player if they are within range
	// Uncomment both lines and adjust the parameters below (Side,MinRange,MaxRange,RefreshRate)
	//[] execVM "Scripts\OKS_HUNT\Init.sqf";
	//[EAST,500,1000,90] spawn OKS_Dynamic_Hunt;

	// Use this if you want to use in-game intel tasks, you assign the details in the script below, find it at "Scripts\OKS_TASK\Init.sqf"
	// Below is an example, parameters: [originObject,numberID,Position,Side,ParentTask]
	//[] execVM "Scripts\OKS_TASK\Init.sqf";
	//[Task_Object_1,1,GetMarkerPos "Task_1",west,O_Task] spawn OKS_TASKSETUP;

	// Use this if you want to use OKS Ambience scripts, this initiates them, look into the specific functions to learn more on how to use.
	//[] execVM "Scripts\OKS_Ambience\Init.sqf";

		sleep 10;

		// Below are examples of how to use the hunt/airdrop bases
		// These codes should be put in SpawnList unless you want them to start "searching" from the start of the mission.
		// [Base_1, Spawn_1, NEKY_Hunt_Trigger_1, 5,30,independent,6,30] spawn NEKY_Hunt_HuntBase;
		// [Base_2, Spawn_2, NEKY_Hunt_Trigger_1, 5,30,independent,"CUP_I_LR_MG_AAF",30] spawn NEKY_Hunt_HuntBase;
		// [Base_3,Spawn_3, NEKY_Hunt_Trigger_1,independent,"I_Heli_Transport_02_F","Random",[2,1]] spawn NEKY_Airbase;
