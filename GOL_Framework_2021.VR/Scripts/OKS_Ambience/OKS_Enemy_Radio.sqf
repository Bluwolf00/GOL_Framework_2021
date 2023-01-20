OKS_EnemyFaction = _this select 0;
// [Independent] spawn OKS_Enemy_Radio;
// [EAST] execVM "Scripts\OKS_Ambience\OKS_Enemy_Radio.sqf";
if (!isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky

OKS_Radios = [];
OKS_Loop_Radio = {

	_Corpse = _this select 0;

	while {!(isNull _Corpse)} do
	{
		RandomNumber = Random 1;
		_AllMen = allDeadMen;
		_EnemyCorpses = _AllMen select {!Alive _X && !isPlayer _X && [_X] call GW_Common_Fnc_getSide == OKS_EnemyFaction && _X isKindOf "Man"};
		_TransmittingCorpses = _EnemyCorpses select {_X getVariable ["OKS_Transmit_Currently",false]};
		_Corpse addEventHandler ["Deleted", {
			params ["_entity"];
			OKS_Radios deleteAt (OKS_Radios find _entity);
		}];

		//systemChat str [count _AllMen,count _EnemyCorpses,count _TransmittingCorpses];
		//systemChat format ["%1 Transmitting in Range of Corpse",{_Corpse distance _X < 20} count _TransmittingCorpses];
		//SystemChat format ["Dead Corpses in Range - %1 - Transmit %2",count _DeadCorpses,count _TransmittingCorpses];

		//systemChat format ["Radio Corpse Check: %1, %2, %3, %4", {_Corpse distance _X < 20} count AllPlayers > 0,{_Corpse distance _X < 20} count _TransmittingCorpses == 0,{OKS_EnemyFaction knowsAbout _X > 2.5} count AllPlayers > 0];
		if( !(isNull _Corpse) && {_Corpse distance _X < 15} count AllPlayers > 0 && {_Corpse distance _X < 30} count _TransmittingCorpses == 0 && {OKS_EnemyFaction knowsAbout _X > 2.5} count AllPlayers > 0) then {

			systemChat "Play Radio";
			_Corpse setVariable ["OKS_Transmit_Currently",true];
			_Sound = selectRandom ["Radio1","Radio2","Radio3","Radio4","Radio5"];
			playSound3D [MISSION_ROOT + format["Scripts\OKS_Ambience\Radio\%1.ogg",_Sound], _Corpse, false, getPosASL _Corpse, 2.5, 1, 12];
			sleep 5+(Random 5);
			_Corpse setVariable ["OKS_Transmit_Currently",false];

			if(Typename _Corpse isEqualType objNull && OKS_Radios isEqualType []) then {
				OKS_Radios = OKS_Radios pushBackUnique _Corpse;
			};
			publicVariable "OKS_Radios";
			sleep 60;
		};		
		sleep 10;
		if({_Corpse distance _X < 300} count AllPlayers == 0) then {
			deleteVehicle _Corpse;
		};
		sleep 1;
	};

};

waitUntil{sleep 5; {_X isKindOf "Man"} count allDeadMen > 0 };
while {true} do {

	if({_X isKindOf "Man"} count allDeadMen == 0) exitWith {false};
	_DeleteCorpses = allDeadMen select {
		_Unit = _X;
		!isPlayer _X &&
		[_X] call GW_Common_Fnc_getSide == OKS_EnemyFaction &&
		_X isKindOf "Man" &&
		{_X distance _Unit < 600} count AllPlayers == 0
	};
	{deleteVehicle _X} foreach _DeleteCorpses;
	_Corpses = allDeadMen select {!isPlayer _X && [_X] call GW_Common_Fnc_getSide == OKS_EnemyFaction && _X isKindOf "Man"};
	SystemChat "EnemyRadio Code Looping..";
		{
			if(!(_X getVariable["OKS_Transmit",false])) then
			{

				if (([_X] call GW_Common_Fnc_getSide) == OKS_EnemyFaction) then {
					_X setVariable ["OKS_Transmit",true];
					_Radio = [_X] spawn OKS_Loop_Radio;
				};
			};
			sleep 1;
		} forEach _Corpses;

		sleep 10;
};


