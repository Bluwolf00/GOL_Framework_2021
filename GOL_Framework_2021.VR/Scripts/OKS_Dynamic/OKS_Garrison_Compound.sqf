	// OKS_Garrison_Compound
	// [5,getPos player,east,["O_Soldier_F"],30] spawn OKS_Garrison_Compound;
	if(HasInterface && !isServer) exitWith {};

	Params ["_NumberInfantry","_Position","_Side","_UnitArray","_Range"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_GarrisonMaxSize","_Unit"];
		Private _Debug_Variable = false;

		_Group = CreateGroup _Side;
		_Group setVariable ["lambs_danger_disableGroupAI", true];
		
		for "_i" from 1 to _NumberInfantry do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _Position, [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _Position getPos [(random 8),(random 360)], [], 0, "NONE"];
				_Unit setRank "PRIVATE";

			};
			if(_Debug_Variable) then {SystemChat format ["%1 Pos %2",group _unit,getPos _Unit]};
			_Unit disableAI "PATH";

			if(_Side isNotEqualTo civilian) then {
				_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
			};

			sleep 0.2;
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
		_Houses = _Position nearObjects ["House",_Range];
		{_X setVariable ["OKS_isGarrisoned",true]} foreach _Houses;
		if(_Debug_Variable) then {
			SystemChat format ["Compound at %1 Units: %2 Range: %3",_Position,count units _Group,_Range];
			//SystemChat format ["Houses to setVariable: %1",_Houses];
		};

		waitUntil {sleep 5; !(isNil "ace_ai_fnc_garrison") && !(isNil "OKS_EnablePath")};
		[_Position, nil, units _Group, (_Range - 10), 0, false, true] remoteExec  ["ace_ai_fnc_garrison",0];
		sleep 2;
		[_Group] remoteExec ["OKS_SetStatic",0];
		{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
		if(_Side isNotEqualTo civilian) then {
			[_Group,0.3,15] spawn OKS_EnablePath;
		};
