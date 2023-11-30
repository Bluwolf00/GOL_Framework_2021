 // OKS FINALE
 /*
	[_Side,_Range,_Interval,_StaticUnits?,_ProcentageOfAllUnits] execVM "Scripts\OKS_Dynamic\OKS_FINALE.sqf";
	[_Side,_Range,_Interval,_StaticUnits?,_ProcentageOfAllUnits] spawn OKS_FINALE;

	Make all enemy AI on the map, rush any player within _X meters of the unit when the percentage of alive enemies are below the unit count. If you have 100 enemies and 0.1 as percentage, when there's 10 enemies left, they'll all rush the player. Goes for all units on the entire map, however max range is 5000m for the rush scripts.

 */
Params ["_Side","_Range","_Interval","_StaticUnits","_Percentage"];
private _Rush = false;
private _Debug_Variable = true;
private _EnableAI = {
	Params ["_Group"];
	{
		_X setUnitPos "AUTO";
		_X setUnitPosWeak "UP";
		_X enableAI "PATH";
		_X enableAI "TARGET";
		_X enableAI "MINEDETECTION";
		_X enableAI 'AUTOCOMBAT';
		_X enableAI 'COVER';
		_X leaveVehicle (vehicle _X);
	} foreach units _Group;
};

if(_Debug_Variable) then { systemChat format ["Finale set to %1 of %2",_Percentage,{Alive _X && !isPlayer _X && side _X != [player] call GW_Common_Fnc_getSide} count allUnits]};

waitUntil {Sleep 10; ({Alive _X && !isPlayer _X && side _X != [player] call GW_Common_Fnc_getSide} count allUnits) isNotEqualTo []};
waitUntil {Sleep 30; (({Alive _X && !isPlayer _X && side _X != [player] call GW_Common_Fnc_getSide} count allUnits) / ({!isPlayer _X && side _X != [player] call GW_Common_Fnc_getSide} count allUnits)) <= _Percentage};

 if(!isNil "lambs_wp_fnc_taskRush") then {
	{
		if(side _X isEqualTo _Side && {Alive _X} count units _X > 0) then {
			if((leader _X) getVariable ["gw_common_disableAI_Path",false]) then {
				if(_Debug_Variable) then { systemChat format ["%1 has disabled AI",_X]};

				if(_StaticUnits isEqualTo true) then {
					if(_Debug_Variable) then { systemChat format ["%1 has disabled AI - Static True, EnableAI",_X]};
					_Rush = true;
					[_X] spawn _EnableAI;
				} else {
					if(_Debug_Variable) then { systemChat format ["%1 has disabled AI - Static False",_X]};
					_Rush = false;
				};
			} else {
				_Rush = true;
			};
			if(_Rush isEqualTo true) then {
				[_X, _Range,_Interval,[],[],TRUE] spawn lambs_wp_fnc_taskRush;
			};
		};
	} foreach allGroups;
 };