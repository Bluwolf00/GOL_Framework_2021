//	[] Call NEKY_AI_Run;
//	
//	This runs all the effects of the AI module based on the Settings.sqf.
//	
//	Made by NeKo-ArroW
//	Version 1.02

#include "Settings.sqf";

if (!HasInterface or isServer) then // Server and HC functions
{
	// AI Surrender
	if (_Surrender) then
	{
		[_Distances,_FriendliesNear,_Chance] Call NEKY_AI_Surrender;
	};	
	
	if (_ShareInfo) then 
	{
		[True,nil,True] call NEKY_AI_Shareinfo;
	};
};

if (HasInterface) then // Player functions
{ 
	// Laser
	if (_Laser) then 
	{
		[_IdentifySpeed] Spawn NEKY_AI_LaserLoop;
	};
};