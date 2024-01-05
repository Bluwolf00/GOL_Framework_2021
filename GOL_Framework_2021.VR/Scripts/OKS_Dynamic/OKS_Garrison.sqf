	// OKS_Garrison
	// [5,nearestBuilding player,east,["O_Soldier_F"]] spawn OKS_Garrison;
	if(HasInterface && !isServer) exitWith {};

	Params ["_NumberInfantry","_House","_Side","_UnitArray"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	Private ["_GarrisonPositions","_GarrisonMaxSize","_GarrisonMaxSize","_Unit","_Group"];

	_GarrisonPositions = [_House] call BIS_fnc_buildingPositions;
	_GarrisonMaxSize = count _GarrisonPositions;

	if(_NumberInfantry > _GarrisonMaxSize) then {
		_NumberInfantry = _GarrisonMaxSize;
		_Group = CreateGroup _Side;
		_Group setVariable ["lambs_danger_disableGroupAI", true];
		{
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _X, [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _X, [], 0, "NONE"];
				_Unit setRank "PRIVATE";
			};
			_Unit setRank "PRIVATE";
			_Unit disableAI "PATH";
			_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
			if(OKS_Suppression isEqualTo 1) then {
				[_unit] remoteExec ["OKS_Suppressed",0];
			};				
		} foreach _GarrisonPositions;
	} else {

		_Group = CreateGroup _Side;
		_Group setVariable ["lambs_danger_disableGroupAI", true];
		for "_i" from 1 to _NumberInfantry do
		{
			Private "_Unit";
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
				_Unit setRank "PRIVATE";
			};
			_Unit disableAI "PATH";
			_Unit setUnitPos (selectRandom ["UP","MIDDLE"]);
		};

		{
			_position = (selectRandom _GarrisonPositions);
			_GarrisonPositions deleteAt (_GarrisonPositions find _position);
			_X setPos _position;
			_X setDir (Random 360);
		} foreach units _Group;

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
		_House setVariable ["OKS_isGarrisoned",true];

		[_Group,_House] spawn {
			Params ["_Group","_House"];

			waitUntil {sleep 5; !(isNil "ace_ai_fnc_garrison") && !(isNil "OKS_EnablePath")};
			
			_Group setVariable ["GOL_IsStatic",true,true];
			//[getPos (leader _Group), [typeOf _House], units _Group, 5, 2, false, true] remoteExec  ["ace_ai_fnc_garrison",0];
			sleep 2;

			{[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
			[_Group] remoteExec ["OKS_SetStatic",0];
			[_Group,GOL_Static_Enable_Chance,GOL_Static_Enable_Refresh] spawn OKS_EnablePath;
		}	
	};

	_Group;
