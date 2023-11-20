// [_StrikeArea] execVM "Scripts\OKS_Support\OKS_StrobeStrike.sqf";

Params["_StrikeArea"];

_StrobeTargets = OKS_AllStrobeLocations select {_X inArea _StrikeArea};
_StrobeArty = OKS_StrobeStrikeArty;

_ETA = (_StrobeArty select 0) getArtilleryETA [_StrobeTargets select 0, currentMagazine (_StrobeArty select 0)];
["HQ","Side",format["Copy on strike request, missiles inbound ETA %1, out.",round _ETA]] remoteExec ["OKS_Chat",0];
{[_X,_StrobeTargets,1,0,true] execVM "Scripts\OKS_Ambience\OKS_ArtySupression.sqf"} foreach _StrobeArty;