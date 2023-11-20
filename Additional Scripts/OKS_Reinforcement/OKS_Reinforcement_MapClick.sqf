//	[side,"",["spawn",_pos1,_pos2,"despawn"],bool] execVM "Scripts\NEKY_PickUp\NEKY_MapClick.sqf";
//	
//	A function to run the script on the server
//	
//	Made By NeKo-ArroW

SystemChat "Pilot: Coordinates recieved, reinforcements inbound.";

//	Run main script
[_This, "Scripts\OKS_Reinforcement\OKS_Reinforcement.sqf"] remoteExec ["BIS_fnc_ExecVM", 2];