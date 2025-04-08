{ 
	[] spawn { 
	
		if (isMultiplayer) then {waitUntil {sleep 0.1; getClientState == "BRIEFING READ"};}; 
		waitUntil {sleep 0.1; !((findDisplay 12 displayCtrl 51) isEqualTo controlNull)}; 
			
		if !(isNil "RKAGRevealedGroups") exitWith {}; 
		
		comment "Parameters"; 
		RKAGOnlyShowMarkersOnMap = true; 
		RKAGIncludePlayerGroups = false; 
		RKAGHideFriendlyForces = true; 
		RKAGMinGroupSize = 2; 
		RKAGLastKnownLocationMarkerTime = 180; 
		RKAGBulletMarkerSpeed = 7.5; 
		RKAGBulletMarkerSize = [1,4]; 
		RKAGBulletMarkerColor = "ColorWhite"; 
		RKAGBulletMarkerLifetime = 1; 
		RKAGBulletIncludePlayers = true; 
		RKAGShowGroups = true; 
		
		setGroupIconsVisible [true,true]; 
		setGroupIconsSelectable true; 
		disableMapIndicators [RKAGHideFriendlyForces,true,false,false]; 
		uiNamespace setVariable ["_map",findDisplay 12 displayCtrl 51];  

		onGroupIconOverEnter 
		{ 
			private _group = _this select 1; 
			private _mkrType = [_group] call RKAG_fnc_getGroupNATOMarkerType; 
			private _text = groupId _group; 
			private _vehCount = 0; 
			private _footCount = 0; 
			private _vehName = ''; 
			private _vehs = []; 
		
			comment "Determine marker name based on vehicle count and type"; 
			{ 
				if (!(vehicle _x isEqualTo _x) && !(vehicle _x in _vehs)) then  
				{ 
					_vehCount = (_vehCount+1); 
					_vehs pushBack vehicle _x; 
					if (_vehName isEqualTo '') then {
						_vehName = [configFile >> "CfgVehicles" >> typeOf vehicle _x] call BIS_fnc_displayName;
					}; 
				}; 
				if (vehicle _x isEqualTo _x) then {
					_footCount = (_footCount+1);
				}; 
			} foreach units _group; 
			if (_vehCount == 1) then {
				_text = _vehName;
			}; 
		
			comment "Check if any units alive"; 
			_i = units _group findIf {alive _x}; 
			if (_i < 0) then {
				_group setGroupIconParams [[0,0,0,0.75],_text+" (DEAD)",1.25,true];
			} 
			else {
				_group setGroupIconParams [([side _group, false] call BIS_fnc_sideColor),_text,1.25,true];
			}; 
		
			comment "Show map tooltip"; 
			if (visibleMap) then {
				[_group,_vehCount,_footCount] call RKAG_fnc_showMapTooltip;
			}; 
		}; 
		
		onGroupIconOverLeave 
		{ 
			private _group = _this select 1; 
			_group setGroupIconParams [([side _group, false] call BIS_fnc_sideColor),"",1,true]; 
			call RKAG_fnc_hideMapTooltip; 
		}; 

		RKAGRevealedGroups = []; 
		
		call RKAG_fnc_createMapTooltip; 
		call RKAG_fnc_hideMapTooltip; 
		call RKAG_fnc_createMapHideMarkersCheckbox; 
		
		addMissionEventHandler ["Map",
		{  
			params ["_isOpened","_isForced"];  
			
			if (RKAGOnlyShowMarkersOnMap && !_isOpened) then  
			{ 
				setGroupIconsVisible [false,false]; 
				setGroupIconsSelectable false; 
			}; 
		
			if (RKAGOnlyShowMarkersOnMap && _isOpened && RKAGShowGroups) then  
			{ 
				setGroupIconsVisible [true,true]; 
				setGroupIconsSelectable true; 
			}; 
		
			if (!_isOpened) then {call RKAG_fnc_hideMapTooltip;}; 
		}]; 
			
		if (RKAGOnlyShowMarkersOnMap) then  
		{ 
			setGroupIconsVisible [false,false]; 
			setGroupIconsSelectable false; 
		}; 
			
		while {!isNil "RKAGRevealedGroups"} do  
		{ 
			if (alive player) then  
			{ 
				{ 
					private _group = _x; 
					_inVehicle = !(vehicle (units _group select 0) isEqualTo (units _group select 0)); 
					if (isNil "_inVehicle") then {
						_inVehicle = false;
					}; 
					
					private _i = -1; 
					if (RKAGIncludePlayerGroups) then {
						_i = -1;
					} 
					else {
						_i = units _group findIf {_x in allPlayers};
					}; 
					
					if (_i > -1 || ((side _Group) isEqualTo ([player] call GW_Common_Fnc_getSide) && (count units _group <= 1) && !_inVehicle) || (side _group) isEqualTo civilian) then {continue}; 
				
					private _spottedAnyGroupMember = false; 
					{ 
						_spottedAnyGroupMember = (([player] call GW_Common_Fnc_getSide) knowsAbout vehicle _x == 4); 
						[_x] call RKAG_fnc_tryInitUnit; 
					} forEach units _group; 
				
					if (_spottedAnyGroupMember) then  
					{ 
						if (_group in RKAGRevealedGroups) exitWith {}; 
						if (count units _group < RKAGMinGroupSize && ((vehicle (units _group select 0)) isEqualTo (units _group select 0))) exitWith {}; 
						RKAGRevealedGroups pushBack _group; 
						[_group] spawn RKAG_fnc_spawnRevealGroup; 
					} 
					else  
					{ 
						[_group] call RKAG_fnc_hideGroup; 
					}; 
				} foreach allGroups; 
		
				comment "Try Init Players"; 
				if (RKAGBulletIncludePlayers) then {  
					{ 
						if !(([_X] call GW_Common_Fnc_getSide) isEqualTo ([player] call GW_Common_Fnc_getSide)) then {continue}; 
						[_x] call RKAG_fnc_tryInitUnit; 
					} foreach allPlayers; 
				}; 
			}; 

			RKAGRevealedGroups = (RKAGRevealedGroups - [grpNull]); 
			{deleteGroup _x;} foreach allGroups; 
			uisleep 1; 
		}; 
	}; 
} remoteExec ["BIS_fnc_call",0,"JIP_ID_ShowRKAGMilitaryMarkers"]; 