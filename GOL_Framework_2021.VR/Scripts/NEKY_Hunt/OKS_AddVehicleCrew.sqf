    // OKS_AddVehicleCrew
    // [_this,west] call OKS_AddVehicleCrew

    if(HasInterface && !isServer) exitWith {};

    Params["_Vehicle","_Side"];
    Private ["_UnitClass","_Group","_Commander","_Gunner","_Driver"];

    _Settings = [_Side] call OKS_Dynamic_Setting;
    _Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian"];

    _Debug_Variable = false;

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

    _Group = createGroup _Side;
    if(_Vehicle emptyPositions "commander" > 0) then {
        _Commander = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Commander setRank "SERGEANT";
        //_Commander assignAsCommander _Vehicle;
        //[_Commander] orderGetIn true;
        _Commander moveinCommander _Vehicle;
    };

    if(_Vehicle emptyPositions "gunner" > 0) then {
        _Gunner = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Gunner setRank "CORPORAL";
        //_Gunner assignAsCommander _Vehicle;
        //[_Gunner] orderGetIn true;
        _Gunner moveinGunner _Vehicle;
    };

    if(_Vehicle emptyPositions "driver" > 0) then {
        _Driver = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Driver setRank "PRIVATE";
        //_Driver assignAsCommander _Vehicle;
        //[_Driver] orderGetIn true;
        _Driver moveinDriver _Vehicle;
    };
    {[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;
    _Group



