// _null = [this,0.3,25] spawn OKS_Surrender;
// _null = [this,0.3,25] execVM "Scripts\OKS_Ambience\OKS_Surrender.sqf";
// [Unit,ChanceOfSurrender,DistanceNearUnit] spawn OKS_Surrender;

params ["_Unit","_Chance","_Distance"];
private _Debug_Variable = false;
private ["_NearPlayers"];

/*
Author: Tajin

Description:
Determines if _actor is pointing his weapon close to the _target (within _tolerance in meters).
Main use of this command was not to determine if _actor would hit _target but rather to determine if _target feels like _actor is aiming at him.

Parameter(s):
#0 OBJECT - _actor (the guy with the weapon)
#1 OBJECT - _target (the person supposedly aimed at)
#2 NUMBER - _tolerance in meters
(distance is calculated to the actual line of fire, not the point _actor aims at. That means it will still trigger, even if you closely aim past the _target.)

Returns:
BOOL - TRUE when within _tolerance
*/
GOL_CheckThreatened = {
    private ["_Actor","_target","_pos0","_pos1"];
    Params["_Actor","_Target","_Tolerance","_Chance"];

    if ( isNull _actor ) exitWith {false};
    if ( isNull _target ) exitWith {false};
    if ( weaponLowered _actor ) exitWith {false};
    if ( _target knowsAbout _actor < 3 ) exitWith {false};

    _pos0 = getPosASL _actor;
    _pos1 = getPosASL _target;
    _Dice = Random 1;

    if(( ( ( _pos0 vectorAdd ( (_actor weaponDirection (currentWeapon _actor)) vectorMultiply (_pos0 distance _pos1) ) ) distanceSqr _pos1 ) < ((_this select 2)^2) ) && _Dice < _Chance) exitWith { _target removeAllEventHandlers "Hit"; [_target,true] call ACE_captives_fnc_setSurrendered; }
};

waitUntil {
    sleep 5;
    _NearPlayers = (_Unit nearEntities [["Man"], _Distance]);
    //_NearPlayers = _NearPlayers select {isPlayer _X && Alive _X && behaviour _Unit == "COMBAT"};
    count _NearPlayers > 0
};

_Unit setVariable ["OKS_ChanceSurrender",_Chance,true];
_Unit addEventHandler ["Hit", {
	params ["_unit", "_source", "_damage", "_instigator"];
    if(isPlayer _instigator && _instigator distance _unit < 25) then {
        _Dice = Random 1;
        _Chance = _unit getVariable ["OKS_ChanceSurrender",0];
        _Chance = _Chance / 3;
        if(_Dice > _Chance) then {
            [_unit,true] call ACE_captives_fnc_setSurrendered;
        };
        _unit removeAllEventHandlers "Hit";
    };
}];

While {count (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X}) > 0} do {
    { [_X,_Unit, 3, 15] call GOL_CheckThreatened } foreach (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X});
    sleep 0.5;
};

/*
_Dice = Random 1;
systemChat format ["%1 - Distance %3 - %4 > %2",_Unit,_Chance,_Distance,_Dice];
if(_Dice < _Chance) then {
    [_Unit,true] call ACE_captives_fnc_setSurrendered;
};
