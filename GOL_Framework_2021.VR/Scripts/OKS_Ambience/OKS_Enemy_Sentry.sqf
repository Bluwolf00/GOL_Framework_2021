/*
	OKS_Enemy_Sentry
	[this, east, 0.3,true,true, 1000, 500, Hunt_1] spawn OKS_Enemy_Sentry;
	[Unit or Position, Side, ChanceForRadioGear, RequiresRadioToCallHunt, ShouldStartHunt, RangeFromUnitFindHunters, HuntersRange, VariableToSetToTrue] execVM "Scripts\OKS_Ambience\OKS_Enemy_Sentry.sqf";
*/

 	if(!isServer) exitWith {};

	Params ["_Unit","_Side","_ChanceForRadioEquipment","_RequiresRadioToCallHunt","_ShouldSetNearbyToHunt","_NearbyHunterRange","_HuntRange","_Variable"];
	Private ["_Units","_Dice","_Leader","_NearFriendlies","_RadioNearby"];
	Switch (_Side) do
	{
		case blufor:	// BLUFOR settings
		{
			_Leader = "B_soldier_SL_F";
			_Units = [
				"B_Soldier_A_F",
				"B_Soldier_AR_F",
				"B_Soldier_AR_F",
				"B_medic_F",
				"B_medic_F",
				"B_Soldier_GL_F",
				"B_HeavyGunner_F",
				"B_soldier_M_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_LAT_F"
			];
		};
		case opfor:	// BLUFOR settings
		{
			_Leader = "O_soldier_SL_F";
			_Units = [
				"O_Soldier_A_F",
				"O_Soldier_AR_F",
				"O_Soldier_AR_F",
				"O_medic_F",
				"O_medic_F",
				"O_Soldier_GL_F",
				"O_HeavyGunner_F",
				"O_soldier_M_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_LAT_F"
			];
		};
		case independent:	// BLUFOR settings
		{
			_Leader = "I_soldier_SL_F";
			_Units = [
				"I_Soldier_A_F",
				"I_Soldier_AR_F",
				"I_Soldier_AR_F",
				"I_medic_F",
				"I_medic_F",
				"I_Soldier_GL_F",
				"I_HeavyGunner_F",
				"I_soldier_M_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_LAT_F"
			];
		};
		// DO NOT EDIT ANYTHING BELOW \\
		default
		{
			_Units = "";
		};
	};

	if(typeName _Unit isEqualTo "ARRAY") then {
		_Pos = _Unit;
		_UnitClass = selectRandom _Units;
		_Group = CreateGroup _Side;

		_Dice = random 1;
		if(_Dice < _ChanceForRadioEquipment && _RequiresRadioToCallHunt) then {
			_Unit = _Group CreateUnit [_Leader, _Pos, [], 0, "NONE"];
			_Unit setVariable ["GOL_HasRadio",true,true];
		} else {
			_Unit = _Group CreateUnit [_UnitClass, _Pos, [], 0, "NONE"];	
		};		
        _Unit setRank "PRIVATE";
		_Unit setDir (random 360);
	} else {
		if(typeOf _Unit == _Leader) then {
			_Unit setVariable ["GOL_HasRadio",true,true];
			SystemChat "Is Squad Leader giving Radio Variable.";
		};	
	};

	group _Unit setVariable ["GOL_IsStatic",true,true];
	group _Unit setVariable ["acex_headless_blacklist",true,true];

	if(count waypoints _Unit <= 1) then {
		_Unit disableAI "PATH";
	};	
	_Unit setUnitPos "UP";

	waitUntil {sleep 2; {_Unit knowsAbout _X > 3.99} count AllPlayers > 0};
	systemChat "Detected player..";

	if(Alive _Unit && [_Unit] call ace_common_fnc_isAwake) then {
		_SoundFileName = selectRandom ["vn-talks-y-07","vn-talks-y-08","vn-talks-y-09","vn-talks-y-20","vn-talks-y-26","vn-talks-y-17"];
		playSound3D [MISSION_ROOT + format["Scripts\OKS_Ambience\Talk\%1.ogg",_SoundFileName], _Unit, false, getPosASL _Unit, 5, 1, 150];	
	};
	sleep 5;
	if(Alive _Unit && [_Unit] call ace_common_fnc_isAwake) then {
		_RadioNearby = false;	
		if(_RequiresRadioToCallHunt && !(_Unit getVariable ["GOL_HasRadio",false])) then {
			_NearFriendliesWithRadio = (_Unit nearEntities ["Man",300]) select {!isPlayer _X && side _X == _Side && (_X getVariable ["GOL_HasRadio",false] isEqualTo true) && Alive _X && [_X] call ace_common_fnc_isAwake};
			_RadioNearby = count _NearFriendliesWithRadio > 0;
		};
		if(_RequiresRadioToCallHunt && !(_Unit getVariable ["GOL_HasRadio",false]) && !(_RadioNearby)) exitWith { SystemChat "Requires Radio In vicinity to request reinforcements. Exiting.."};
		systemChat "Radio Nearby or In-hand. Calling hunt.";	
		_SoundFileName = selectRandom ["vn-radio-y-17","vn-radio-y-18","vn-radio-y-19","vn-radio-y-09","vn-radio-y-05"];
		playSound3D [MISSION_ROOT + format["Scripts\OKS_Ambience\Talk\%1.ogg",_SoundFileName], _Unit, false, getPosASL _Unit, 5, 1, 150];	
		if(!isNil "_Variable") then {
			SystemChat format ["%1 set to true",_Variable];
			Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
		};

		if(_ShouldSetNearbyToHunt isEqualType _Side) exitWith { SystemChat format["Broken variables for unit: %1. Exiting..",_Unit] };
		if (!(isNil "lambs_wp_fnc_taskHunt") && _ShouldSetNearbyToHunt) then {
			
			_EnemyGroups = [];
			{ if (side _X == [_Unit] call GW_Common_Fnc_getSide && leader _X distance2d _Unit < _NearbyHunterRange) then {_EnemyGroups pushBackUnique _X}} foreach AllGroups;
			/* 
				* Arguments:
				* 0: Group performing action, either unit <OBJECT> or group <GROUP>
				* 1: Range of tracking, default is 500 meters <NUMBER>
				* 2: Delay of cycle, default 15 seconds <NUMBER>
				* 3: Area the AI Camps in, default [] <ARRAY>
				* 4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
				* 5: Only Players, default true <BOOL>
				* 6: enable dynamic reinforcement <BOOL>
				* 7: Enable Flare <BOOL> or <NUMBER> where 0 disabled, 1 enabled (if Units cant fire it them self a flare is created via createVehicle), 2 Only if Units can Fire UGL them self
			*/	
			{
				if(!(_X getVariable ["LAMBS_HUNTING",false]) && !(_X getVariable ["GOL_IsStatic",false]) ) then {
					_X setVariable ["LAMBS_HUNTING",true,true];
					_X setBehaviour "AWARE";
					_X setSpeedMode "FULL";
					{[_X,"FSM"] remoteExec ["disableAI",0]} foreach units _X;
					[_X, _HuntRange, 15, [], getPos _Unit, true,false,true] remoteExec ["lambs_wp_fnc_taskHunt",0];
				};		
			} foreach _EnemyGroups;
		}

	};