/*
	[_Group] execVM "Scripts\OKS_Ambience\OKS_Enemy_Talk.sqf";
*/
Params [
	["_Group",grpNull,[grpNull]],
	["_Distance",125,[0]],
	["_Chance",1,[0]],
	["_MinMaxDelayBetweenTalks",[9,14],[[]]],
	["_LoopDelayToCheckNearby",5,[0]],
	["_ShouldTalkAsStaticUnits",true,[true]]
];

if (!isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky

OKS_Enemy_Speak = {

	Params["_Group","_Distance","_Chance","_MinMaxDelayBetweenTalks","_ShouldTalkAsStaticUnits"];
	if(_Group getVariable ["GOL_IsStatic",false] && !(_ShouldTalkAsStaticUnits)) then {SystemChat "Is Static, exiting.."};
	if({Alive _X} count units _Group == 0) exitWith {SystemChat "No units alive, exiting.."};
	if({behaviour _X isEqualTo "COMBAT"} count units _Group > 0) exitWith {SystemChat "Unit in combat, exiting..."};
	if(_Group getVariable ["OKS_Talking_Currently",false]) exitWith {SystemChat "Group already talking, exiting..."};
	if({
			_Unit = _X;
			{_Unit distance _X < _Distance} count AllPlayers > 0
		} count units _Group == 0
	) exitWith {/*SystemChat "No nearby players, exiting..."*/};

	_NearestViableArray = [];
	{
		_InfoArray = [];
		{ 
			if(isPlayer _X) then {
				_Player = _X;
				_InfoArray pushBackUnique _X;
				_UnitsNearby = _X nearEntities ["man", _Distance];
				_EnemyUnitsNearby = _UnitsNearby select {!isPlayer _X && [_X] call GW_Common_Fnc_getSide == side _Group};
				_EnemyUnitsNearby = _EnemyUnitsNearby apply { [_x distance _Player, _x] };
				_EnemyUnitsNearby sort true;
				systemChat str _EnemyUnitsNearby;
				_NearestEnemyUnit = ((_EnemyUnitsNearby select 0) select 1);
				systemChat str _NearestEnemyUnit;
				if(!isNull _NearestEnemyUnit) then {
					_InfoArray pushBackUnique _NearestEnemyUnit;
					_InfoArray pushBackUnique (_Player distance _NearestEnemyUnit);
				};
				_NearestViableArray pushBackUnique _InfoArray;
			}
		} foreach (_X nearEntities ["man", _Distance])
	} foreach units _Group;

	systemChat str _NearestViableArray;
	_Dice = random 1;
	if(_Dice < _Chance) then {
		SystemChat format ["Dice %1 lower than chance %2. Successful trigger...",_Dice,_Chance];
		(_NearestViableArray select 0) Params ["_Player","_Enemy","_Distance"];
		_SoundFileName = selectRandom ["Radio1","Radio2","Radio3","Radio4","Radio5","Radio6","Radio7","Radio8","Radio9","Radio10","Radio11","Radio12","Radio13","Radio14","Radio15","Radio16","Radio17","Radio18","Radio19","Radio20"];
		SystemChat format["Selected SoundFile: %1.ogg",_SoundFileName];
		_Group setVariable ["OKS_Talking_Currently",true,true];
		if(_Distance > 50 || _SoundFileName in ["Radio6","Radio7","Radio8","Radio9","Radio10"]) then {
			playSound3D [MISSION_ROOT + format["Scripts\OKS_Ambience\Radio\%1.ogg",_SoundFileName], _Enemy, false, getPosASL _Enemy, 5, 1, 150];		
		} else {
			playSound3D [MISSION_ROOT + format["Scripts\OKS_Ambience\Radio\%1.ogg",_SoundFileName], _Enemy, false, getPosASL _Enemy, 2.5, 1, 100];		
		};		
	} else {
		SystemChat format ["Dice %1 higher than chance %2. Failed trigger...",_Dice,_Chance];
	};

	if(_SoundFileName in ["Radio6","Radio7","Radio8","Radio9","Radio10"]) then {
		_Delay = round(6 + (random 5));
	} else {
		_MinMaxDelayBetweenTalks Params ["_Min","_Max"];
		_Mid = _Max - _Min;
		_Delay = (_Min + (random _Mid));
	};
	SystemChat format ["Random Delay: %1",_Delay];
	sleep _Delay;
	_Group setVariable ["OKS_Talking_Currently",false,true];
	systemChat "Delay over. Ready to talk... Complete";
};

while { {Alive _X} count units _Group > 0} do {
	[_Group,_Distance,_Chance,_MinMaxDelayBetweenTalks,_ShouldTalkAsStaticUnits] spawn OKS_Enemy_Speak;
	sleep _LoopDelayToCheckNearby;
};
