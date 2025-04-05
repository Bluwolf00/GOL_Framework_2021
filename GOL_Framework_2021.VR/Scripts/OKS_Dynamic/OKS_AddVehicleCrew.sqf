    // OKS_AddVehicleCrew
    // [_this,west,0] call OKS_AddVehicleCrew
    // 

    if(HasInterface && !isServer) exitWith {};

    Params[
        ["_Vehicle",objNull,[objnull]],
        ["_Side",east,[sideUnknown]],
        ["_CrewSlots",0,[-1]], // 0 = full crew, 1 = driver only, 2 = gunner only, 3 = commander only
        ["_CargoSlots",0,[-1]] // Amount of Infantry in Cargo
    ];
    Private ["_UnitClass","_Group","_Commander","_Gunner","_Driver"];

    _Settings = [_Side] call OKS_Dynamic_Setting;
    _Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
    _Debug_Variable = false;

    switch (_side) do {
        case WEST: {
            _unitClass = "B_crew_F";
        };

        case EAST: {
            _unitClass = "O_crew_F";
        };

        case INDEPENDENT: {
            _unitClass = "I_crew_F";
        };

        case civilian:{
            _unitClass = "C_man_1_1_F";
        };

        default {
            _unitClass = "O_crew_F";
        };
    };

    _Group = createGroup _Side;
    _Group setVariable ["acex_headless_blacklist",true,true];
    if(_Debug_Variable) then {systemChat format ["Group: %3 Side: %2 - %1 Class Selected",_unitClass,_Side,_Group]};
    if(_Vehicle emptyPositions "commander" > 0 && (_CrewSlots == 0 || _CrewSlots == 3)) then {
        if(_Debug_Variable) then { systemChat "Creating Commander"};
        _Commander = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Commander setRank "SERGEANT";
        //_Commander assignAsCommander _Vehicle;
        //[_Commander] orderGetIn true;
        _Commander moveinCommander _Vehicle;
    };

    if(_Vehicle emptyPositions "gunner" > 0 && (_CrewSlots == 0 || _CrewSlots == 2)) then {
        if(_Debug_Variable) then { systemChat "Creating Gunner"};
        _Gunner = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Gunner setRank "CORPORAL";
        //_Gunner assignAsCommander _Vehicle;
        //[_Gunner] orderGetIn true;
        _Gunner moveinGunner _Vehicle;
    };

    if(_Vehicle emptyPositions "driver" > 0 && (_CrewSlots == 0 || _CrewSlots == 1)) then {
        if(_Debug_Variable) then { systemChat "Creating Driver"};
        _Driver = _Group CreateUnit [_UnitClass, [0,0,0], [], 5, "NONE"];
        _Driver setRank "PRIVATE";
        //_Driver assignAsCommander _Vehicle;
        //[_Driver] orderGetIn true;
        _Driver moveinDriver _Vehicle;
    };

    if(_CargoSlots > 0) then {
        if(([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - ([TypeOf _Vehicle,false] call BIS_fnc_crewCount) >= 4) then {
            _CargoSeats = ([TypeOf _Vehicle,true] call BIS_fnc_crewCount) - ([TypeOf _Vehicle,false] call BIS_fnc_crewCount);
            if(_CargoSeats > _CargoSlots) then { _CargoSeats = _CargoSlots };
                /// Create Leader
                _Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
                _Unit setRank "SERGEANT";
                _Unit MoveInCargo _Vehicle;
                _Group selectLeader _Unit;
            for "_i" from 1 to (_CargoSeats - 1) do
            {
                Private "_Unit";
                _Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], 0, "NONE"];
                _Unit setRank "PRIVATE";
                _Unit MoveInCargo _Vehicle;
            };
        } else {
            SystemChat format["Vehicle Type: %1 does not have 4 or more cargo slots",typeOf _Vehicle];
        };
    };

    {[_x] remoteExec ["GW_SetDifficulty_fnc_setSkill",0]} foreach units _Group;

    if(_Vehicle isKindOf "LandVehicle") then {
        [_Vehicle] spawn OKS_ForceVehicleSpeed;
        [_Vehicle] spawn OKS_AbandonVehicle;
        if((["T34", typeOf _Vehicle] call BIS_fnc_inString ||
            ["T55", typeOf _Vehicle] call BIS_fnc_inString ||
            ["T72", typeOf _Vehicle] call BIS_fnc_inString ||
            ["T80", typeOf _Vehicle] call BIS_fnc_inString) && ["UK3CB", typeOf _Vehicle] call BIS_fnc_inString) then {
            [_Vehicle] spawn OKS_AdjustDamage;
        };
    };   

    _Group



