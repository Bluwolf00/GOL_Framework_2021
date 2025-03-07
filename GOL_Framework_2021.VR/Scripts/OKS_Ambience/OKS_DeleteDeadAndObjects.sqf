/*

    Use this code to delete corpses and objects as well as vehicles from the trigger area.

    Example:
    [DeleteTrigger_1] spawn OKS_DeleteDeadAndObjects;

*/

Params ["_TriggerName","_ShouldDeleteVehicles","_ShouldDeleteObjects"];

// Deletes all vehicle wrecks and empty vehicles.
if(_ShouldDeleteVehicles) then {
    {
        deleteVehicle _X
        sleep 0.25;
    } foreach ((allDead inAreaArray _TriggerName) select { vehicle _X != _X });

    {
        deleteVehicle _X
        sleep 0.25;
    } foreach ((vehicles inAreaArray _TriggerName) select { !isPlayer _X });   
};

// Deletes all dead soldiers that aren't vehicles.
{
    deleteVehicle _X
    sleep 0.25;
} foreach ((allDead inAreaArray _TriggerName) select { vehicle _X == _X })

// Deletes all non-player soldiers.
{
    deleteVehicle _X
    sleep 0.25;
} foreach ((allUnits inAreaArray _TriggerName) select { !isPlayer _X });

if(_ShouldDeleteObjects) then {
    _AreaArray = triggerArea _TriggerName;
    _X = _AreaArray select 0;
    _Y = _AreaArray select 1;
    _MaxAxis = _X max _Y; 

    _nearObjects = nearestTerrainObjects [_TriggerName, ["HOUSE","BUILDING","WALL","RUIN"], _MaxAxis];
    {
        deleteVehicle _X;
        sleep 0.25;
    } foreach _nearObjects;
};