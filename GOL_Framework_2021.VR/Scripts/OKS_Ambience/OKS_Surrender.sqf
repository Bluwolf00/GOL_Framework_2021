// _null = [this,0.3,25] spawn OKS_Surrender;
// _null = [this,0.3,25] execVM "Scripts\OKS_Ambience\OKS_Surrender.sqf";
// [Unit,ChanceOfSurrender,DistanceNearUnit] spawn OKS_Surrender;
/*

    Parameters:
    #0 OBJECT - Person who is going to surrender
    #1 Chance - Numerical chance 0 being 100%, 0.5 = 50% and 1 = 0%
    #3 Distance - Numerial distance where player must be within to activate the codes (Prefer low around 20 meters)
    #4 SurrenderByShot - True/False should allow player to shoot to make unit surrender with higher chance.
    #5 SurrenderByFlash - True/False should allow player to throw flashbang to force unit surrender.
 */

params ["_Unit","_Chance","_Distance","_SurrenderByShot","_SurrenderByFlashbang"];
private _Debug_Variable = false;
private ["_NearPlayers"];
(group _unit) setVariable ["acex_headless_blacklist",true];
[_Unit,"PATH"] remoteExec ["disableAI",0];
_Unit setUnitPos "UP";

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

GOL_ThrowWeaponsOnGround = {
    Params["_Unit"];
    _Dir = getDir _Unit;
    _Pos = _Unit getPos [0.5,_Dir];
    _Alt = getPosATL _Unit select 2;
    _Holder = createVehicle ["groundWeaponHolder",[0,0,0], [], 0, "NONE"];
    _Holder setPosATL [_Pos select 0,_Pos select 1,_Alt];
    _Holder addWeaponCargo [primaryWeapon _Unit,1];
    _Holder addWeaponCargo [handgunWeapon _Unit,1];
    removeAllWeapons _Unit;
};

GOL_CheckThreatened = {
    _Debug = 1;
    private ["_Actor","_target","_pos0","_pos1"];
    Params["_Actor","_Target","_Tolerance","_Chance","_SurrenderByFlashbang"];

    if ( isNull _actor ) exitWith {false};
    if ( isNull _target ) exitWith {false};
    if ( weaponLowered _actor ) exitWith {false};
    if ( _target knowsAbout _actor < 3 ) exitWith {false};

    _pos0 = getPosASL _actor;
    _pos1 = getPosASL _target;
    _Dice = Random 1;
    if(_SurrenderByFlashbang) then {
        _Flashbangs = _Unit nearObjects ["ACE_G_M84",5];
        if(count _Flashbangs > 0) then {
            sleep 1.5;
            _target removeAllEventHandlers "Hit";
            SystemChat "Flashbang detected. Surrendering.";
            [_target,true] call ACE_captives_fnc_setSurrendered;
            [_target] spawn GOL_ThrowWeaponsOnGround;
            _Unit setVariable ["OKS_SurrenderCheck",false,true];
        };
    };
    systemChat ("CheckThreat: " +str [_Dice,_Chance]);
    if(( ( ( _pos0 vectorAdd ( (_actor weaponDirection (currentWeapon _actor)) vectorMultiply (_pos0 distance _pos1) ) ) distanceSqr _pos1 ) < ((_this select 2)^2) ) && _Dice < _Chance) then { 
        SystemChat "WeaponThreat successful. Surrendering.";
        _target removeAllEventHandlers "Hit";
        [_target,true] call ACE_captives_fnc_setSurrendered;
        [_target] spawn GOL_ThrowWeaponsOnGround; 
    } else {
        if(( ( ( _pos0 vectorAdd ( (_actor weaponDirection (currentWeapon _actor)) vectorMultiply (_pos0 distance _pos1) ) ) distanceSqr _pos1 ) < ((_this select 2)^2) )) then {
            SystemChat "Ending WeaponThreat. Only hit to surrender possible now.";
            _Unit setVariable ["OKS_SurrenderCheck",false,true];
        }
    };
};

waitUntil {
    sleep 5;
    _NearPlayers = (_Unit nearEntities [["Man"], _Distance]);
    //_NearPlayers = _NearPlayers select {isPlayer _X && Alive _X && behaviour _Unit == "COMBAT"};
    count _NearPlayers > 0
};

_Unit setVariable ["OKS_ChanceSurrender",_Chance,true];

if(_SurrenderByShot) then {
    _Unit addEventHandler ["Hit", {
        params ["_unit", "_source", "_damage", "_instigator"];
        if(isPlayer _instigator && _instigator distance _unit < 25 && _unit knowsAbout _instigator > 3) then {
            _Dice = Random 1;
            _Chance = _unit getVariable ["OKS_ChanceSurrender",0];
            _Chance = _Chance * 2;
            systemChat ("HitChance: " +str [_Dice,_Chance]);
            if(_Dice < _Chance) then {
                [_unit,true] call ACE_captives_fnc_setSurrendered;
                [_unit] spawn GOL_ThrowWeaponsOnGround;
            };
            _unit removeAllEventHandlers "Hit";
        };
    }];
};

While {count (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X}) > 0 && Alive _Unit && !captive _Unit && _Unit getVariable ["OKS_SurrenderCheck",true]} do {
    { [_X,_Unit, 2, _Chance,_SurrenderByFlashbang] call GOL_CheckThreatened } foreach (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X});
    if(_Unit getVariable ["ace_medical_pain",0] >= 0.02) then {            
        _Dice = Random 1;
        _Chance = _unit getVariable ["OKS_ChanceSurrender",0];
        _Chance = _Chance * 2;
        systemChat ("HitChance: " +str [_Dice,_Chance]);
        if(_Dice < _Chance) then {
            [_unit,true] call ACE_captives_fnc_setSurrendered;
            [_unit] spawn GOL_ThrowWeaponsOnGround;
        };
    };
    sleep 0.1;
};

/*
_Dice = Random 1;
systemChat format ["%1 - Distance %3 - %4 > %2",_Unit,_Chance,_Distance,_Dice];
if(_Dice < _Chance) then {
    [_Unit,true] call ACE_captives_fnc_setSurrendered;
};
