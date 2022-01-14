// _null = [getpos this,east,1000,3] spawn OKS_AA_Guard;
// _null = [getpos this,east,1000,3] execVM "Scripts\OKS_Ambience\OKS_AA_Guard.sqf";
// [SpawnPosition,Side,_Range,Cycles] spawn GW_Ambient_AAA;

params ["_Position","_side","_Range","_Cycles"];
private _Debug_Variable = false;
private ["_unitClass"];

if(!isServer) exitWith {false};

OKS_AA_Check = {

    Params["_Helicopter","_Cycles","_Trigger","_Position"];
    private _Debug_Variable = true;

    _AA = _Trigger GetVariable ["OKS_AA_TRIGGER_UNIT",objNull];

    if(isNull _AA || !Alive _AA) exitWith { if(_Debug_Variable) then { SystemChat "No AA available. Exiting..."}};
    if(_Debug_Variable) then { SystemChat str [_Helicopter,_Cycles,_Trigger,_AA] };

    if !(_Helicopter getVariable ["OKS_ANTIAIR_CHECK",false]) then {
        _Helicopter setVariable ["OKS_ANTIAIR_CHECK",true,true];
        Private ["_PreviousPosition"];
        systemChat str (_Trigger);

        While {_Helicopter in list _Trigger} do {
            if(_Helicopter getVariable ["OKS_ANTIAIR_VALUE",0] >= _Cycles && !(_AA getVariable ["OKS_AA_isACTIVE",false])) then {
                if(_Debug_Variable) then { systemChat format["AA Value - %1 - Enabling AA",_Helicopter getVariable ["OKS_ANTIAIR_VALUE",0]]};
                _AA setVariable ["OKS_AA_isACTIVE",true,true];
                _AA enableAI "PATH";
                _AA setCombatMode "RED";
                _AA setBehaviour "AWARE";
                _AA disableAI "FSM";
                _AA disableAI "COVER";
                _AA doTarget _Helicopter;
                _AA reveal [_Helicopter,4];
                _AA selectWeapon (SecondaryWeapon _AA);

                [_AA,_Helicopter,_Trigger] spawn {
                    Params ["_AA","_Helicopter","_Trigger"];
                    While {Alive _AA && alive _Helicopter && _Helicopter in list _Trigger} do{
                        _AA doMove (position _Helicopter);
                        sleep 5;
                    };
                };

            };
            _PreviousPosition = getPos _helicopter;
            sleep 10;
            if(getPos _Helicopter distance2d _PreviousPosition < 200 && _Helicopter getVariable ["OKS_ANTIAIR_VALUE",0] < _Cycles) then {
                _Value = _Helicopter getVariable ["OKS_ANTIAIR_VALUE",0];
                _Value = _Value + 1;
                _Helicopter setVariable ["OKS_ANTIAIR_VALUE",_Value];
                if(_Debug_Variable) then { systemChat format["AA Value - %1 - %2",_Helicopter,_Value]};
            } else {
                _Helicopter setVariable ["OKS_ANTIAIR_VALUE",0];
                 if(_Debug_Variable) then { systemChat format["Reset AA Value - %1",_Helicopter]};
            };
        };
        _Helicopter setVariable ["OKS_ANTIAIR_CHECK",false,true];
        _AA setVariable ["OKS_AA_isACTIVE",false,true];
        if(_Debug_Variable) then { systemChat format["AA Value - %1 - Reset",_Helicopter]};

        _AA setCombatMode "BLUE";
        _AA setBehaviour "SAFE";

        if(!isNil "_Helicopter" && !isNil "_Position") then {
            systemChat format["AA Returning to Position: %1",_Position];
            _AA reveal [_Helicopter,0];
            _AA doMove _Position;
            systemChat str [_AA,_Position,_AA distance2d _Position];
            waitUntil {sleep 5; _AA distance2d _Position < 15};
        };
        _AA disableAI "PATH";
    };
};

    switch (_side) do {
        case WEST: {
            _unitClass = "B_Soldier_AA_F";
        };

        case EAST: {
            _unitClass = "O_Soldier_AA_F";
        };

        case INDEPENDENT: {
            _unitClass = "I_Soldier_AA_F";
        };

        default {
            _unitClass = "O_Soldier_AA_F";
        };
    };

    _group = createGroup _side;
    _AA = _group createUnit [_unitClass,_Position, [], 0, "FORM"];
    Private _AA_Name = format["OKS_ANTIAIR_UNIT_%1",round(random 9999)];
    _AA setVehicleVarName _AA_Name;
    _AA setBehaviour "AWARE";
    _AA setCombatMode "BLUE";
    _AA disableAI "PATH";
    if(_Debug_Variable) then { systemChat format["AA Spawned - %1",_AA]};

    _trigger = createTrigger ["EmptyDetector", _Position,true];
    _trigger setTriggerArea [_range, _range, 0, false];
    _trigger setVariable ["OKS_AA_TRIGGER_UNIT",_AA,true];
    Private _trigger_Name = format["OKS_ANTIAIR_TRIGGER_%1",round(random 9999)];
    _trigger setVehicleVarName _trigger_Name;

    if(_Debug_Variable) then { systemChat format["Trigger Created - %1",_trigger]};

    _trigger setTriggerActivation ["ANYPLAYER","PRESENT",true];
    _trigger setTriggerStatements ["this && {vehicle _X isKindOf 'Helicopter'} count thisList > 0", format [" {if(vehicle _X isKindOf 'Helicopter') then {[_X,%1,thisTrigger,%2] spawn OKS_AA_Check}} foreach thisList;",_Cycles,_Position], ""];
