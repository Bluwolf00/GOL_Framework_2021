Params ["_Unit","_Anim"];
//
// [this,"Acts_NavigatingChopper_out"] execVM "OKS_Loop_Animation.sqf";


if (HasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky

_Unit disableAI "MOVE";
_Unit disableAI "ANIM";

while{alive _Unit} do {
	_Unit playMove _Anim;
	sleep 0.5;
	waitUntil { ((animationState _Unit) != _Anim) };
};

