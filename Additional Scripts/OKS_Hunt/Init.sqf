//	[] execVM "Scripts\OKS_HUNT\Init.sqf";
//
//	This initializes all the functions for OKS HUNT.
//
//	Made by Oksman

// Functions
OKS_Dynamic_Hunt = compile preprocessFileLineNumbers "Scripts\OKS_HUNT\OKS_Dynamic_Hunt.sqf";
OKS_Dynamic_Track = compile preprocessFileLineNumbers "Scripts\OKS_HUNT\OKS_Dynamic_Track.sqf";


// [ENEMYFACTION,MINRANGE,MAXRANGE,REFRESHRATE] spawn OKS_Dynamic_Hunt;
//
// Uncomment to use
// null = [EAST,1000,2000,60] spawn OKS_Dynamic_Hunt;

