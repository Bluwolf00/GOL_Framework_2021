// Set AI Hostage Script 
// [this,nil,false,"Task_0"] spawn OKS_Hostage;
// [this,nil,false,"Task_0"] execVM  "Scripts\OKS_Ambience\OKS_Hostage.sqf";
// By Galactic Twinkles
// Define Captive
Params [
    ["_captive",objNull,[objNull]],
    ["_fallbackPosition",nil,[]],
	["_showTaskOnStart",false,[false]],
	["_ParentTask",nil,[""]]
];

private _randomTaskVariableName = "";
if(isNil "_fallbackPosition") then {
	_fallbackPosition = "";
};

_captive = _this select 0;
// Select random animation
_anim = selectRandom [
    "Acts_AidlPsitMstpSsurWnonDnon01",
    "Acts_AidlPsitMstpSsurWnonDnon02",
    "Acts_AidlPsitMstpSsurWnonDnon03",
    "Acts_AidlPsitMstpSsurWnonDnon04",
    "Acts_AidlPsitMstpSsurWnonDnon05",
    "Acts_ExecutionVictim_Loop"
];

// Set Captive Settings
_captive setCaptive true;

// Remove Items
removeAllWeapons _captive;
removeBackpack _captive;
removeVest _captive;
removeAllAssignedItems _captive;
_captive switchMove _anim; // SwitchMove to random animation

// Set unit as hurt if it's the Execution animation
if (_anim == "Acts_ExecutionVictim_Loop") then {
	_captive setDamage .5;
};
_captive disableAI "MOVE"; // Disable AI Movement
_captive disableAI "AUTOTARGET"; // Disable AI Autotarget
_captive disableAI "ANIM"; // Disable AI Behavioural Scripts
_captive allowFleeing 0; // Disable AI Fleeing
_captive setBehaviour "Careless"; // Set Behaviour to Careless because, you know, ARMA AI.


if(_showTaskOnStart) then {

	_randomTaskVariableName = format ["CivilianHostageRescue_Task_%1",(random 9000 + random 9000)];
	[true, [_randomTaskVariableName, _ParentTask], ["A hostage has been taken, your job is to rescue the hostage. Release him and evacuate if able, if not let him remain in place until its safe for him to flee.", "Hostage Rescue", "Hostage"], _captive, 1, 3, false,"help"] call BIS_fnc_taskCreate;

	[_captive,_randomTaskVariableName] spawn {
		waitUntil {sleep 5; !alive (_this select 0) || (_this select 1) call BIS_fnc_taskCompleted};
		if(!alive (_this select 0)) then {
			[(_this select 1),"FAILED",true] call BIS_fnc_taskSetState;
		};
	};

};

// Add Hold Action to Free Hostage
[
/* 0 object */				        _captive,
/* 1 action title */				"Unbind Hostage",
/* 2 idle icon */				"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
/* 3 progress icon */				"\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unbind_ca.paa",
/* 4 condition to show */			"alive _target",
/* 5 condition for action */			"alive _target",
/* 6 code executed on start */			{},
/* 7 code executed per tick */			{},
/* 8 code executed on completion */      	{
                            if (_this select 3 select 0 == "Acts_ExecutionVictim_Loop") then {
								_this select 0 playMove "Acts_ExecutionVictim_Unbow";
							} else {
								_this select 0 switchMove "Acts_AidlPsitMstpSsurWnonDnon_out";
							};
							_complMessage = selectRandom ["I thought I was gonna die here!","Thank you so much man.","What took you so long?","Thank you soldier!","Where the hell am I?"];
							_nearPlayers = allPlayers select {_X distance (_this select 0) < 10};
							["Hostage", _complMessage] remoteExec ["BIS_fnc_showSubtitle",_nearPlayers];
							sleep 5.5;
							
							(_this select 0) enableAI "AUTOTARGET";
							(_this select 0) enableAI "ANIM";
							(_this select 0) setBehaviour "SAFE";

							_waypoint = _this select 3 select 1;
							if(_waypoint != "") then {
								(_this select 0) enableAI "MOVE";
								_wp = group (_this select 0) addWaypoint [_waypoint,25];
                           		_wp setWaypointType "DISMISS";
							};
							
							[(_this select 0),(_this select 2)] remoteExec ["bis_fnc_holdActionRemove",2,true];

							_randomTaskVariableName = _this select 3 select 2;
							_parentTask = _this select 3 select 3;
							if(isNil "_randomTaskVariableName") then {
								_randomTaskVariableName = format ["CivilianHostageRescue_Task_%1",(random 9000 + random 9000)];
								[true, [_randomTaskVariableName, _ParentTask], ["A hostage has been taken, your job is to rescue the hostage. Release him and evacuate if able, if not let him remain in place until its safe for him to flee.", "Hostage Rescue", "Hostage"], _this select 0, "SUCCEEDED", -1, true, "help"] call BIS_fnc_taskCreate;
							}
							else
							{						
								[_randomTaskVariableName,"SUCCEEDED",true] call BIS_fnc_taskSetState;
							};
						},
/* 9 code executed on interruption */       {
						_intrMessage = selectRandom ["Hey! I don't wanna die here!","Don't leave me here man! Please!","Why did you stop? Help me!"];
						_nearPlayers = allPlayers select {_X distance (_this select 0) < 10};
						["Hostage", _intrMessage] remoteExec ["BIS_fnc_showSubtitle",_nearPlayers];
					    },
/* 10 arguments */			    [_anim,_fallbackPosition,_randomTaskVariableName,_parentTask],
/* 11 action duration */		    1,
/* 12 priority */			    0,
/* 13 remove on completion */		    true,
/* 14 show unconscious */		    false
] remoteExec ["BIS_fnc_holdActionAdd",0,true];