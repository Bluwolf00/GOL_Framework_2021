/*
    Examples:
    _null = [this] spawn OKS_Suppressed;
    _null = [this,0.8,3,6] execVM "Scripts\OKS_Ambience\OKS_Suppressed.sqf";
*/
params [
    ["_Unit",objNull,[objNull]],            // #0 OBJECT - Person who is going to surrender
    ["_SuppressThreshold",OKS_Suppressed_Threshold,[1]],                    // #1 Chance - Numerical chance 0 being 100%, 0.5 = 50% and 1 = 0%   
    ["_MinimumTime",OKS_Suppressed_MinimumTime,[1]],                   // #2 Distance - Numerial distance where player must be within to activate the codes (Prefer low around 20 meters)
    ["_MaximumTime",OKS_Suppressed_MaximumTime,[1]]
];

_Unit setVariable ["lambs_danger_disableAI", true,true];
_Unit setVariable ["OKS_DefaultStance",UnitPos _Unit,true];
_Unit setVariable ["OKS_SuppressedThreshold",_SuppressThreshold,true];
_Unit setVariable ["OKS_SuppressedMin",_MinimumTime,true];
_Unit setVariable ["OKS_SuppressedMax",_MaximumTime,true];

_Unit addEventHandler ["Suppressed", {
	params ["_Unit"];
    private ["_SuppressedStance"];
    
    private _Debug_Variable = true;
    private _PreviousPosition = _Unit getVariable ["OKS_DefaultStance","up"];
    switch (toLower _PreviousPosition) do {
        case "up": {
            _SuppressedStance = "down";
        };
        case "middle": {
            _SuppressedStance = "down";
        };       
        default {
            _SuppressedStance = "down";
        }
    };

    private _SuppressThreshold = _Unit getVariable ["OKS_SuppressedThreshold",0.8];
    if(getSuppression _unit > _SuppressThreshold && !(_Unit getVariable ["OKS_IsSuppressed",false])) then {
       
        _Unit setVariable ["OKS_IsSuppressed",true,true];
        private _MinimumTime = _Unit getVariable ["OKS_SuppressedMin",3];
        private _MaximumTime = _Unit getVariable ["OKS_SuppressedMax",6];

        _RandomTime = (_MaximumTime - _MinimumTime);
        private _Delay = (_MinimumTime + (random _RandomTime));  

        if(_Debug_Variable) then {
            SystemChat format["Suppressed for %1 in stance %2",_Delay,_SuppressedStance];
        };  

        [_Unit,_SuppressedStance,_Delay,_PreviousPosition,_Debug_Variable,_SuppressThreshold] spawn {

            Params["_Unit","_SuppressedStance","_Delay","_PreviousPosition","_Debug_Variable","_SuppressThreshold"];         

            private _CombatMode = combatMode (group _Unit);
            [_Unit,"BLUE"] remoteExec ["setCombatMode",0];

            [_Unit,_CombatMode] spawn {
                params ["_Unit","_CombatMode"];
                sleep 2;
                [_Unit,_CombatMode] remoteExec ["setCombatMode",0];
            };

            [_Unit,_SuppressedStance] remoteExec ["setUnitPos",0];
            sleep _Delay;

            if(getSuppression _unit < _SuppressThreshold) then {
                sleep (random [1,2,3]); 
                [_Unit,"UP"] remoteExec ["setUnitPos",0];   
                if(_Debug_Variable) then {
                    SystemChat format["Suppress reset to %1",_PreviousPosition];
                };                          
            };
            _Unit setVariable ["OKS_IsSuppressed",false,true];
        }


    };
}];