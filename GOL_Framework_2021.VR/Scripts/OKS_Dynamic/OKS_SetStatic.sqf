	// OKS_SetStatic
	// [_Group] spawn OKS_SetStatic;

	Params ["_Group"];

	_Units = units _Group;
	{_X disableAI "PATH"; _X setUnitPos "UP"} foreach _Units;
