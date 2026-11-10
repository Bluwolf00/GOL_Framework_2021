_Array = _this select 0;
_unit = _Array select 1;
_vehicle = _Array select 0;


if (isNull (driver _vehicle)) then {
	moveout _unit;
	waitUntil {isNull (objectParent _unit)};
	{
		_unit MoveInDriver _vehicle;
		sleep 0.1;
	} foreach [1,2,3,4,5];

};

