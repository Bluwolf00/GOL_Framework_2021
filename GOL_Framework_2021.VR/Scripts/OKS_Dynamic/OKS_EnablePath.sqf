	// OKS_EnablePath
	// [_Group,0.3,10] spawn OKS_EnablePath;

	Params ["_Group","_Chance","_Sleep"];
	Private ["_Units","_Unit"];
 	Private _Debug_Variable = false;

	if(_Debug_Variable) then {
		systemChat format["%1 ran code for OKS_EnablePath, Chance: %2, Time: %3",_Group,_Chance,_Sleep];
	};
	
	while{{Alive _X} count units _Group > 0} do {
		_Units = units _Group select {Alive _X};
		_RandomUnit = selectRandom _Units;
		_closePlayers = (_RandomUnit nearEntities [["Man"], 15]) select {(side _X != (side leader _Group)) && ((side leader _Group) getFriend (side _X) <= 0.6) && isPlayer _X && (side leader _Group) knowsAbout _X > 2.5};

		if(!(_closePlayers isEqualTo [])) then {
			if(_Debug_Variable) then { systemChat format ["Players Near Garrison - %1",_closePlayers]};
			if(Random 1 <= _Chance) then {
				_Unit = selectRandom _Units;

				If(isNull (ObjectParent _Unit)) then {

					_newGroup = createGroup (side _Unit);
					_Unit joinAs [_newGroup,0];
					[_Unit,selectRandom ["moveUp_1","moveUp_2","advance","OnTheWay_1"],_Debug_Variable] remoteExec ["JBOY_Speak",0]; 

					[_Unit, "PATH"] remoteExec ["enableAI",0];

					waitUntil {sleep 1; !isNil "lambs_wp_fnc_taskRush"};	
					[_newGroup,200,15,[],getPos _Unit,true] remoteExec ["lambs_wp_fnc_taskRush",0];

					if(_Debug_Variable) then { systemChat format ["Garrison Unit Detached: %1",_Unit]};
				} else {
					if(_Debug_Variable) then { systemChat format ["Ignored (Unit in Vehicle): %1",_Unit]};
				};
			};
		};
 		sleep _Sleep;
	};

