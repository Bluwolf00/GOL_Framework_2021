/*
	OKS_Nearby_Units_Hunt
	[Trigger,750,Trigger] spawn OKS_Nearby_Units_Hunt;
	[Trigger,Range,CenterPos,Interval,EnableFlare] execVM "Scripts\OKS_Ambience\OKS_Nearby_Units_Hunt.sqf";
*/

 	if(!isServer) exitWith {};

	Params [
		["_Trigger",objNull,[objNull]],
		["_Range",750,[0]],
		["_Center",[],[[]]],
		["_Interval",15,[0]],
		["_EnableFlare",true,[true]]
	];

	private _EnemyGroups = [];
	{ _EnemyGroups pushBackUnique (group _x) } forEach list _Trigger;	

	waitUntil {sleep 5; !(isNil "lambs_wp_fnc_taskHunt")};
	/* 
		* Arguments:
		* 0: Group performing action, either unit <OBJECT> or group <GROUP>
		* 1: Range of tracking, default is 500 meters <NUMBER>
		* 2: Delay of cycle, default 15 seconds <NUMBER>
		* 3: Area the AI Camps in, default [] <ARRAY>
		* 4: Center Position, if no position or Empty Array is given it uses the Group as Center and updates the position every Cycle, default [] <ARRAY>
		* 5: Only Players, default true <BOOL>
		* 6: enable dynamic reinforcement <BOOL>
		* 7: Enable Flare <BOOL> or <NUMBER> where 0 disabled, 1 enabled (if Units cant fire it them self a flare is created via createVehicle), 2 Only if Units can Fire UGL them self
	*/	
	{
		if(!(_X getVariable ["LAMBS_HUNTING",false]) && !(_X getVariable ["GOL_IsStatic",false]) ) then {
			_X setVariable ["LAMBS_HUNTING",true,true];
			[_X, _Range, _Interval, [], _Center, true,false,_EnableFlare] remoteExec ["lambs_wp_fnc_taskHunt",0];
		};		
	} foreach _EnemyGroups;

