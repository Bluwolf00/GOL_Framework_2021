// Ranks
Params ["_Player"];
private ["_ltd","_sgt","_uid","_cpl","_rank"];

_ltd = "LIEUTENANT";
_sgt = "SERGEANT";
_cpl = "CORPORAL";

_uid = getPlayerUID (_Player);

switch _uid do {
    case "76561198013929549": {_rank = _ltd}; // Oksman
    case "76561198086056020": {_rank = _ltd}; // Blu.
    case "76561199681025229": {_rank = _sgt}; // Rutters
    case "76561198005972885": {_rank = _cpl}; // Pilgrim
    case "76561198014971848": {_rank = _cpl}; // Filth
    case "76561198091519166": {_rank = _cpl}; // Juan Sanchez
    case "76561198058521961": {_rank = _cpl}; // Joona
    case "76561198210159148": {_rank = _cpl}; // Eric
    default {_rank ="PRIVATE"};
};

(_Player) setrank _rank;
