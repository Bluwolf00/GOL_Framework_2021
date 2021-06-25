//
//  [_Position,_Side,_InfantryNumber,_Range] spawn OKS_Populate_Sandbag;
//  [_Position,_Side,_InfantryNumber,_Range] execVM "Scripts\OKS_Dynamic\OKS_Populate_Sandbag.sqf"
//  Return: Group

if(HasInterface && !isServer) exitWith {};

	Params["_Position","_Side","_InfantryNumber","_Range"];
	_Settings = [_Side] call OKS_Dynamic_Setting;
	_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];

	Private ["_TempSandbags"];
	Private _Debug_Variable = false;

	_AllObjects = _Position nearObjects _Range;
	//if(_Debug_Variable) then { SystemChat str _AllObjects};

	_Sandbags = _AllObjects select {["sandbag",typeOf _X] call BIS_fnc_inString || ["BagFence",typeOf _X] call BIS_fnc_inString || ["CncBarrier",typeOf _X] call BIS_fnc_inString};
	if(_Debug_Variable) then { SystemChat str _Sandbags};

	if(count _Sandbags > 0) then {
		if(_InfantryNumber > count _Sandbags) then {
			_InfantryNumber = count _Sandbags;
		};
		if(count _Sandbags > _InfantryNumber) then {
			_TempSandbags = [];
			for "_i" to (_InfantryNumber - 1) do {
				_TempSandbags pushBackUnique (selectRandom _Sandbags);
			};
			_Sandbags = _TempSandbags;
		};

		Private "_Group";
		_Group = CreateGroup _Side;
		{
			Private "_Unit";
			_SpawnPos = _X getPos [1.5,(_X getDir _Position)];
			if ( (count (units _Group)) == 0 ) then
			{
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,(getPosATL _X select 2 + 0.1)], [], -1, "CAN_COLLIDE"];
				_Unit setRank "SERGEANT";
			} else {
				_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [_SpawnPos select 0,_SpawnPos select 1,(getPosATL _X select 2 + 0.1)], [], -1, "CAN_COLLIDE"];
				_Unit setRank "PRIVATE";
			};
			_Unit disableAI "PATH";
			_Unit setUnitPosWeak "UP";
			_Unit setDir ((_Unit getDir _Position) - 180);
			_Unit doWatch (_Unit getPos [50,((_Unit getDir _Position) - 180)]);
			if(count units _Group >= _InfantryNumber) exitWith { if(_Debug_Variable) then { SystemChat "_Group reached Max. Exiting.."}}
		} foreach _Sandbags;
		_Group;
	};
	false;
