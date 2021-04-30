params ["_AsoundSource"]

//Sound Pitch (Number) - 1: Normal, 0.5: Darth Vader, 2: Chipmunks, etc. Default: 1
_AsoundPitch = 1;

//Volume (Number) Default: 1
_Avolume = 5;

//Number : How far is sound audible (0 = no max distance) Default: 0.
_Adistance =  0;

//Target object (varible name) you want the sound to emmit from Default: player
_ATarget = _AsoundSource;

//Maxiumu random distance (Number) you wish the sound to eminate from
_AMaxDistance = 1000;

//Minimum random distance (Number) you wish the sound to eminate from
_AMinDistance = 600;

//Avrage or Medium random distance (Number) you wish the sound to eminate from
_AMedDistance = 700;

//Minimum time between sounds played (Number)
_AMinWait = 5;

//Avrage or Medium time between sounds played (Number)
_AMedWait = 10;

//Maximum time between sounds played (Number)
_AMaxWait = 15;

_soundsArray = [
"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions1.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions2.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions3.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions4.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_explosions5.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight1.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight2.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight3.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_firefight4.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_heli1.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_heli2.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_heli3.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_jet1.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_jet2.wss",
"A3\Sounds_F\environment\ambient\battlefield\battlefield_jet3.wss"
];

while {true} do
{
	_dir = round random 360;

	_dis = round random [_AMinDistance,_AMedDistance,_AMaxDistance];
	_AsoundPosition = _ATarget getRelPos [_dis, _dir];
	_SoundNumber = round random count _soundsArray;
	_ASound = _soundsArray select _SoundNumber;
	playSound3D [_ASound, _AsoundSource, false, _AsoundPosition, _Avolume, _AsoundPitch, _Adistance];
	_Waitfor = round random [_AMinWait,_AMedWait,_AMaxWait];
	sleep _Waitfor;
};