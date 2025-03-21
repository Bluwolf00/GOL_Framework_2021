/*

    Use this code to delete corpses and objects as well as vehicles from the trigger area.

    Example:
    [DeleteTrigger_1] spawn OKS_DeleteDeadAndObjects;

*/

Params [
    "_TriggerName",
    ["_ShouldDeleteVehicles",true,[false]],
    ["_ShouldDeleteObjects",true,[false]]
];

// Deletes all vehicle wrecks and empty vehicles.
if(_ShouldDeleteVehicles) then {
    {
        deleteVehicle _X;
        sleep 0.25;
    } foreach ((allDead inAreaArray _TriggerName) select { vehicle _X != _X });

    {
        if ( (crew _x) findIf { isPlayer _x } == -1 ) then {
            deleteVehicle _x;
            sleep 0.25;
        };
    } forEach (vehicles inAreaArray _TriggerName);
};

// Deletes all dead soldiers that aren't vehicles.
{
    deleteVehicle _X;
    sleep 0.25;
} foreach ((allDead inAreaArray _TriggerName) select { vehicle _X == _X });

// Deletes all non-player soldiers.
{
    deleteVehicle _X;
    sleep 0.25;
} foreach ((allUnits inAreaArray _TriggerName) select { !isPlayer _X });

// Deletes all objects placed in editor or Zeus.
if(_ShouldDeleteObjects) then {
    _AreaArray = triggerArea _TriggerName;
    _X = _AreaArray select 0;
    _Y = _AreaArray select 1;
    _MaxAxis = _X max _Y; 

    _nearObjects = (8 allObjects 0) inAreaArray _TriggerName select { !(["EmptyDetector", typeof _X] call BIS_fnc_inString) };  
    {
        deleteVehicle _X;
        sleep 0.25;   
    } foreach _nearObjects;
};