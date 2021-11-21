// _null = [this,east,false,1500,true] spawn GW_Ambient_AAA;
// [this,east,false,1500,true] execVM "Scripts\OKS_Ambience\GW_Ambient_AAA.sqf";
// [AntiAirObject (ObjNull),Side(SideEmpty),isHMG (Bool),Range (Meters),RadarInfo (Bool)] spawn GW_Ambient_AAA;
//

params [
    ["_arty",objNull,[objnull]],
    ["_side",east,[sideUnknown]],
    ["_isHMG",false,[true]],
    ["_Range",1500,[0]],
    ["_Radar",true,[true]]
];

if ((count(fullCrew [_arty, "gunner", true]) isEqualTo 0)) exitWith {systemChat "Vehicle does not have a gunner seat"; false};
private _weapon = "";
private _Debug_Variable = false;
private ["_unitClass","_arrow","_AddValue"];

if(_Debug_Variable) then {
    _arrow = createVehicle ["Sign_Sphere100cm_F",[0,0,0]];
};

_updateTarget = 0;
_targetPlayer = 0;
_canShoot = 1;
_delay = 1;
_arty setVariable ["canFire", true];

if (isNull gunner _arty) then {
    //systemChat "Null Gunner";
    switch (_side) do {
        case WEST: {
            _unitClass = "B_Soldier_F";
        };

        case EAST: {
            _unitClass = "O_Soldier_F";
        };

        case INDEPENDENT: {
            _unitClass = "I_Soldier_F";
        };

        default {
            _unitClass = "O_Soldier_F";
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


_weapon = (_arty weaponsTurret [0]) select 0;
_target = (_arty getRelPos [(random [0, 40, 100]), (10 + (random [-25, 0, 25]))]);
_target set [2, 500];
_arty doWatch _target;
if !(isNil "_arrow") then {
    _arrow setPosATL _target;
};

sleep (5 + (Random 5));

_arty setVehicleAmmo 0;
_arty setVehicleAmmo 1;
_arty setVehicleReceiveRemoteTargets true;
_arty setVehicleRadar 1;
gunner _arty setSkill ["spotDistance", 0.9];
gunner _arty setSkill ["spotTime", 0.9];

_fnc_Fire = {
    params ["_arty", "_weapon","_targetPlayer"];

    _arty setVariable ["canFire", false];
    _weaponState = (weaponState [_arty, [0], _weapon]);
    for "_i" from 1 to selectRandom[15,20,25] step 1 do {
        _arty action ["UseWeapon", _arty, (gunner _arty), 0];
        sleep (getNumber(configfile >> "CfgWeapons" >> (_weaponState select 1) >> (_weaponState select 2) >> "reloadTime"));
    };

     if(typeName _targetPlayer isEqualTo "OBJECT") then {
        if(_targetPlayer isKindOf "AIR") then {
            sleep (random [1,2.5,4]);
        } else {
            sleep (random [6, 8, 10]);
        };
    } else {
        sleep (random [5, 8, 11]);
    };

    if ((_weaponState select 4) < 1) then { // If out of ammo, reload
        sleep 15;
        _arty setVehicleAmmo 1;
    };
    _arty setVariable ["canFire", true];
};

while {Alive _arty && Alive (gunner _arty) && (side (gunner _arty) isEqualTo _side)} do {

    if(_Radar) then {
        _Radars = _Arty nearEntities ["StaticMGWeapon",4000];
        _Radars select {"FakeWeapon" in (_Arty weaponsTurret [0])};
        _RadarTargets = (_arty nearEntities [["Air"], _Range]) select {
            (side _X != _side) &&
            (_side getFriend (side _X) <= 0.6)
        };
        _RadarTarget = selectRandom _RadarTargets;
        if(_Radars isNotEqualTo [] && !isNil "_RadarTarget") then {
            //SystemChat str [_Radars,_RadarTarget,_RadarTargets];
            _sortedRadars = [_Radars, [], {_x knowsAbout _RadarTarget}, "DESCEND"] call BIS_fnc_sortBy;
            _Value = (_sortedRadars select 0) knowsAbout _RadarTarget;
            _Arty reveal [_RadarTarget,_Value];
        };
    };

    if (_updateTarget isEqualTo 0) then {
        _closePlayers = (_arty nearEntities [["Man","LandVehicle","Air"], _Range]) select {
            (side _X != _side) &&
            if(_X isKindOf "Man" || _X isKindOf "LandVehicle") then {(_Arty knowsAbout _X >= 2.5)} else {_Arty knowsAbout _x > 1} &&
            (_side getFriend (side _X) <= 0.6) &&
            (([_x, "VIEW", _arty] checkVisibility [(eyePos _arty), (eyePos _x)]) > 0) &&
            !(typeOf _X in ["NonSteerable_Parachute_F","Steerable_Parachute_F"])
        };
        if(_Debug_Variable) then {
            //SystemChat str _closePlayers;
        };

        if (!(_closePlayers isEqualTo []) && (_canShoot > 0)) then {
            if(_Debug_Variable) then {
                //SystemChat "GW - AAA - Update Target";
            };
            _targetPlayer = (selectRandom _closePlayers);
            _speed = (velocity _targetPlayer);
            _vel = (velocityModelSpace _targetPlayer);

            _MuzzleVelocity = (getNumber(ConfigFile >> "cfgMagazines" >> currentMagazine _arty >> "initSpeed"));
            //SystemChat str [(_arty distance _targetPlayer),_MuzzleVelocity];
            _TravelTime = (_arty distance _targetPlayer) / _MuzzleVelocity;

            if(_TravelTime < 1) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.25,0.3,0.35,0.3]
                } else {
                    _AddValue = selectRandom [0.15,0.25,0.2,0.3]
                }
            };
            if(_TravelTime >= 1 && _TravelTime < 1.5) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.35,0.4,0.45,0.4]
                } else {
                    _AddValue = selectRandom [0.25,0.35,0.3,0.4]
                };
            };
            if(_TravelTime >= 1.5) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.45,0.5,0.55,0.6]
                } else {
                    _AddValue = selectRandom [0.4,0.45,0.5,0.55]
                };
                _AddValue = selectRandom [0.40,0.45,0.5,0.55]
            };

            _RelPosX = ((_speed select 0) * (_TravelTime + _AddValue));
            _RelPosY = ((_speed select 1) * (_TravelTime + _AddValue));

            _target = (_targetPlayer getRelPos [((_vel select 1) * _TravelTime), ((_vel select 0) * _TravelTime)]);
            _target set [0, ((getPosATL _targetPlayer) select 0) + _RelPosX];
            _target set [1, ((getPosATL _targetPlayer) select 1) + _RelposY];
            _target set [2, ((getPosATL _targetPlayer) select 2) + (_speed select 2)];

            _delay = 0.1;
            _updateTarget = 15;
        } else {
            if(_Debug_Variable) then {
                //SystemChat "GW - AAA - No Target";
            };

            _target = (_arty getRelPos [(random [0, 40, 100]), (10 + (random [-40, 0, 40]))]);
            _target set [2, 500];

            _targetPlayer = 0;
            _delay = (random [2, 3, 4]);
            _updateTarget = 3;
        };
    } else {
        if (_targetPlayer isEqualType objNull) then {
            _targetPlayer confirmSensorTarget [_side, true];
            _speed = (velocity _targetPlayer);
            _vel = (velocityModelSpace _targetPlayer);

            _MuzzleVelocity = (getNumber(ConfigFile >> "cfgMagazines" >> currentMagazine _arty >> "initSpeed"));
            //SystemChat str [(_arty distance _targetPlayer),_MuzzleVelocity];
            _TravelTime = (_arty distance _targetPlayer) / _MuzzleVelocity;

            if(_TravelTime < 1) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.25,0.3,0.35,0.3]
                } else {
                    _AddValue = selectRandom [0.15,0.25,0.2,0.3]
                }
            };
            if(_TravelTime >= 1 && _TravelTime < 1.5) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.35,0.4,0.45,0.4]
                } else {
                    _AddValue = selectRandom [0.25,0.35,0.3,0.4]
                };
            };
            if(_TravelTime >= 1.5) then {
                if(_isHMG) then {
                    _AddValue = selectRandom [0.45,0.5,0.55,0.6]
                } else {
                    _AddValue = selectRandom [0.4,0.45,0.5,0.55]
                };
                _AddValue = selectRandom [0.40,0.45,0.5,0.55]
            };

            _RelPosX = ((_speed select 0) * (_TravelTime + _AddValue));
            _RelPosY = ((_speed select 1) * (_TravelTime + _AddValue));

            _target = (_targetPlayer getRelPos [((_vel select 1) * _TravelTime), ((_vel select 0) * _TravelTime)]);
            _target set [0, ((getPosATL _targetPlayer) select 0) + _RelPosX];
            _target set [1, ((getPosATL _targetPlayer) select 1) + _RelposY];
            _target set [2, ((getPosATL _targetPlayer) select 2) + (_speed select 2)];
            _delay = 0.1;
        };
    };

    _arty doWatch _target;

    if !(isNil "_arrow") then {
        _arrow setPosATL _target;
    };

    if (_arty getVariable ["canFire", false]) then {
        [_arty, _weapon,_targetPlayer] spawn _fnc_Fire;
    };
    _updateTarget = _updateTarget - 1;
    sleep _delay;
};