
/*
	[thisTrigger] execVM "Scripts\OKS_Ambience\OKS_Reveal.sqf";
*/

	Params["_Trigger"];
	_Players = AllPlayers;
	{
		_Player = _X;
		if(!isNull ObjectParent _Player) then {
			{_X reveal [ObjectParent _Player,4]} foreach (list _Trigger);	
		};	
		{_X reveal [_Player,4]} foreach (list _Trigger);
	} foreach AllPlayers;
	
