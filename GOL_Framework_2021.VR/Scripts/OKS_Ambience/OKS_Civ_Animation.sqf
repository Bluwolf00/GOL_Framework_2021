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


/*

OKS_Loop_Radio = {

	_Corpse = _this select 0;

	while {!(isNull _Corpse)} do
	{
		RandomNumber = Random 1;
		_AllMen = allDeadMen;
		_EnemyCorpses = _AllMen select {!Alive _X && !isPlayer _X && [_X] call GW_Common_Fnc_getSide == OKS_EnemyFaction};
		_TransmittingCorpses = _EnemyCorpses select {_X getVariable ["OKS_Transmit_Currently",false]};

		//systemChat str [count _AllMen,count _EnemyCorpses,count _TransmittingCorpses];
		//systemChat format ["%1 Transmitting in Range of Corpse",{_Corpse distance _X < 20} count _TransmittingCorpses];
		//SystemChat format ["Dead Corpses in Range - %1 - Transmit %2",count _DeadCorpses,count _TransmittingCorpses];
		if( {_Corpse distance _X < 20} count AllPlayers > 0 && {_Corpse distance _X < 20} count _TransmittingCorpses == 0) then {

			//systemChat "Play Radio";
			_Corpse setVariable ["OKS_Transmit_Currently",true];
			playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Radio\Radio1.ogg", _Corpse, false, getPosASL _Corpse, 2.5, 1, 14];
			sleep 30+(Random 90);

			playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Radio\Radio2.ogg", _Corpse, false, getPosASL _Corpse, 2.5, 1, 14];
			sleep 30+(Random 90);

			playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Radio\Radio3.ogg", _Corpse, false, getPosASL _Corpse, 2.5, 1, 14];
			sleep 30+(Random 90);

			playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Radio\Radio4.ogg", _Corpse, false, getPosASL _Corpse, 2.5, 1, 14];
			sleep 30+(Random 90);

			playSound3D [MISSION_ROOT + "Scripts\OKS_Ambience\Radio\Radio5.ogg", _Corpse, false, getPosASL _Corpse, 2.5, 1, 14];
			_Corpse setVariable ["OKS_Transmit_Currently",false];
			_Corpse pushBackUnique OKS_Radios;
			publicVariable "OKS_Radios";
			sleep 90;
		};

		sleep 20;

	};

};


	while {true} do {

	//SystemChat "Radio Code Started";
		{
			if(!(_X getVariable["OKS_Transmit",false])) then
			{

				if (([_X] call GW_Common_Fnc_getSide) == OKS_EnemyFaction) then {
					_X setVariable ["OKS_Transmit",true];
					_Radio = [_X] spawn OKS_Loop_Radio;
					};
			};
			sleep 1;
		} forEach allDeadMen;

		sleep 30;
};


