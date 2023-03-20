/*
    Destroy or damage all houses inside a trigger

    Example:
    [thisTrigger,true,[8,10]] spawn OKS_Destroy_Houses;
    [thisTrigger,true,[8,10]] execVM "Scripts\OKS_Ambience\OKS_Destroy_Houses.sqf";

    Param 1: TriggerName or in trigger thisTrigger
    Param 2: Should set to random damage, if not then 100% damage always.
    Param 3: Array with two numbers, lower range, and max range, 0-10 (0 = 0%, 10 = 100%)

    If you want to blacklist certain buildings, make sure to add a logic object found in Modules (F5) => Objects
    Add this in the init of the logic and place it as close to the center of the house as possible.

    Code:
    (nearestObject [getPos this,"HOUSE"]) setVariable ["OKS_Destroy_Blacklist",true,true];
    (nearestBuilding this) setVariable ["OKS_Destroy_Blacklist",true,true];

    We use two methods as certain old houses don't show up for nearestBuildings and some new buildings don't show up on nearestObject.
*/

Params ["_Trigger","_RandomDamage","_DamageVariation"];

sleep 1;
_MaxSize = ([[(triggerArea _Trigger) select 0,(triggerArea _Trigger) select 1], [], {_x}, "DESCEND"] call BIS_fnc_sortBy) select 0;
_Buildings = nearestTerrainObjects [_Trigger, ["HOUSE"], _MaxSize];

{
    if(_X inArea _Trigger && !(_X getVariable ["OKS_Destroy_Blacklist",false])) then {
        if(_RandomDamage && _DamageVariation isNotEqualTo []) then {
            _X setDamage (([_DamageVariation#0, _DamageVariation#1] call BIS_fnc_randomInt) / 10);
        } else {
            _X setDamage 1;
        };
        sleep 0.1;
    }
} foreach _Buildings;