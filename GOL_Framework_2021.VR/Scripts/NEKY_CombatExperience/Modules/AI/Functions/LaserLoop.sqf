//	[IdentifySpeed] Spawn NEKY_AI_LaserLoop;
//	
//	1. IdentifySpeed.
//		a) How quickly AI will gain additional knowledge about the origin of the laser.
//	
//	This handles making AI react to laser pointers.
//	
//	Made by NeKo-ArroW
//	Version 1.0

NEKY_AI_Laser_On = True;

While {NEKY_AI_Laser_On} do
{
	_LaserOn = Player isIRLaserOn (CurrentWeapon Player);
	
	if (_LaserOn) then 
	{
		_This Call NEKY_AI_LaserScan;
		Sleep 1;
	} else {
		Sleep 5;
	};
};