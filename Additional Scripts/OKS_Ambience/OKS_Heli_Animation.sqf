Params ["_Unit","_Heli"];
//
// [this] execVM "OKS_Heli_Animation.sqf";
// "Acts_CivilStand_Default","Acts_CivilListening_1","Acts_CivilListening_2","Acts_CivilTalking_1","Acts_CivilTalking_2","Acts_CivilIdle_2","Acts_CivilIdle_1"

if (HasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky


_Dir = getdir _Unit;
_Unit disableAI "ANIM";
//_Anim = selectRandom ["Acts_NavigatingChopper_In","Acts_NavigatingChopper_Loop","Acts_NavigatingChopper_Out"];
_Unit call BIS_fnc_ambientAnim__terminate;
sleep 1;
_Unit switchMove "Acts_NavigatingChopper_In";
_Unit setDir _Dir;
sleep 0.2;
waitUntil { ((animationState _Unit) != "Acts_NavigatingChopper_In") };


while{!(getPos _Heli select 2 < 5)} do {
	_Unit playMove "Acts_NavigatingChopper_Loop";
	_Unit setDir _Dir;
	sleep 1.832;
	//waitUntil { ((animationState _Unit) != "Acts_JetsMarshallingSlow_loop") };
};

_Heli setFuel 0;
_Unit switchMove "Acts_NavigatingChopper_out";
_Unit setDir _Dir;
sleep 0.2;
waitUntil { ((animationState _Unit) != "Acts_NavigatingChopper_out") };
_Anim = selectRandom ["STAND1","STAND2"];
[_Unit, _Anim, "ASIS"] call BIS_fnc_ambientAnim;