/*
How to USE:
Script is dynamic, it should launch as soon as first trigger or mission starts depending on your preference. When the enemy faction knows of the players on the ground, all enemy forces in specified radius will start hunting the players. They will not follow if players are extracted via helicopters or hunt helilcopters on their own. Ground vehicles will be hunted.
Add the Ignore line to the leader of the groups you wish the hunt script to ignore. It will always ignore static units spawned from the framework.

Code to Ignore:
this setVariable ["oks_disable_hunt",true];

Code to Launch:
null = [ENEMYFACTION,MINRANGE,MAXRANGE,REFRESHRATE] execVM "Scripts\OKS_HUNT\Oksman_Dynamic_Hunt.sqf";

Example:
null = [EAST,1000,2000,60] execVM "Scripts\OKS_HUNT\Oksman_Dynamic_Hunt.sqf";

This code is only meant to be run once, put it in your first spawnList case, the first trigger that players will trigger for the mission.

*/


if (!isServer) exitWith {false};	// Ensures only server

OKS_EnemyFaction = _this select 0;
OKS_MinRange = _this select 1;
OKS_MaxRange = _this select 2;
OKS_RefreshRate = _this select 3;

// Day/Night time
_Sunrise = 4.00;											// The time it gets bright enough for smokes to be used instead of flares.																					Number (0.00 - 23.59)
_Sunset = 22.00;											// The time it gets dark enough to start using flares.																										Number (0.00 - 23.59)
_Detection = 4;


if ((dayTime > _Sunrise) and (dayTime < _Sunset)) then {_Detection = 3.85} else {_Detection = 3.90};

oks_hunted = false;
oks_activated=true;
oks_debug=true;
OKS_Detected = false;

publicVariable "OKS_EnemyFaction";
publicVariable "OKS_MinRange";
publicVariable "OKS_MaxRange";
publicVariable "oks_hunted";
publicVariable "oks_activated";
publicVariable "oks_debug";
publicVariable "OKS_Detected";



OKS_Hunt =
{

		//// Find Hunters for Hunting
		params ["_Player","_PlayerArray"];
		_list = _Player nearEntities [["Man", "Car", "Motorcycle", "Tank"], OKS_MinRange];
		_listMax = _Player nearEntities [["Man", "Car", "Motorcycle", "Tank"], OKS_MaxRange];
		_listAir = _Player nearEntities ["Air", OKS_MinRange + OKS_MinRange];

		//// Track Max Range
		_nearenemies = _listMax select {side _X == OKS_EnemyFaction && leader group _X == _X && _X getVariable ["isHunting",false]};
		{

			if (_X getVariable ["isHunting",false]) then
			{
				SystemChat Format["Old %1 - %2",_X,_PlayerArray];
				[_X,_PlayerArray] spawn OKS_Hunting;
				sleep 0.5;
			}

		} foreach _nearenemies;

		_nearenemies = _list select {side _X == OKS_EnemyFaction && leader group _X == _X && !(_X getVariable ["isHunting",false]);};
		{
			//_X setVariable ["isHunting", false];
			if !(_X getVariable ["isHunting",false]) then
			{
				SystemChat Format["New %1",_X];
				_X setVariable ["isHunting", true];
				[_X,_PlayerArray] spawn OKS_Hunting;
				sleep 0.5;
			}

		} foreach _nearenemies;

		_nearAir = _listAir select {side _X == OKS_EnemyFaction && leader group _X == _X;};
		{
			//_X setVariable ["isHunting", false];
			if !(_X getVariable ["isHunting",false]) then
			{

				_X setVariable ["isHunting", true];
				[_X,_PlayerArray] spawn OKS_Hunting;
				sleep 0.5;
			}

		} foreach _nearAir;




};

OKS_Hunting =
{

		/// Create Hunt for Hunter

		params ["_Hunter","_PlayerArray"];

		_sorted = [_PlayerArray,[],{_x distance _Hunter},"ASCEND"] call BIS_fnc_sortBy;
		_nearestPlayer = _sorted select 0;

		{ if(_X getVariable ["ACE_isUnconscious", false]) then{_X setDamage 1;}  } foreach units group _Hunter;
		if(oks_debug) then {hint format ["Target: %2 - %1",_Hunter getVariable["isTracking",false],_nearestPlayer];};

		if ((_Hunter getVariable["isHunting",false]) && !(_Hunter getVariable["isTracking",false])) then
		{
			systemChat format ["%1 Tracking %2",_Hunter,_nearestPlayer];
			null = [_Hunter,_nearestPlayer] spawn OKS_Dynamic_Track;
		};


};

// Run Loop for Radio Chatter - Needs to be in Trigger



while {oks_activated} do
{

	/// Loop to find when targets found
	{ if (side _X == OKS_EnemyFaction) then { _X setVariable ["OKS_Faction",OKS_EnemyFaction]; }} foreach AllUnits;
	_playerHunted = [];
	OKS_Detected = false;

		{
			if ((OKS_EnemyFaction knowsAbout _X > _Detection || OKS_EnemyFaction knowsAbout vehicle _X > _Detection ) && isTouchingGround (vehicle _X))
			then
			{_playerHunted pushBackUnique _X; oks_hunted = true; OKS_Detected = true;
			if(oks_debug) then {systemChat format ["OKS_Hunted true. KnowsAbout: %1",OKS_EnemyFaction knowsAbout _X]; }; sleep 0.5;}

		} foreach (AllPlayers - (Entities "HeadlessClient_F"));



	if (oks_hunted) then
	{

		{
			if (alive _X && !(_x getVariable ["ACE_isUnconscious", false])) then { [_X,_playerHunted] spawn OKS_Hunt; sleep 1;}
		} foreach _playerHunted;

	};
	_null = [OKS_EnemyFaction] spawn OKS_Hunt_Radio;
	sleep OKS_RefreshRate;

};