// [alarm_1,1500] execVM "Script\OKS_Ambience\OKS_AlarmSound.sqf";

Params ["_Origin","_Distance"];

if(!isServer) exitWith {false};

while {alive _Origin || !isNull _Origin} do {
	SystemChat "Playing Alarm Sound";
	playSound3D ["16aa_immersion_sounds\Misc\Alarm\zeus_sound_AlarmOpenAir.ogg", _Origin, false, getPosASL _Origin, 5, 1, _Distance];
	sleep 80;
};
