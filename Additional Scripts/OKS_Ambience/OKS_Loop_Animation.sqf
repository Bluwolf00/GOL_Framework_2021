Params ["_Unit","_Anim"];
//
//  [this,"Acts_PercMstpSlowWrflDnon_handup1b"] execVM "Scripts\OKS_Ambience\OKS_Loop_Animation.sqf";


if (HasInterface && !isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky

_Unit disableAI "MOVE";

while{alive _Unit} do {
	_Unit switchMove _Anim;
	sleep 0.5;
	waitUntil { /*systemChat str [(animationState _Unit),toLower _Anim]; */ ((animationState _Unit) != toLower _Anim) };
};

