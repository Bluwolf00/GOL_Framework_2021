
///// _null = [east,ArtyName,TargetObject,RoundsFired,RearmTime,ReloadTime] spawn OKS_ArtyFire;
//// _null = [east,this,getMarkerPos "respawn_west",7,300,30] spawn OKS_ArtyFire;
/*
	[east,this,getMarkerPos "respawn_west",10,300,30] execVM "Scripts\OKS_Spawn\OKS_ArtyFire.sqf";
*/


if(HasInterface && !isServer) exitWith {false};

if (!HasInterface || isServer) then
{

	OKS_CHECK_TRAVEL = {

		_Debug = 0;
		Params["_Projectile","_Launcher"];

		_TargetPos = _Launcher getVariable ["OKS_Arty_Target",false];		
		WaitUntil {sleep 1; (_Projectile distance2D _Launcher > 2000 || _Projectile distance2D _TargetPos < 500)};
		if(_Debug == 1) then {
			systemChat format["Deleted Projectile - Away from Tube: %2 - Near Target: %3",_Projectile distance2D _Launcher,_Projectile distance2D _Launcher > 1000,_Projectile distance2D _TargetPos < 500];
		};
		deleteVehicle _Projectile;
	};

		params[
			["_side",east,[sideUnknown]],
			["_arty",objNull,[objNull]],
			["_target",[0,0,0],[[]]],
			["_rof",5,[0]],
			["_time",60,[0]],
			["_reload",300,[0]],
			["_FullCrew",false,[false]]
		];
		private ["_gunner","_cargo","_commander","_CfgMagazine","_Debug","_Range","_displayName","_gunner_group"];
		_displayName = getText (configfile >> "CfgVehicles" >> (typeOf _arty) >> "displayName");

		_Debug = 0;

		if (_Debug == 1) then {SystemChat "Start"};
		[_arty,true] remoteExec ["enableSimulation",0];
		[_arty,true] remoteExec ["allowDamage",0];
		_gunner = gunner _arty;

		//// Reset Ammo
		_arty setVehicleAmmo 0;
		_arty setVehicleAmmo 1;

		if (!alive gunner _arty) then {
			if (_Debug == 1) then {SystemChat format ["%1",_side]};
			/// Initiation
			switch (_side) do
			{
				case blufor:
				{
					if (_Debug == 1) then {SystemChat "Selected West"};
					_gunner_group = createGroup west;
					_gunner_group setVariable ["acex_headless_blacklist",true, true];
					_gunner = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];

					/// Add Commander if seat has Weapon
					if(_FullCrew) then {
						if(_arty emptyPositions "commander" > 0) then {
							if(weaponState [_arty,[0,0]] select 0 != "") then {
								_commander = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];
							};
						};
						if(_arty emptyPositions "cargo" > 0) then {
							_cargo = _gunner_group createUnit ["B_Soldier_F",[0,0,10], [], 0, "FORM"];	
						};		
					};			
				};

				case opfor:
				{
					if (_Debug == 1) then {SystemChat "Selected East"};
					_gunner_group = createGroup east;
					_gunner_group setVariable ["acex_headless_blacklist",true, true];
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];

					/// Add Commander if seat has Weapon
					if(_FullCrew) then {
						if(_arty emptyPositions "commander" > 0) then {
							if(weaponState [_arty,[0,0]] select 0 != "") then {
								_commander = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];
							};
						};	
						if(_arty emptyPositions "cargo" > 0) then {
							_cargo = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];	
						};
					};
				};

				case independent:
				{
					if (_Debug == 1) then {SystemChat "Selected Independent"};
					_gunner_group = createGroup independent;
					_gunner_group setVariable ["acex_headless_blacklist",true, true];
					_gunner = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];

					/// Add Commander if seat has Weapon
					if(_FullCrew) then {	
						if(_arty emptyPositions "commander" > 0) then {
							if(weaponState [_arty,[0,0]] select 0 != "") then {
								_commander = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];
							};
						};		
						if(_arty emptyPositions "cargo" > 0) then {
							_cargo = _gunner_group createUnit ["I_Soldier_F",[0,0,10], [], 0, "FORM"];	
						};	
					};							
				};

				default
				{
					if (_Debug == 1) then {SystemChat "Selected Default"};
					_gunner_group = createGroup east;
					_gunner = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];

					/// Add Commander if seat has Weapon
					if(_FullCrew) then {

						if(_arty emptyPositions "commander" > 0) then {
							if(weaponState [_arty,[0,0]] select 0 != "") then {
								_commander = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];
							};
						};	
						if(_arty emptyPositions "cargo" > 0) then {
							_cargo = _gunner_group createUnit ["O_Soldier_F",[0,0,10], [], 0, "FORM"];	
						};				
					};
				};
			};
		} else {
			_gunner_group = (group gunner _arty);
		};
	sleep 1;
	{
		_X setBehaviour "AWARE";
		_X setCombatMode "BLUE";
		_X disableAI "TARGET";
		_X disableAI "AUTOTARGET";
		_X setVariable ["oks_disable_hunt",true];
		_X remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
	} foreach units _gunner_group;

	_gunner moveInGunner _arty;
	if(!isNil "_commander") then {
		_commander moveInCommander _arty;
		_commander setCombatMode "YELLOW";
		_X enableAI "TARGET";
		_X enableAI "AUTOTARGET";
	};
	if(!isNil "_cargo") then {
		_cargo moveInCargo _arty;
	};

	waitUntil {sleep 1; !(isNull _gunner)};

	/*if(["d30",typeOf _arty] call BIS_fnc_inString) then {
		_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _arty)) >> "magazines") select 1);
	} else {
		_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _arty)) >> "magazines") select 0);
	};
	*/
	Private _FoundTarget = false;
	Private _Selection = 0;
	Private _SelectionMax = count (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _arty)) >> "magazines"));
	Private _MarkerArray = [];
	_Range = 0;

    while {_Selection < _SelectionMax} do {
    	_Range = 0;
		_CfgMagazine = (getArray (configFile >> "CfgWeapons" >> (currentMuzzle (gunner _arty)) >> "magazines") select _Selection);
		if(isNil "_CfgMagazine") then { _CfgMagazine = ""};
	    if(_Debug == 1) then {
			systemChat str [_CfgMagazine,_SelectionMax,_target];
	    };
		Private _Dir = _arty getDir _target;
		if(typeName _target == "OBJECT") then {
			_target = getPos _target;
		};
		if (!(_CfgMagazine isEqualTo "") && !(_target inRangeOfArtillery [[_arty], _CfgMagazine])) then {
			if (_Debug == 1) then {SystemChat "Artillery not in range.."};
			_Range = 750;
			while {_Range <= 15000} do {
				_Range = _Range + 250;
				_target = _arty getPos [_Range,_Dir];
				if (_Debug == 1) then {
					//SystemChat format["Arty Pos: %1 with %2",_target,_CfgMagazine];
					_marker = createMarker [format ["oks_ArtyDebugMarker_%1",str round(random 80000 + random 9999)],_target];
					_marker setMarkerSize [0.3,0.3];
					_marker setMarkerShape "ICON";
					_marker setMarkerType "hd_dot";
					_marker setMarkerText format ["%1",_Selection];
					_MarkerArray pushBack _marker;
				};

				//SystemChat format ["%1 is in Range",_target inRangeOfArtillery [[_arty], _CfgMagazine]];
				if(_target inRangeOfArtillery [[_arty], _CfgMagazine]) exitWith { _FoundTarget = true; if (_Debug == 1) then {SystemChat format["%3 %2 in range: %1",_Range,_CfgMagazine,_displayName]}};
			};
		} else { if(true) exitWith { _FoundTarget = true; if (_Debug == 1) then {SystemChat format["%3 %2 in range of %1",_Target,_CfgMagazine,_displayName]}}};

		_Selection = _Selection + 1;
		if( !(_FoundTarget) ) then {{deleteMarker _X} foreach _MarkerArray;};
		_MarkerArray = [];
		if(_Selection >= _SelectionMax || _FoundTarget) then {break};
		sleep 0.5;
    };

	if(_Range >= 15000 || !(_FoundTarget) && _Selection > _SelectionMax) exitWith { if (_Debug == 1) then { SystemChat Format ["Unable to fire at target. _Range: %1, _FoundTarget: %2, _Selection: %3",_Range >= 15000,!(_FoundTarget),_Selection > _SelectionMax]}};

	/*
	if (_Debug == 1) then {SystemChat "Starting Watch and Interval"};

	if(typeName _target == "OBJECT") then {
		_arty reveal _target;
		_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
	};

	if(typeName _target == "ARRAY") then {
		_arty doWatch [_target select 0,_target select 1,_angle];
		_target = createVehicle ["ClutterCutter_small_2_EP1", _target, [], 0, "NONE"];
	};

	sleep (10+(Random 20));

		_gunner disableAI "WEAPONAIM";
		_gunner setBehaviour "AWARE";
		_gunner setCombatMode "BLUE";
	*/

	if (_Debug == 1) then {SystemChat "Disable AI"};
	_arty addEventHandler ["Fired",{ [(_this select 6),(_this select 0)] remoteExec ["OKS_CHECK_TRAVEL",0]}];
	_arty spawn {
		waitUntil{sleep 5; { _X distance2d _this < 30 && (side _this) getFriend (side _X) < 0.5} count AllPlayers > 0};
		systemChat "Enemy Players nearby, exiting artillery..";
		{ _X enableAI "TARGET"; _X enableAI "AUTOTARGET"; unassignVehicle _X; (group _X) leaveVehicle (vehicle _X)} foreach crew _this;
	};
	/// While Arty is not destroyed - Continue the loop
	while {Alive _arty && !isNull gunner _arty} do
	{
		/*
		if(_this select 4 > 0) then { sleep _rof; } else { sleep 5; };
		*/

		if(Alive gunner _arty && (side (gunner _arty) isEqualTo _side)) then {
			/*
			_arty fireAtTarget [_target];
	        _arty action ["UseWeapon", _arty, (gunner _arty), 0];
	        */
    		_gunner disableAI "TARGET";
			_gunner disableAI "AUTOTARGET";
			_gunner setCombatMode "YELLOW";
			_gunner remoteExec ["GW_SetDifficulty_fnc_setSkill",0];
			sleep 1;
	        if(_Debug == 1) then {
        		systemChat "Firing Artillery..";
	        };
	        _arty setVariable ["OKS_Arty_Target",_target];
			enableEngineArtillery true;
	        _arty doArtilleryFire [_target, _CfgMagazine,_rof];
	        sleep _reload;
			enableEngineArtillery false;
		};

		///// If out of ammo, reload
		if (_arty ammo (currentMuzzle (gunner _arty)) < 1) then
		{
			if (_Debug == 1) then {SystemChat "Time for Reload"};
			if(_this select 5 > 0) then { sleep _time; } else
			{
			 	sleep 120;
			 	/*
				_gunner enableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "GREEN";
				_gunner EnableAI "TARGET";
				_gunner EnableAI "AUTOTARGET";


				if(typeName _target == "OBJECT") then {
					_arty reveal _target;
					_arty doWatch [GetposATL _target select 0,GetposATL _target select 1,_angle];
				};

				if(typeName _target == "ARRAY") then {
					_arty doWatch [_target select 0,_target select 1,_angle];
				};

				sleep 6;

				_gunner disableAI "WEAPONAIM";
				_gunner setBehaviour "CARELESS";
				_gunner setCombatMode "BLUE";
				_gunner disableAI "TARGET";
				_gunner disableAI "AUTOTARGET";
				*/

		 	};

			_arty setVehicleAmmo 1;
			if (_Debug == 1) then {SystemChat "Reloaded"};

		};
		sleep 5;
	};
	if(!Alive (gunner _Arty)) exitWith { if(_Debug == 1) then { systemChat "Gunner dead. Exiting and removing Eventhandler"}};
	_arty removeAllEventHandlers "Fired";

};