
	_Array = _this select 0;
	_unit = _Array select 1;
	_vehicle = _Array select 0;
	_Index = 0;

	if(["UH1",TypeOf _Vehicle] call BIS_fnc_inString) then
	{
		_Index = 2;
	};

	if(["CH47",TypeOf _Vehicle] call BIS_fnc_inString) then
	{
		_Index = 3;
	};

	systemChat format ["%1",_Index];
	if (isNull (_vehicle turretUnit [_Index])) then {

		moveout _unit;
		waitUntil {isNull (objectParent _unit)};

		{
			_unit moveInTurret [_vehicle, [_Index]];
			sleep 0.1;
		} foreach [1,2,3,4,5];
	};
