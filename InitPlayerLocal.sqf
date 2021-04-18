// Ranks
private ["_ltd","_sgt","_uid","_cpl","_rank"];

_ltd = "LIEUTENANT";
_sgt = "SERGEANT";
_cpl = "CORPORAL";

_uid = getPlayerUID player;

switch _uid do {
case "76561198005972885": {_rank = _ltd};
case "76561198014971848": {_rank = _sgt};
case "76561198013929549": {_rank = _sgt};
case "76561198086056020": {_rank = _sgt};
case "76561198030991949": {_rank = _cpl};
case "76561198054322437": {_rank = _cpl};
case "76561198024730389": {_rank = _cpl};
default {_rank ="PRIVATE";};
};

player setrank _rank;
