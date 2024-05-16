// Example
// [west_1,east_1,meet_1,west,east,["UK3CB_CW_US_B_EARLY_M1A1","UK3CB_CW_US_B_LATE_LAV25"],["UK3CB_CHD_O_T72A","UK3CB_CHD_O_BMP1"]] spawn OKS_AI_Battle;    
// [west_1,east_1,meet_1,west,east,["UK3CB_CW_US_B_EARLY_M1A1","UK3CB_CW_US_B_LATE_LAV25"],["UK3CB_CHD_O_T72A","UK3CB_CHD_O_BMP1"]] execVM "Scripts\OKS_Spawn\OKS_AI_Battle.sqf";

Params [
    ["_Faction1Spawn",objNull,[objNull]],
    ["_Faction2Spawn",objNull,[objNull]],
    ["_MeetingPos",objNull,[objNull]],
    ["_Side1",west,[sideUnknown]],
    ["_Side2",east,[sideUnknown]],
    ["_Faction1Classes",["UK3CB_CW_US_B_EARLY_M1A1"],[[]]],
    ["_Faction2Classes",["UK3CB_CHD_O_T72A"],[[]]],
    ["_DefendingSide",sideUnknown,[sideUnknown]]
];

_Faction1Positions = [
    getPos _Faction1Spawn,
    _Faction1Spawn getPos [25,90],
    _Faction1Spawn getPos [25,-90]
];

_Faction2Positions = [
    getPos _Faction2Spawn,
    _Faction2Spawn getPos [25,90],
    _Faction2Spawn getPos [25,-90]
];


private _SpawnAttack = {

    Params ["_Position","_MeetingPos","_FactionClasses","_Side","_AllUnitsArray","_AllVehiclesArray","_DefendingSide"];

    _Vehicle = CreateVehicle [selectRandom _FactionClasses,_Position, [], -1, "NONE"];
    [_Vehicle] spawn OKS_ReduceDamage;
    
    _AllVehiclesArray pushBack _Vehicle;

    _crew = [_Vehicle,_Side] call OKS_AddVehicleCrew;
    {_AllUnitsArray pushBack _X} foreach units _crew;

    if(_DefendingSide == sideUnknown) then {
        _DefendingSide = _Side
    };

    if(_Side == _DefendingSide) then {
        _HoldWP = _crew addWaypoint [_Vehicle getPos [5,(_Vehicle getDir _MeetingPos)],-1];
        _HoldWP setWaypointType "HOLD";
        _Vehicle setFuel 0;
    } else {
        _SadWP = _crew addWaypoint [_MeetingPos,0];
        _SadWP setWaypointType "SAD";
    };

    sleep 5;
    _Vehicle setDir (_Vehicle getDir _MeetingPos);
};
private _AllUnitsArray = [];
private _AllVehiclesArray = [];
private _DefendingSideOriginal = _DefendingSide;
private _MeetingPosOriginal = _MeetingPos;
private _Bool1 = false;
private _Bool2 = false;

[_MeetingPos,_Faction1Classes,_Side1,_AllUnitsArray,_AllVehiclesArray,_DefendingSide,_Faction1Positions,_SpawnAttack] spawn {
    Params ["_MeetingPos","_Faction1Classes","_Side1","_AllUnitsArray","_AllVehiclesArray","_DefendingSide","_Faction1Positions","_SpawnAttack"];
    {
        [_X,_MeetingPos,_Faction1Classes,_Side1,_AllUnitsArray,_AllVehiclesArray,_DefendingSide] spawn _SpawnAttack;
        sleep 30;
    } forEach _Faction1Positions; 
};

[_MeetingPosOriginal,_Faction2Classes,_Side2,_AllUnitsArray,_AllVehiclesArray,_DefendingSideOriginal,_Faction2Positions,_SpawnAttack] spawn {

    Params ["_MeetingPosOriginal","_Faction2Classes","_Side2","_AllUnitsArray","_AllVehiclesArray","_DefendingSideOriginal","_Faction2Positions","_SpawnAttack"];
    {
        [_X,_MeetingPosOriginal,_Faction2Classes,_Side2,_AllUnitsArray,_AllVehiclesArray,_DefendingSideOriginal] spawn _SpawnAttack;
        sleep 30;
    } forEach _Faction2Positions;
};

Sleep (30 * (count _Faction1Positions));
waitUntil{
    sleep 10;
    ({
        (Alive _X || [_X] call ace_common_fnc_isAwake) && side _X == _Side1
    } count _AllUnitsArray == 0
        or
    {
        (Alive _X || [_X] call ace_common_fnc_isAwake) && side _X == _Side2
    } count _AllUnitsArray == 0)
};

{
    deleteVehicle _X;
} foreach _AllUnitsArray;
{
    deleteVehicle _X;
} foreach _AllVehiclesArray;