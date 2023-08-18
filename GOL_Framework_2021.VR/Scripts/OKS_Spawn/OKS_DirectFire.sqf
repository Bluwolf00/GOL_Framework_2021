
/*
	Created by Oksman from Guerrillas of Liberation

	[arty_1,[getPos target_1,getPos target_2,getPos target_3,getPos target_4],east,1,1,true,true,30,true] execVM "Scripts\OKS_Spawn\OKS_DirectFire.sqf";
	[arty_1,[getPos target_1,getPos target_2,getPos target_3,getPos target_4],east,1,1,true,true,30,true] spawn OKS_DirectFire;
	Parameters
	1 - Object - Artillery Unit
	
	2 - Array - Array of Positions for targeting
	3 - Side - Side of Artillery Unit
	4 - Integer - Rounds Per Position
	5 - Integer - Time between rounds (Some arty has reload time, be aware)
	6 - Bool - Unlimited Ammo for Artillery?
	7 - Bool - Should continue to loop until destroyed
	8 - Integer - Seconds of delay per loop
	9 - Bool - Should mark target with red smoke prior to strike
*/

	Params[
		"_Artillery",
		"_TargetArrayPositions",
		["_Side",east,[sideUnknown]],
		["_RoundsPerTarget",3,[0]],
		["_TimeBetweenRounds",5,[0]],
		["_UnlimitedAmmo",true,[false]],
		["_ShouldLoop",true,[false]],
		["_LoopDelay",120,[0]],
		["_ShouldMark",true,[false]]
	];

	_Artillery setVariable ["acex_headless_blacklist",true,true];
	Private _TargetArray = [];
	{
		// Current result is saved in variable _x
		if(typeName _X == "ARRAY") then {
			_TargetArray pushBack _X;
		};
		if(typeName _X == "STRING") then {
			_TargetArray pushBack (getMarkerPos _X);
		};
		if(typeName _X == "OBJECT") then {
			_TargetArray pushBack (getPos _X);
		};
	} forEach _TargetArrayPositions;

	if(count crew _Artillery == 0) then {
		_crew = [_Artillery,_Side,2] call OKS_AddVehicleCrew;
		{  
			_X disableAI "TARGET";
			_X disableAI "AUTOTARGET";
		} foreach units _crew;
		_crew setVariable ["acex_headless_blacklist",true,true];
	};
	waitUntil {sleep 5; count (crew _Artillery) > 0};
	_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _Artillery)) >> "magazines") select 0);
	_Artillery setVariable ["OKS_ArtyTimeBetweenRounds",_TimeBetweenRounds,true];
	_Artillery setVariable ["OKS_RoundsPerTarget",_RoundsPerTarget,true];
	
	if(_ShouldLoop) then {
		while {alive _Artillery && !(isNull (gunner _Artillery))} do {
			{				
				_Artillery setVariable ["OKS_ArtyFiring",true,true];

				Artillery doTarget _X; sleep 5;				
				_Artillery doFire [currentMuzzle _Artillery,_CfgMagazine,_RoundsPerTarget];

				_Artillery addEventHandler ["Fired",{ 
					params ["_unit"];
					_unit spawn {
						sleep ((_this getVariable ["OKS_ArtyTimeBetweenRounds",2]) * (_this getVariable ["OKS_RoundsPerTarget",1]));
						_this setVariable ["OKS_ArtyFiring",false,true]
					}
				}];
				if(_UnlimitedAmmo) then {
					_Artillery setVehicleAmmo 1;
				};
				waitUntil {!(_Artillery getVariable ["OKS_ArtyFiring",false])};
			} forEach _TargetArray;	
			sleep _LoopDelay;
			enableEngineArtillery false;
		};	
	}/* else {
		{
			if(_X inRangeOfArtillery [[_Artillery], _CfgMagazine]) then {
				_Artillery setVariable ["OKS_ArtyFiring",true,true];
				
				_Artillery doArtilleryFire [_X, _CfgMagazine,_RoundsPerTarget];

				_Artillery addEventHandler ["Fired",{ 
					params ["_unit"];
					_unit spawn {
						sleep ((_this getVariable ["OKS_ArtyTimeBetweenRounds",2]) * (_this getVariable ["OKS_RoundsPerTarget",1]));
						_this setVariable ["OKS_ArtyFiring",false,true]
					}
				}];
				if(_UnlimitedAmmo) then {
					_Artillery setVehicleAmmo 1;
				};
				waitUntil {!(_Artillery getVariable ["OKS_ArtyFiring",false])};
			} else {
				systemChat format ["%1 could not fire at target (Min-Max range): %2",_Artillery,_X];
			};
		} forEach _TargetArray;
		enableEngineArtillery false;
	};

	


	  