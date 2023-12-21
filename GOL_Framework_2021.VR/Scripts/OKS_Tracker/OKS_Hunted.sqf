// [group this, Trigger_1] execVM "Scripts\OKS_Tracker\OKS_Hunted.sqf";

params ["_HuntedGroup","_HuntedTriggerArea"];

OKS_HuntedGroups pushBackUnique _HuntedGroup;
publicVariable "OKS_HuntedGroups";

private _debugMessages = false;
private _debugObject = false;

private ["_TrackObject","_OriginBasePosition","_TracksArray","_PlayerWithMostNearestPlayers","_PlayerWithMostNearestPlayersList"];
_OriginBasePosition = getMarkerPos format["respawn_%1",side (_HuntedGroup)];
_TracksArray = [];

if(_debugObject) then {
	_TrackObject = "Sign_Arrow_Green_F";
} else {
	_TrackObject = "Land_ClutterCutter_small_F";
};

	while {
		{(alive _X || [_X] call ace_common_fnc_isAwake) && _X inArea _HuntedTriggerArea} count units _HuntedGroup > 0
	} do {
		if(_debugMessages) then { systemChat "Track loop start." };
		_PlayerWithMostNearestPlayersList = 
		([
			units _HuntedGroup,
			[],
			{
				count (_X nearEntities ["Man", 20]
				select {
					isPlayer _X
				})
			}, "DESCEND"
		] call BIS_fnc_sortBy)
		select {
			_Player = _X;
			_X distance _OriginBasePosition > 10 && {_Player distance _X < 10} count _TracksArray == 0
		};

		if(count _PlayerWithMostNearestPlayersList > 0) then {		
			_PlayerWithMostNearestPlayers = _PlayerWithMostNearestPlayersList select 0;	
			if(_debugMessages) then { systemChat format["%1 matched filter. Will create track.",name _PlayerWithMostNearestPlayers] };
		} else {
			if(_debugMessages) then { systemChat "No players matched filter. Will not create track." };
			sleep 5;
			continue;
		};	

	_track = createVehicle [_TrackObject, getPosATL _PlayerWithMostNearestPlayers, [], 0, "CAN_COLLIDE"];
	_track setVariable ["OKS_isTrack",true,true];
	[_HuntedGroup,_Track,_TracksArray] spawn {

		Params ["_HuntedGroup","_Track"];

		sleep 300;
		_TracksArray = _HuntedGroup getVariable ["OKS_GroupTracks",[]];
		_TracksArray deleteAt (_TracksArray find _track);
		_HuntedGroup setVariable ["OKS_GroupTracks",_TracksArray,true];
		deleteVehicle _track;
	};
	_TracksArray = _HuntedGroup getVariable ["OKS_GroupTracks",[]];
	_TracksArray pushBackUnique _track;

	_NullTracks = [];
	{
		if(isNull _X) then {
			_NullTracks pushBackUnique _X;		
		}
	} foreach _TracksArray;
	{
		_TracksArray deleteAt (_TracksArray find _X);
	} foreach _NullTracks;
	_HuntedGroup setVariable ["OKS_GroupTracks",_TracksArray,true];
	if(_debugMessages) then { systemChat format["Created track at %1",getPosATL _PlayerWithMostNearestPlayers] };

	waitUntil {sleep 2; {_PlayerWithMostNearestPlayers distance _X < 10} count _TracksArray == 0};
	systemChat "WaitUntil bypassed. Looping."
};

sleep 30;
[_HuntedGroup,_HuntedTriggerArea] spawn OKS_Hunted;