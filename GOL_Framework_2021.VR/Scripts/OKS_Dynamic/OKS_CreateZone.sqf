
/*
	[TriggerName,SplitTriggerBool,[StaticContacts,PatrolContacts,CreateSectorObjective,LocalPatrols],_Side,NumberOfWheeled,NumberOfAPC,NumberofTank,[CompositionCount,OnlyTarmac],MortarPitCount,[ObjectiveCount,LocalPatrols],[0,0,0,0,0]]
	[Trigger_1,true,[50,25,true,true],EAST,1,1,1,[2,true],1,3] execVM "Scripts\OKS_Dynamic\CreateZone.sqf";

*/

if(!isServer) exitWith {};

Params ["_MainTrigger","_SplitTrigger","_InfantryNumber","_Side","_WheeledCount","_apcCount","_tankCount","_RoadblockArray","_MortarArray","_ObjectiveArray","_HuntbaseArray","_DynamicCivilians"];

Private ["_MainTriggerArea","_Section_N","_Section_E","_Section_S","_Section_W","_MainTriggerSizeA","_MainTriggerSizeB","_MainTriggerAngle","_MainTriggerIsRectangle","_Section_N_Marker","_Section_E_Marker","_Section_S_Marker","_Section_W_Marker","_CountStrongpoints","_GarrisonNumber","_Section_N_Trigger","_Section_E_Trigger","_Section_S_Trigger","_Section_W_Trigger","_marker","_MainMarker","_WheeledPerTrigger","_APCPerTrigger","_TankPerTrigger","_SpawnTriggers","_Configurations","_ZoneEnemyType","_CountInfantryNumber","_UnitTypes","_UnitSelect"];

// ,"_Units","_Leaders","_SideMarker","_SideColor"

Private _Debug_Variable = false;
_SpawnTriggers = [];

_Settings = [_Side] call OKS_Dynamic_Setting;
_Settings Params ["_Units","_SideMarker","_SideColor","_Vehicles","_Civilian","_ObjectiveTypes","_Configurations"];
_Civilian Params ["_CivilianUnits","_HVT","_DynamicCivilianArray"];
_DynamicCivilianArray Params ["_CivilianTriggerSize","_CivilianCount","_HouseWaypoints","_RandomWaypoints","_ShouldBeAgent","_ShouldPanic","_Ethnicity"];
_ObjectiveArray Params ["_Objectives","_ObjectivePatrols"];
_RoadblockArray Params ["_RoadblockCount","_RoadblockTarmac","_RoadblockPatrols","_RoadblockChance"];
_MortarArray Params ["_MortarCount","_MortarPatrol"];
_Configurations Params ["_CompoundSize","_EnableEnemyMarkers","_EnableZoneMarker","_EnableZoneTypeMarker"];

/* Create Sub-Triggers based on the Main trigger */
_MainTriggerArea = triggerArea _MainTrigger;
_MainTriggerSizeA = _MainTriggerArea select 0;
_MainTriggerSizeB = _MainTriggerArea select 1;

