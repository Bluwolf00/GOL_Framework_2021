// _null = [this,west,3,1500,true] execVM "Scripts\OKS_SAM\GW_AAA.sqf";
// Parameters
// [ObjectName,Side,Type,Range,Ambient Fire? (TRUE/FALSE)]
params ["_arty","_side","_weaponType","_range","_ambient"];

if ((count(fullCrew [_arty, "gunner", true]) isEqualTo 0)) exitWith {systemChat "Vehicle does not have a gunner seat"; false};


_updateTarget = 0;
_targetPlayer = 0;
_canShoot = 1;
_delay = 1;
_arty setVariable ["canFire", true];

if (!alive (gunner _arty)) then {
    _unitClass = "O_Soldier_F";

    switch {_side} do {
        case WEST: {
            _unitClass = "B_Soldier_F";
        };

        case EAST: {
            _unitClass = "O_Soldier_F";
        };

        case INDEPENDENT: {
            _unitClass = "I_Soldier_F";
        };
    };
    _group = createGroup _side;
    _gunner = _group createUnit [_unitClass,[0,0,10], [], 0, "FORM"];
    _gunner moveInGunner _arty;
    _gunner setBehaviour "AWARE";
    _gunner setCombatMode "BLUE";
};

{
    (gunner _arty) disableAI _x;
} forEach ["TARGET","AUTOTARGET","FSM","AIMINGERROR","SUPPRESSION","CHECKVISIBLE","COVER","AUTOCOMBAT","MINEDETECTION","PATH","TEAMSWITCH"];

_weapon = "M134_minigun";
switch (_weaponType) do {
    case 1: {
        _weapon = "autocannon_35mm";
    };
    case 2: {
        _weapon = "gatling_30mm";
    };
    case 3: {
        _weapon = "RHS_weap_2a14";
    };
    case 4:{
        _weapon = "CUP_Vacannon_2A14_veh";
    };
    case 5:{
        _weapon = "CUP_Vhmg_DSHKM_veh";
    };
};

{
    _arty removeWeaponTurret [_x, [0]];
} forEach (_arty weaponsTurret [0]);

gunner _arty setVariable ["oks_disable_hunt",true];
_arty setVariable ["oks_disable_hunt",true];
_arty addWeaponTurret [_weapon,[0]];
_arty addMagazineTurret [(getArray(configfile >> "CfgWeapons" >> _weapon >> "magazines") select 0), [0]];
_arty selectWeaponTurret [_weapon,[0]];

_target = (_arty getRelPos [(random [0, 40, 100]), (10 + (random [-25, 0, 25]))]);
_target set [2, 500];
_arty doWatch _target;
if !(isNil "arrow") then {
    arrow setPosATL _target;
};

sleep (5 + (Random 5));

_arty setVehicleAmmo 0;
_arty setVehicleAmmo 1;

_fnc_Fire = {
    params ["_arty", "_weapon"];

    _arty setVariable ["canFire", false];

    sleep (random [1, 2.5, 4]);

    _weaponState = (weaponState [_arty, [0], _weapon]);
    for "_i" from 1 to 10 step 1 do {
        _arty action ["UseWeapon", _arty, (gunner _arty), 0];
        sleep (getNumber(configfile >> "CfgWeapons" >> (_weaponState select 1) >> (_weaponState select 2) >> "reloadTime"));
    };

    if ((_weaponState select 4) < 1) then { // If out of ammo, reload
        sleep 15;
        _arty setVehicleAmmo 1;
    };
    _arty setVariable ["canFire", true];
};

while {Alive _arty} do {
    if (_updateTarget isEqualTo 0) then {
        _closePlayers = ((_arty nearObjects ["Air", _range]) select {(([_x, "VIEW", _arty] checkVisibility [(eyePos _arty), (eyePos _x)]) > 0) && side _x != _side});

        if (!(_closePlayers isEqualTo []) && (_canShoot > 0)) then {
            _targetPlayer = (selectRandom _closePlayers);

            _speed = (velocity _targetPlayer);
            _vel = (velocityModelSpace _targetPlayer);
            _target = (_targetPlayer getRelPos [((_vel select 1) * (random [0.5, 1, 0.5])), (_vel select 0)]);
            _target set [2, ((getPosATL _targetPlayer) select 2) + (_speed select 2)];

            _delay = 0.5;
            _updateTarget = 15;
        } else {
            _delay = 5;
            if (_ambient) then {
                _target = (_arty getRelPos [(random [0, 40, 100]), (10 + (random [-40, 0, 40]))]);
                _target set [2, 500];

                _targetPlayer = 0;
                _delay = (random [3, 6, 3]);
                _updateTarget = 3;
            };
        };
    } else {
        if (_targetPlayer isEqualType objNull) then {
            _speed = (velocity _targetPlayer);
            _vel = (velocityModelSpace _targetPlayer);
            _target = (_targetPlayer getRelPos [((_vel select 1) * (random [0.5, 1, 0.5])), (_vel select 0)]);
            _target set [2, ((getPosATL _targetPlayer) select 2) + (_speed select 2)];
        };
    };

    _arty doWatch _target;
    if !(isNil "arrow") then {
        arrow setPosATL _target;
    };

    if ((_arty getVariable ["canFire", false]) && ((_targetPlayer isEqualType objNull || _updateTarget isEqualTo 0) || _ambient)) then {
        [_arty, _weapon] spawn _fnc_Fire;
    };
    _updateTarget = _updateTarget - 1;
    sleep _delay;
};