	// OKS_Garrison_Compound
	if(HasInterface && !isServer) exitWith {};

	Params ["_NumberInfantry","_Position","_Side","_Units","_Range"];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_GarrisonMaxSize","_Unit"];
		Private _Debug_Variable = false;

		_Group = CreateGroup _Side;
		for "_i" from 1 to _NumberInfantry do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position getPos [(random 8),(random 360)], [], 0, "NONE"];
				_Unit setRank "PRIVATE";
			};
			_Unit disableAI "PATH";
			_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
			sleep 0.5;
		};
		 /* Arguments:
			 * 0: The building(s) nearest this position are used <POSITION>
			 * 1: Limit the building search to those type of building <ARRAY>
			 * 2: Units that will be garrisoned <ARRAY>
			 * 3: Radius to fill building(s) <SCALAR> (default: 50)
			 * 4: 0: even filling, 1: building by building, 2: random filling <SCALAR> (default: 0)
			 * 5: True to fill building(s) from top to bottom <BOOL> (default: false) (note: only works with filling mode 0 and 1)
			 * 6: Teleport units <BOOL> (default: false)
		 */
		//private _type = typeOf nearestBuilding (getPos (leader _group));
		if(_Debug_Variable) then {
			SystemChat format ["Compound at %1 Units: %2 Range: %3",_Position,count units _Group,_Range];
		};

		[_Position, nil, units _Group, _Range, 0, false, true] remoteExec  ["ace_ai_fnc_garrison",0];
		[_Group,0.3,15] spawn OKS_EnablePath;
