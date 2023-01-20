
/*
	Created by Oksman from Guerrillas of Liberation

	[arty_3,[getPos target_1,getPos target_2,getPos target_3,getPos target_4],1,1,true] execVM "Scripts\OKS_Ambience\OKS_ArtySupression.sqf";
	[arty_4,[getPos target_5,getPos target_6,getPos target_7,getPos target_8],1,1,true] execVM "Scripts\OKS_Ambience\OKS_ArtySupression.sqf";
	[arty_2,[getPos target_9,getPos target_10,getPos target_11,getPos target_12],1,1,true] execVM "Scripts\OKS_Ambience\OKS_ArtySupression.sqf";
	[arty_1,[getPos target_13,getPos target_14,getPos target_15,getPos target_16],1,1,true] execVM "Scripts\OKS_Ambience\OKS_ArtySupression.sqf";

	Parameters
	1 - Object - Artillery Unit
	2 - Array - Array of Positions for targeting
	3 - Integer - Rounds Per Position
	4 - Integer - Time between rounds (Some arty has reload time, be aware)
	5 - Bool - Unlimited Ammo for Artillery?
*/

	Params["_Artillery","_Side","_TargetArrayPositions","_RoundsPerTarget","_TimeBetweenRounds","_UnlimitedAmmo"];
	_Artillery setVariable ["acex_headless_blacklist",true,true];
	if(count crew _Artillery == 0) then {
		_crew = [_Artillery,_Side,2] call OKS_AddVehicleCrew;
		{  
			_X disableAI "TARGET";
			_X disableAI "AUTOTARGET";
		} foreach units _crew;
		sleep 5;
	};
	_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _Artillery)) >> "magazines") select 0);
	_Artillery setVariable ["OKS_ArtyTimeBetweenRounds",_TimeBetweenRounds,true];
	_Artillery setVariable ["OKS_RoundsPerTarget",_RoundsPerTarget,true];
	enableEngineArtillery true;
	{
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
	} forEach _TargetArrayPositions;
	enableEngineArtillery false;


	  