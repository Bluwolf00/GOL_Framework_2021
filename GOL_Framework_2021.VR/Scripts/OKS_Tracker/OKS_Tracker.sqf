// [group this] execVM "OKS_Tracker.sqf";

params ["_TrackerGroup"];
_TrackerGroup setVariable ["acex_headless_blacklist",true,true];

while {{alive _X || [_X] call ace_common_fnc_isAwake} count units _TrackerGroup > 0} do {

	if({_X distance (leader _TrackerGroup) < 500} count AllPlayers > 0 && !(_TrackerGroup getVariable ["OKS_isTracking",false])) then {
		_HuntedGroups = OKS_HuntedGroups;
		_TracksArray = [];
		{
			{
				_TracksArray pushBackUnique _X;		
			} forEach (_X getVariable ["OKS_GroupTracks",[]]);	
		} forEach _HuntedGroups;

		if({leader _TrackerGroup distance _X < 10} count _TracksArray > 0) then {
			_TracksArray = _TracksArray select {!isNull _X};
			_SelectedTrack = ([_TracksArray,[],{(leader _TrackerGroup) distance _X}, "ASCEND"] call BIS_fnc_sortBy) select 0;

			private _SelectedTracksArray = [];
			{
				_Array = _X getVariable ["OKS_GroupTracks",[]];
				if(_SelectedTrack in _Array) then {
					_SelectedTracksArray = _Array;
				};
			} forEach _HuntedGroups;
			_TracksArray = _SelectedTracksArray select { (_SelectedTracksArray find _X) >= (_SelectedTracksArray find _SelectedTrack)};

			{
				deleteWaypoint [_TrackerGroup,0];
			} foreach (waypoints _TrackerGroup);

			{
				_WP = _TrackerGroup addWaypoint [getPos _X,0];
				_WP setWaypointType "MOVE";
				_WP setWaypointBehaviour "AWARE";
				_WP setWaypointSpeed "NORMAL";	
				_WP setWaypointCompletionRadius 15;
			} forEach _TracksArray;

			[_TrackerGroup,_TracksArray] spawn {
				Params ["_TrackerGroup","_TracksArray"];
				waitUntil {(leader _TrackerGroup) distance (_TracksArray select ((count _TracksArray) - 1)) < 20};
				_TrackerGroup setVariable ["OKS_isTracking",false,true];	
			};

			[_TrackerGroup] spawn {
				Params ["_TrackerGroup"];
				while{{Alive _X} count (units _TrackerGroup) > 0} do {
					{
						if(!([_X] call ace_common_fnc_isAwake)) then {
							_X setDamage 1;
						};					
					} forEach (units _TrackerGroup);
					sleep 30;
				};
			};

			// Flare
			_Position = getPosATL (leader _TrackerGroup);
			_Temp = createVehicle ["F_40mm_Red", [(_Position select 0), (_Position select 1), ((_Position select 2) + 140)], [], 20, "CAN_COLLIDE"];
			_Temp setVelocity [0,0,-10];
			sleep 3;
			playSound3D ["A3\Sounds_F\weapons\Flare_Gun\flaregun_2_shoot.wss", (leader _TrackerGroup), false, [(_Position select 0), (_Position select 1), (_Position select 2)], 8, 1, 300];
			_TrackerGroup setVariable ["OKS_isTracking",true,true];
		};
	};

	sleep 5;
};