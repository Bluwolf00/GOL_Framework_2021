Params ["_Unit","_Side"];
//
// [this] execVM "OKS_Civ_Animation.sqf";
// "Acts_CivilStand_Default","Acts_CivilListening_1","Acts_CivilListening_2","Acts_CivilTalking_1","Acts_CivilTalking_2","Acts_CivilIdle_2","Acts_CivilIdle_1"

if (hasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky
_Unit disableAI "ANIM";
_Anim = selectRandom ["STAND_U1","STAND_U2","STAND_U3"];
_Unit setRandomLip true;
[_Unit, _Anim, "ASIS"] call BIS_fnc_ambientAnim;

waitUntil { {_Side KnowsAbout _X >= 2.5} count AllPlayers > 0};
_Unit call BIS_fnc_ambientAnim__terminate;
_Unit setBehaviour "CARELESS";
_Unit disableAI "FSM";
_Unit setUnitPosWeak "UP";
_Unit allowFleeing 1;
_Unit playAction "Panic";