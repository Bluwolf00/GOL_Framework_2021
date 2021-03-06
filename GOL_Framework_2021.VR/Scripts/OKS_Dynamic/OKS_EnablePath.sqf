	// OKS_EnablePath
	// [_Group,0.3,10] spawn OKS_EnablePath;

	Params ["_Group","_Chance","_Sleep"];
	Private ["_Units","_Unit"];
 	Private _Debug_Variable = true;


	while{{Alive _X} count units _Group > 0} do {
		_Units = units _Group select {Alive _X};
		_RandomUnit = selectRandom _Units;
		_closePlayers = (_RandomUnit nearEntities [["Man"], 50]) select {(side _X != (side leader _Group)) && ((side leader _Group) getFriend (side _X) <= 0.6) && isPlayer _X && (side leader _Group) knowsAbout _X > 2.5};

		if(!(_closePlayers isEqualTo [])) then {
			if(_Debug_Variable) then { systemChat format ["Players Near Garrison - %1",_closePlayers]};
			if(Random 1 <= _Chance) then {
				_Unit = selectRandom _Units;
				_Unit enableAI "PATH";
				if(_Debug_Variable) then { systemChat format ["Garrison Unit Detached: %1",_Unit]};
			};
		};
 		sleep _Sleep;
	};

