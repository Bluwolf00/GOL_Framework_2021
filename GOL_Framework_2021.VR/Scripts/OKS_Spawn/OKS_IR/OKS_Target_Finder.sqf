Params ["_Unit","_MinimumAltitude","_MinimumRange","_MaximumRange"];
	Private ["_PreviousTarget"];
	_PreviousTarget = [];
	while {alive _Unit} do {
		_NearbyTargets = AllPlayers select {
			vehicle _X isKindOf "AIR" &&
			getPos _X select 2 >= _MinimumAltitude &&
			(_X distance _Unit <= _MaximumRange) &&
			(_X distance _Unit >= _MinimumRange)
		};		
		if(count _NearbyTargets > 0 && !(_Unit getVariable ["AA_isReloading",false])) then {
			_Unit setCombatMode "RED";
			{
				_Unit reveal [Vehicle _X,4];
				_Unit doTarget Vehicle _X;
				_Unit doFire Vehicle _X;
			} forEach _NearbyTargets;
			_PreviousTarget = _NearbyTargets;
			systemChat "Found Target - Combat Red - Revealed";
		} else {

			if(!(_Unit getVariable ["AA_isReloading",false])) then {
				_Unit setCombatMode "BLUE";
				systemChat "No Target - Combat Blue - Forgot";

				if(_PreviousTarget isNotEqualTo []) then {
					{
						_Unit forgetTarget _X
					} foreach _PreviousTarget;
				};
			}
		};

		if(_PreviousTarget isEqualTo []) then {
			_PreviousTarget = _NearbyTargets;
		};
		/*
		 	Activate in dev release branch Arma 3 2.18
			_NearbyTargets = AllPlayers select {vehicle _X isKindOf "AIR" && _X distance _Unit < 3000};
			SystemChat str _NearbyTargets;
			{
				systemChat str [getPos _X select 2,_X distance _Unit];
				if(getPos _X select 2 >= _MinimumAltitude && _X distance _Unit >= _MinimumRange) then {

					// Activate in dev release branch Arma 3 2.18
					// (group _Unit) ignoreTarget [_X, false];


					SystemChat format["%1 set to target for AA (%2).",_X,_Unit];
				} else {
					// Activate in dev release branch Arma 3 2.18
					//(group _Unit) ignoreTarget [_X, true];
				};
			} foreach _NearbyTargets;
		*/

		sleep 5;		
	};