_Array = _this select 0;
_unit = _Array select 1;
_vehicle = _Array select 0;

_Index = 1;

if(["UH1",TypeOf _Vehicle] call BIS_fnc_inString || ["CH47",TypeOf _Vehicle] call BIS_fnc_inString || ["MH47",TypeOf _Vehicle] call BIS_fnc_inString) then
{
	_Index = 0;
};

if (isNull (_vehicle turretUnit [_Index])) exitWith {
	moveout _unit;
	waitUntil {isNull (objectParent _unit)};
	{
		_unit moveInTurret [_vehicle, [_Index]];
		sleep 0.1;
	} foreach [1,2,3,4,5];

};

if (isNull (_vehicle turretUnit [_Index+1])) exitWith {
	moveout _unit;
	waitUntil {isNull (objectParent _unit)};
	{
		_unit moveInTurret [_vehicle,  [_Index+1]];
		sleep 0.1;
	} foreach [1,2,3,4,5];
};

if ( ["CH47",TypeOf _Vehicle] call BIS_fnc_inString || ["MH47",TypeOf _Vehicle] call BIS_fnc_inString) then {
	if (isNull (_vehicle turretUnit [_Index+2])) exitWith {
		moveout _unit;
		waitUntil {isNull (objectParent _unit)};
		{
			_unit moveInTurret [_vehicle,  [_Index+2]];
			sleep 0.1;
		} foreach [1,2,3,4,5];
	};
};