_MainTriggerAngle = 0;
_MainTriggerAngle = _MainTriggerArea select 2;
_MainTriggerIsRectangle = _MainTriggerArea select 3;

	_ZoneType = createMarker [format ["oks_ZoneTypeMarker_%1",str round(random 80000 + random 9999)], getPos _MainTrigger];

	if(typeName _InfantryNumber isEqualTo "ARRAY") then {
		_CountInfantryNumber = (_InfantryNumber select 0) + (_InfantryNumber select 1);
	} else {
		_CountInfantryNumber = _InfantryNumber;
	};

	private _SortArray = [_WheeledCount,_APCCount,_TankCount];

	if(!(_SortArray isEqualTo [0,0,0])) then {
		_UnitTypes = [_SortArray, [], {_x}, "DESCEND"] call BIS_fnc_sortBy;
		if(_Debug_Variable) then {
			SystemChat str [_SortArray,_UnitTypes];
		};
		_UnitSelect = _UnitTypes select 0;
		private _ZoneEnemyType = "";

		if({_X > 0} count _UnitTypes > 0 && _EnableZoneTypeMarker && _EnableZoneMarker) then {
			switch(_UnitSelect) do {
				case _WheeledCount: {
					if(_Debug_Variable) then {
						systemChat "Wheeled Majority";
					};
					_ZoneEnemyType = "motorised";
				};
				case _APCCount: {
					if(_Debug_Variable) then {
						systemChat "APC Majority";
					};
					_ZoneEnemyType = "mechanized";
				};
				case _TankCount: {
					if(_Debug_Variable) then {
						systemChat "Tank Majority";
					};
					_ZoneEnemyType = "armor";
				};
				default{
					if(_Debug_Variable) then {
						systemChat "Defaulted to Infantry";
					};
					_ZoneEnemyType = "infantry";
				}
			};
			private _TotalNumber = _CountInfantryNumber + (_WheeledCount * 4) + (_APCCount * 3) + (_TankCount * 3);
			[_ZoneType,_Side,_ZoneEnemyType,_TotalNumber,0.8] spawn OKS_CreateUnitMarker;
		};
	} else {
		if(_EnableEnemyMarkers && _EnableZoneTypeMarker) then {
			[_ZoneType,_Side,"infantry",_CountInfantryNumber,0.8] spawn OKS_CreateUnitMarker;
		};
	};

	_MainMarker = createMarker [format ["oks_MainMarker_%1",str round(random 80000 + random 9999)], getPos _MainTrigger];
	if(_Debug_Variable || _EnableZoneMarker) then {
		_MainMarker setMarkerBrush "Border";
		_MainMarker setMarkerColor _SideColor;
		_MainMarker setMarkerAlpha 0.5;
	} else {
		_MainMarker setMarkerAlpha 0;
	};

	_MainMarker setMarkerDir _MainTriggerAngle;
	_MainMarker setMarkerSize [_MainTriggerSizeA,_MainTriggerSizeB];
	if(!_SplitTrigger) then {
		_SpawnTriggers pushBack _MainTrigger;
	};

	if(_MainTriggerIsRectangle) then {
		_MainMarker setMarkerShape "RECTANGLE";
		if(_SplitTrigger) then {

			_Section_NE_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,45,_MainTriggerAngle,"colorGreen",[0.7,0.5,0.5],"RECTANGLE"] call OKS_CreateMarker;
			_Section_NE_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,45,_MainTriggerAngle,[0.7,0.25,1],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_SE_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,135,_MainTriggerAngle,"colorRed",[0.7,0.5,0.5],"RECTANGLE"] call OKS_CreateMarker;
			_Section_SE_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,135,_MainTriggerAngle,[0.7,0.25,1],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_SW_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,225,_MainTriggerAngle,"colorYellow",[0.7,0.5,0.5],"RECTANGLE"] call OKS_CreateMarker;
			_Section_SW_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,225,_MainTriggerAngle,[0.7,0.25,1],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_NW_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,315,_MainTriggerAngle,"colorBlue",[0.7,0.5,0.5],"RECTANGLE"] call OKS_CreateMarker;
			_Section_NW_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,315,_MainTriggerAngle,[0.7,0.5,0.5],_MainTriggerIsRectangle] call OKS_CreateTrigger;


			_SpawnTriggers pushBack _Section_NE_Trigger;
			_SpawnTriggers pushBack _Section_SE_Trigger;
			_SpawnTriggers pushBack _Section_SW_Trigger;
			_SpawnTriggers pushBack _Section_SW_Trigger;
		};
	} else {
		_MainMarker setMarkerShape "ELLIPSE";
		if(_SplitTrigger) then {

			_Section_NE_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,45,_MainTriggerAngle,"colorGreen",[0.7,0.5,0.5],"ELLIPSE"] call OKS_CreateMarker;
			_Section_NE_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,45,_MainTriggerAngle,[0.7,0.5,0.5],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_SE_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,135,_MainTriggerAngle,"colorRed",[0.7,0.5,0.5],"ELLIPSE"] call OKS_CreateMarker;
			_Section_SE_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,135,_MainTriggerAngle,[0.7,0.5,0.5],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_SW_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,225,_MainTriggerAngle,"colorYellow",[0.7,0.5,0.5],"ELLIPSE"] call OKS_CreateMarker;
			_Section_SW_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,225,_MainTriggerAngle,[0.7,0.5,0.5],_MainTriggerIsRectangle] call OKS_CreateTrigger;

			_Section_NW_Marker = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,315,_MainTriggerAngle,"colorBlue",[0.7,0.5,0.5],"ELLIPSE"] call OKS_CreateMarker;
			_Section_NW_Trigger = [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,315,_MainTriggerAngle,[0.7,0.5,0.5],_MainTriggerIsRectangle] call OKS_CreateTrigger;


			_SpawnTriggers pushBack _Section_NE_Trigger;
			_SpawnTriggers pushBack _Section_SE_Trigger;
			_SpawnTriggers pushBack _Section_SW_Trigger;
			_SpawnTriggers pushBack _Section_SW_Trigger;
		};

	};

		/* Create HuntBase for Main Area */
		if(_HuntbaseArray isNotEqualTo [0,0,0,0,0]) then {
			if(!isNil "NEKY_Hunt_HuntBase" && !isNil "NEKY_Airbase") then {
				[_MainTrigger,_Side,_HuntbaseArray] spawn OKS_Find_HuntBase;
			} else {
				if(_Debug_Variable) then {
					SystemChat format ["Unable to initiate huntbases in %1 - HuntBase or Airbase not defined",_MainTrigger]
				};
			};
			sleep 20;
		};

		/* Create Compositions for Main Area */
		if(_Debug_Variable) then {
			SystemChat format ["Roadblock Count: %1",_RoadblockCount];
		};

		if(_RoadblockCount > 0) then {
			[_MainTrigger,_RoadblockCount,_Side,_RoadblockTarmac,_RoadBlockPatrols,_RoadblockChance] spawn OKS_Find_RoadBlocks;
			sleep 30;
		};

		/* Create Mortar Pits Main Area*/
		if(_Debug_Variable) then {
			SystemChat format ["Mortar Count: %1",_MortarCount];
		};
		if(_MortarCount > 0) then {
			For "_i" to (_MortarCount - 1) do {
				[_MainTrigger,_Side,_MortarPatrol] spawn OKS_Find_Mortars;
				sleep 10;
			};
		};

	private ["_StaticNumber","_PatrolNumber","_Condition","_LocalPatrols","_CreateObjective"];

	if(typeName _InfantryNumber isEqualTo "ARRAY") then {
		_StaticNumber = _InfantryNumber select 0;
		_PatrolNumber = _InfantryNumber select 1;
		_CreateObjective = _InfantryNumber select 2;
		_LocalPatrols = _InfantryNumber select 3;
		_Condition = (_StaticNumber > 0 || _PatrolNumber > 0);
	} else {
		_StaticNumber = _InfantryNumber * 0.5;
		_PatrolNumber = _InfantryNumber * 0.5;
		_LocalPatrols = true;
		_CreateObjective = true;
		_Condition = (_InfantryNumber > 0);
	};

	//SystemChat str [_StaticNumber,_PatrolNumber];
	/* Check if there's Infantry */

	/*
		Populate all Static Weapons in Area
	*/
	if(!isNil "OKS_Populate_StaticWeapons") then {
			[_MainTrigger,objNull,_Side] spawn OKS_Populate_StaticWeapons;
	};

	if(_Condition) then {

		/* Create Infantry Strongpoints Main Area*/

		if(_StaticNumber > 0) then {
			[_MainTrigger,_Side,_StaticNumber,_CreateObjective,_LocalPatrols] spawn OKS_Populate_Strongpoints;
		};
		/* Create Infantry Patrols for each sub-trigger */
		Private ["_PatrolInfantry","_GroupPerTrigger"];
		Private _PatrolSize = 4;
		if(_Side isEqualTo civilian) then {
			_PatrolSize = 1;
		};

		//_PatrolInfantry = round(_InfantryNumber * 0.5);
		_PatrolCount = _PatrolNumber / _PatrolSize;
		_GroupPerTrigger = round(_PatrolCount / (count _SpawnTriggers));

		if(_Debug_Variable) then {
			SystemChat format ["Patrols Total %1 x %4 - Per Trigger %2 of %3",_PatrolCount,_GroupPerTrigger,_PatrolNumber,_PatrolSize];
		};
		if(_PatrolNumber > 0) then {
			for "_i" to (_GroupPerTrigger - 1) do {
				{[_X,_PatrolSize,_MainTriggerSizeA * 0.5,_Side] spawn OKS_Patrol_Spawn; sleep 10;} foreach _SpawnTriggers
			};
		};
		sleep 20;
	};

	/* Create Objectives Main Area */
	if(_Debug_Variable) then {
		SystemChat format ["Objective Count: %1",_Objectives];
	};
	if(_Objectives > 0) then {
		Private ["_RandomObjective"];
		For "_i" to (_Objectives - 1) do {
			_RandomObjective = selectRandom _ObjectiveTypes;
			[_MainTrigger,_RandomObjective,300,_Side,_ObjectivePatrols] spawn OKS_CreateObjectives;
			sleep 15;
		};
	};

	/* Create Vehicle Patrols for each sub-trigger */
	if(_Debug_Variable) then {
		SystemChat format ["Total %1 Wheeled",_WheeledCount];
	};
	if(_WheeledCount > 0 ) then {
		_WheeledPerTrigger = round(_WheeledCount / (count _SpawnTriggers));
		if(_Debug_Variable) then {
			SystemChat format ["Wheeled Per Trigger: %1",_WheeledPerTrigger];
		};
		if (_WheeledPerTrigger isEqualTo 0) then { _WheeledPerTrigger = 1 };
		{[_X,_WheeledPerTrigger,_MainTriggerSizeA,"WHEELED",_Side] spawn OKS_Vehicle_Patrol; sleep 25;} foreach _SpawnTriggers;
		sleep (_WheeledCount * 5);
	};
	if(_Debug_Variable) then {
		SystemChat format ["Total %1 APC",_apcCount];
	};
	if(_APCCount > 0 ) then {
		_APCPerTrigger = round(_apcCount / (count _SpawnTriggers));
		if(_Debug_Variable) then {
			SystemChat format ["APC Per Trigger: %1",_APCPerTrigger];
		};
		if (_APCPerTrigger isEqualTo 0) then { _APCPerTrigger = 1 };
		{[_X,_APCPerTrigger,_MainTriggerSizeA,"APC",_Side] spawn OKS_Vehicle_Patrol; sleep 25;} foreach _SpawnTriggers;
		sleep (_APCCount * 5);
	};
	if(_Debug_Variable) then {
		SystemChat format ["Total %1 Tank",_TankCount];
	};
	if(_TankCount > 0 ) then {

		_TankPerTrigger = round(_tankCount / (count _SpawnTriggers));
		if(_Debug_Variable) then {
			SystemChat format ["Tank Per Trigger: %1",_TankPerTrigger];
		};
		if (_TankPerTrigger isEqualTo 0) then { _TankPerTrigger = 1 };
		{[_X,_TankPerTrigger,_MainTriggerSizeA,"TANK",_Side] spawn OKS_Vehicle_Patrol; sleep 25;} foreach _SpawnTriggers;
		sleep (_TankCount * 5);
	};

	/* Spawn Dynamic Civilians */
	_VillagesInTrigger = OKS_Villages select {_X inArea _MainTrigger};
	if(_Debug_Variable) then {
		systemChat format ["Villages %1",count _VillagesInTrigger];
	};
	if(count _VillagesInTrigger > 0 && _DynamicCivilians) then {
		{
			_trg = createTrigger ["EmptyDetector", _X, true];
			_trg setTriggerArea [(_CivilianTriggerSize),(_CivilianTriggerSize), 0, false];
			[_trg,_CivilianCount,_HouseWaypoints,_RandomWaypoints,_ShouldBeAgent,_ShouldPanic,_Ethnicity] spawn OKS_Civilians;
			sleep 10;
		} foreach _VillagesInTrigger;
	};



