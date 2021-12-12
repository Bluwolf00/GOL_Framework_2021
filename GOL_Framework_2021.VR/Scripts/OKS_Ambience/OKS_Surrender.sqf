// _null = [this,0.3,25] spawn OKS_Surrender;
// _null = [this,0.3,25] execVM "Scripts\OKS_Ambience\OKS_Surrender.sqf";
// [Unit,ChanceOfSurrender,DistanceNearUnit] spawn OKS_Surrender;

params ["_Unit","_Chance","_Distance"];
private _Debug_Variable = false;
private ["_NearPlayers"];

waitUntil {
    sleep 5;
    _NearPlayers = (_Unit nearEntities [["Man","LandVehicle"], _Distance]);
    _NearPlayers = _NearPlayers select {isPlayer _X && Alive _X && behaviour _Unit == "COMBAT"};
    count _NearPlayers > 0
};
_Dice = Random 1;
systemChat format ["%1 - Distance %3 - %4 > %2",_Unit,_Chance,_Distance,_Dice];
if(_Dice < _Chance) then {
    [_Unit,true] call ACE_captives_fnc_setSurrendered;
};
