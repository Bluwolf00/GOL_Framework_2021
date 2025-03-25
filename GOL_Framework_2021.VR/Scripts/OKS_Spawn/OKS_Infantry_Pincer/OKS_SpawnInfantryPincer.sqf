/*

	OKS_SpawnInfantryPincer

	[attack_1,east,[8,8,10,10],1500,-1,90,250,10,100] spawn OKS_SpawnInfantryPincer;
	[attack_1,east,[8,8,10,10],1500,-1,90,100,10,100] execvm "Scripts\OKS_Spawn\OKS_SpawnInfantryPincer.sqf";

	Param 1: SpawnObject (Face it towards suspected player positions)
	Param 2: Side of Enemy
	Param 3: Enemy Numbers Array [BaseOfFire 1,BaseOfFire 2,Left Flank, Right Flank]
	Param 4: Range to check for players (if no players are found, the script will waitUntil players are found)
	Param 5: KnowsAbout Value (0-4: How much the enemy faction needs to know about us to activate)
	Param 6: Flanking Angle in Degrees (Left and Right)
	Param 7: Flanking Distance in Meters (Distance from Player, paired with angle to give flanking waypoint)
	Param 8: Base of Fire Angle (Angle of attack for the base of fireteams, increase to spread out the base of fire teams)
	Param 9: Flanking Spawn Spread (Flankers spawn distance from center)

*/

	if(!isServer) exitWith {};

	Params [
		"_SpawnPosition",
		["_Side",east,[sideUnknown]],
		["_NumbersArray",[10,10,10],[[]]],
		["_Range",1500,[0]],
		["_KnowsAboutLimit",-1,[0]],
		["_FlankAngle",45,[0]],
		["_FlankingDistance",-1,[0]],
		["_BaseOfFireAngle",15,[0]],
		["_FlankingSpawnSpread",50,[0]]
	];
	_NumbersArray Params ["_FrontNumbers","_FrontNumbers2","_LeftNumbers","_RightNumbers"];
	_Settings = [_Side] Call OKS_Dynamic_Setting;
	_Settings Params ["_Units"];

	OKS_SpawnInfantrySquad = {
		Params [
			"_SpawnPosition",
			"_Units",
			"_Numbers",
			["_IsBaseOfFire",false,[false]],
			["_SpawnAngle",nil,[0]],
			["_SpawnDistance",0,[0]]
		];
		_Units Params ["_Leaders","_Units","_Officer"];
		Private ["_Unit","_Group","_SelectedUnits","_SelectedSpawnPosition","_SpawnDistance"];

		if(_IsBaseOfFire) then {
			_SelectedSpawnPosition = _SpawnPosition;
		} else {
			_BaseDir = getDir _SpawnPosition;
			_SelectedSpawnPosition = _SpawnPosition getPos [_SpawnDistance, (_BaseDir + _SpawnAngle)];
		};

		_Group = CreateGroup _Side;
		for "_i" from 1 to _Numbers do {					
			if ((count (units _Group)) == 0) then
			{
				_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _SelectedSpawnPosition, [], 5, "NONE"];
				_Unit setRank "SERGEANT";
			} else {

				if(_i % 2 == 0 && _IsBaseOfFire) then {
					_SelectedUnits = _Units select {					
						["heavygunner", _X] call BIS_fnc_inString || ["ar", _X] call BIS_fnc_inString  
					};
				} else {
					_SelectedUnits = _Units;
				};

				_Unit = _Group CreateUnit [(_SelectedUnits call BIS_FNC_selectRandom), _SelectedSpawnPosition, [], 5, "NONE"];
				_Unit setRank "PRIVATE";
			};
			_Unit setRank "PRIVATE";	
		};

		_Group
	};

	OKS_FlankingMovement = {
		Params ["_Group","_SpawnPosition","_SelectedPlayerTarget","_FlankAngle","_FlankingDistance"];

		if(_FlankingDistance == -1) then {
			_FlankingDistance = ((_SelectedPlayerTarget distance _SpawnPosition) * 0.6);
		};

		//systemChat str _FlankingDistance;
		_FlankPosition = _SelectedPlayerTarget getPos [_FlankingDistance,((_SelectedPlayerTarget getDir _SpawnPosition) + _FlankAngle)];
		_FlankWP = _Group addWaypoint [_FlankPosition,5];
		_FlankWP setWaypointType "MOVE";
		_FlankTargetWP = _Group addWaypoint [getPos _SelectedPlayerTarget,5];
		_FlankTargetWP setWaypointType "MOVE";
		
		{
			[_X,_FlankPosition,_SelectedPlayerTarget,_Group] spawn {
				Params ["_Unit","_FlankPosition","_SelectedPlayerTarget","_Group"];
				
				_Unit disableAI "FSM"; _Unit enableAttack false; _Unit forceSpeed 10; _Unit disableAI "COVER";
				[_Unit, _FlankPosition] spawn lambs_wp_fnc_taskAssault;

				waitUntil {sleep 2; _Unit distance _FlankPosition < 20};

				if(!(_Group getVariable ["FlankingRushActive",false])) then {
					_Group setVariable ["FlankingRushActive",true,true];
				};
			};
		} foreach units _Group;
		waitUntil {sleep 5; _Group getVariable ["FlankingRushActive",false]};
		[_Group,1000,10,[],[],false] remoteExec ["lambs_wp_fnc_taskRush",0];		
	};	

	OKS_SuppressiveFireMovement = {
		Params ["_Group","_KnowsAboutLimit","_SelectedPlayerTarget","_SpawnPosition","_BaseOfFireAngle"];

		_FrontStepWP = _Group addWaypoint [_SelectedPlayerTarget getPos [((_SelectedPlayerTarget distance _SpawnPosition) * 0.5),((_SelectedPlayerTarget getDir _SpawnPosition) + _BaseOfFireAngle)],10];
		_FrontStepWP setWaypointType "MOVE";
		_FrontWP = _Group addWaypoint [getPos _SelectedPlayerTarget,25];
		_FrontWP setWaypointType "SAD";

		{		
			[_X,_KnowsAboutLimit] spawn {
				Params ["_aiUnit","_KnowsAboutLimit"];

				while {alive _aiUnit || [_aiUnit] call ace_common_fnc_isAwake} do {
					private ["_AvailableTargets"];
					waitUntil{
						sleep 5;
						_AvailableTargets = (_aiUnit targets [true]) select {
							[objNull, "VIEW"] checkVisibility [eyePos _aiUnit, eyePos _X] >= 0.4 && _aiUnit knowsAbout _X > _KnowsAboutLimit
						};
						//systemChat str [name _aiUnit, _AvailableTargets];
						count _AvailableTargets > 0 || (!alive _aiUnit || !([_aiUnit] call ace_common_fnc_isAwake))
					};

					if(!alive _aiUnit && !([_aiUnit] call ace_common_fnc_isAwake)) exitWith { /* systemChat "Killed or Unconscious."*/};

					_Target = selectRandom _AvailableTargets;

					if(!isNil "_Target") then { continue };
					_aiUnit doSuppressiveFire _Target;
					//systemChat format ["%1 is suppressing %2",name _aiUnit,name _Target];

					sleep 15;
				};
			}
		} foreach units _Group;
	};

	if(_knowsAboutLimit > 0) then {
		waitUntil {
			sleep 10;
			count (AllPlayers select {isTouchingGround (vehicle _X) && _Side knowsAbout _X > _KnowsAboutLimit && _X distance _SpawnPosition < _Range}) > 0;
		};
	};

	// Randomly Selected Player Target
	_SelectedPlayerTarget = selectRandom (AllPlayers select {isTouchingGround (vehicle _X) && _Side knowsAbout _X > _KnowsAboutLimit && _X distance _SpawnPosition < _Range});

	// Front Group 1
	[[_SpawnPosition,_Units,_FrontNumbers,true] call OKS_SpawnInfantrySquad,_KnowsAboutLimit,_SelectedPlayerTarget,_SpawnPosition,(_BaseOfFireAngle * -1)] spawn OKS_SuppressiveFireMovement;

	// Front Group 2
	[[_SpawnPosition,_Units,_FrontNumbers2,true] call OKS_SpawnInfantrySquad,_KnowsAboutLimit,_SelectedPlayerTarget,_SpawnPosition,(_BaseOfFireAngle * 1)] spawn OKS_SuppressiveFireMovement;

	// Left Group	
	[[_SpawnPosition,_Units,_LeftNumbers,false,(-90),_FlankingSpawnSpread] call OKS_SpawnInfantrySquad,_SpawnPosition,_SelectedPlayerTarget,(_FlankAngle * 1),_FlankingDistance] spawn OKS_FlankingMovement;

	// Right Group
	[[_SpawnPosition,_Units,_RightNumbers,false,(90),_FlankingSpawnSpread] call OKS_SpawnInfantrySquad,_SpawnPosition,_SelectedPlayerTarget,(_FlankAngle * -1),_FlankingDistance] spawn OKS_FlankingMovement;
