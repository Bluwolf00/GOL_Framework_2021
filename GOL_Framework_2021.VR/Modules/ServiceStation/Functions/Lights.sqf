//	
//	
//	This creates the flashing light effect while service station is in use.
//	
//	Made by NeKo-ArroW

#include "..\Settings.sqf"

Params ["_SS"];

While {_SS In NEKY_ServiceStationActive && _Lights} do
{
	_Index = 0;
	_45 = 45;
	_10 = 10;
	_Pos = GetPos _SS;
	_Spheres = [];
	for "_y" from 1 to 4 do
	{
		for "_i" from 1 to 4 do
		{
			_Light = CreateVehicle ["Sign_Sphere100cm_F", ([_Pos, _10, ((Direction _SS) + ((0) + _45))] call BIS_FNC_RelPos), [], 0, "CAN_COLLIDE"];
			_Light setVectorUp surfaceNormal position _Light;
			_Spheres pushBack _Light;
			_Index = _Index +1;
			_45 = _45 + 90;
		};
		_10 = _10 - 2;
		sleep 0.5;
	};
	if !(_SS In NEKY_ServiceStationActive) exitWith { {deleteVehicle _x} forEach _Spheres };
	_Index = 0;
	for "_i" from 1 to ((count _Spheres) / 4) do
	{
		for "_y" from 1 to 4 do
		{
			deleteVehicle (_Spheres select _Index);
			_Index = _Index +1;
		};			
		sleep 0.5;
	};
};