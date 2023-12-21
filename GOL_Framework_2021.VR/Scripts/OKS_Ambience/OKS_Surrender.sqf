/*
    Examples:
    _null = [this,0.5,50,true,false] spawn OKS_Surrender;
    _null = [this,0.5,50,true,true] execVM "Scripts\OKS_Ambience\OKS_Surrender.sqf";
*/
params [
    ["_Unit",objNull,[objNull]],            // #0 OBJECT - Person who is going to surrender
    ["_Chance",0.5,[1]],                    // #1 Chance - Numerical chance 0 being 100%, 0.5 = 50% and 1 = 0%   
    ["_Distance",30,[1]],                   // #2 Distance - Numerial distance where player must be within to activate the codes (Prefer low around 20 meters)
    ["_SurrenderByShot",true,[true]],       // #3 SurrenderByShot - True/False should allow player to shoot to make unit surrender with higher chance.
    ["_SurrenderByFlashbang",true,[true]]   // #4 SurrenderByFlash - True/False should allow player to throw flashbang to force unit surrender.
];
private _Debug_Variable = false;
private ["_NearPlayers"];
(group _unit) setVariable ["acex_headless_blacklist",true];
[_Unit,"PATH"] remoteExec ["disableAI",0];
_Unit setUnitPos "UP";
_Unit setVariable ["GOL_isStatic",true,true];

GOL_ThrowWeaponsOnGround = {
    _Debug = 0;
    Params["_Unit"];
    _Dir = getDir _Unit;
    _Pos = _Unit getPos [0.5,_Dir];
    _Alt = getPosATL _Unit select 2;
    _Holder = createVehicle ["groundWeaponHolder",[0,0,0], [], 0, "NONE"];
    _Holder setPosATL [_Pos select 0,_Pos select 1,_Alt];

    if(primaryWeapon _Unit != "") then {
        _Holder addWeaponCargo [primaryWeapon _Unit,1];
    };
    if(handgunWeapon _Unit != "") then {  
        _Holder addWeaponCargo [handgunWeapon _Unit,1];
    };
    removeAllWeapons _Unit;
    if(_Debug == 1) then {SystemChat "Surrender: Tossed Weapon"};

};

GOL_CheckThreatened = {
    _Debug = 0;
    private ["_Actor","_target","_pos0","_pos1"];
    Params["_Actor","_Target","_Tolerance","_Chance","_SurrenderByFlashbang"];

    if ( isNull _actor ) exitWith {false};
    if ( isNull _target ) exitWith {false};
    if(_Debug == 1) then {SystemChat "Threat: Initial Checks complete.."};
    _pos0 = getPosASL _actor;
    _pos1 = getPosASL _target;
    _Dice = Random 1;
    if(_SurrenderByFlashbang) then {
        if(_Debug == 1) then {SystemChat "Looking for Flashbang.."};
        _Flashbangs = _Unit nearObjects ["ACE_G_M84",5];
        if(count _Flashbangs > 0) then {
            sleep 1.5;
            _target removeAllEventHandlers "Hit";
            if(_Debug == 1) then {SystemChat "Flashbang detected. Surrendering."};
            [_target,true] call ACE_captives_fnc_setSurrendered;
            [_target] spawn GOL_ThrowWeaponsOnGround;
            _Unit setVariable ["OKS_SurrenderCheck",false,true];
        };
    };
    if(_Debug == 1) then {systemChat ("CheckThreat: " +str [_Dice,_Chance])};
    if(( ( ( _pos0 vectorAdd ( (_actor weaponDirection (currentWeapon _actor)) vectorMultiply (_pos0 distance _pos1) ) ) distanceSqr _pos1 ) < ((_this select 2)^2) ) && _Dice < _Chance && _Unit getVariable ["OKS_SurrenderCheck",true]) then {
        if ( weaponLowered _actor ) exitWith { if(_Debug == 1) then {SystemChat "Player has lowered weapon.."}};
        if ( _target knowsAbout _actor < 3 ) exitWith { if(_Debug == 1) then {SystemChat "Player unbeknownst to Enemy"}};
        if(_Debug == 1) then {SystemChat "WeaponThreat successful. Surrendering."};
        _target removeAllEventHandlers "Hit";
        [_target,true] call ACE_captives_fnc_setSurrendered;
        [_target] spawn GOL_ThrowWeaponsOnGround; 
    } else {
        if(( ( ( _pos0 vectorAdd ( (_actor weaponDirection (currentWeapon _actor)) vectorMultiply (_pos0 distance _pos1) ) ) distanceSqr _pos1 ) < ((_this select 2)^2) ) && _Unit getVariable ["OKS_SurrenderCheck",true]) then {
            if(_Debug == 1) then {SystemChat "Ending WeaponThreat. Only hit/flash to surrender possible now."};
            _Unit setVariable ["OKS_SurrenderCheck",false,true];
        }
    };
};

if(_Debug_Variable) then {SystemChat "Surrender Init Completed - Waiting for Nearby Player"};
waitUntil {
    sleep 5;
    _NearPlayers = (_Unit nearEntities [["Man"], _Distance]) select {isPlayer _X};
    count _NearPlayers > 0
};

if(_Debug_Variable) then {SystemChat "Surrender - Nearby Player Found"};
_Unit setVariable ["OKS_ChanceSurrender",_Chance,true];
if(_SurrenderByShot) then {
    //SystemChat "EventHandler Hit given to HVT.";
    _Unit addEventHandler ["Hit", {
        params ["_unit", "_source", "_damage", "_instigator"];
        if(isPlayer _instigator && _instigator distance _unit < 25) then {
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

if(_Debug_Variable) then {SystemChat "Surrender - While Loop Init..."};

While {(count (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X}) > 0) && Alive _Unit && !captive _Unit} do {
    { [_X,_Unit, 1, _Chance,_SurrenderByFlashbang] call GOL_CheckThreatened; } foreach (_Unit nearEntities [["Man"], _Distance] select {isPlayer _X && Alive _X});
    sleep 0.05;
};