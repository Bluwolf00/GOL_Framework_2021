//	[[DistanceToPlayer,DistanceToFriendly], AliveFriendlyNear, ChanceToSurrender] Call NEKY_AI_Surrender;
//	
//	1. [DistanceToPlayer, DistanceToFriendly]
//		a) DistanceToPlayer, how close a player has to be for an AI to surrender.
//		b) DistanceToFriendly, how far away a friendly unit (to the AI) has to be for the unit to surrender.
//	2. AliveFriendlyNear.
//		a) How many friendly (to the AI) units there can be near the AI for it to surrender.
//	3. ChanceToSurrender.
//		a) How big of a chance there is for a unit to surrender (if above conditions are met). 0 = 0%, 1 = 100%.
//	
//	
//	This adds an eventhandler for all units and makes it so there's a chance for a group to surrender when a team mate dies.
//	
//	Made by NeKo-ArroW
//	Version 1.01

if !(isServer) exitWith {};

Params 
[
	["_Distances", [75,25], [[]]],
	["_FriendliesNear", 1, [0]],
	["_Chance", 0.1, [0]]
];

MissionNameSpace setVariable ["NEKY_AI_Surrender_Settings",_This];

addMissionEventHandler ["EntityKilled",
{
	if !(isServer) exitWith {};
	
	Params ["_Unit"];
	if (isPlayer _Unit) exitWith {};
	_Settings = MissionNameSpace getVariable "NEKY_AI_Surrender_Settings";
	
	// Define Settings.
	_Grp = Group _Unit;
	_Settings Params ["_Distances","_FriendliesNear","_Chance"];
	
	// Check chance.
	_Roll = Round (Random 100);
	if (_Roll > (_Chance * 100)) exitWith {};
	
	// Check alive group members.
	_Units = (Units _Grp) select {Alive _x && !isPlayer _x};
	if ((Count _Units) == 0) exitWith {};
	
	// If passed
	_Distances Params ["_PlayerNear","_FriendlyNear"];
	{
		_Unit = _x;
		if (_Unit getVariable ["NEKY_AI_Surrender_Surrendered",False]) exitWith {}; // If already surrendered.
		if (({(AnimationState _Unit) == _x} count ["AmovPercMstpSnonWnonDnon_Ease","amovpercmstpssurwnondnon"]) != 0) exitWith {}; // If in a surrendered animation.
		if !(isNull objectParent _Unit) exitWith {}; // Exit if in a vehicle.
		_Players = Count ((_Unit NearEntities ["Man",_PlayerNear]) select {isPlayer _x});
		_Side = Side _Unit;
		_Friendlies = (Count ((_Unit NearEntities ["Man",_FriendlyNear]) select {Side _x == _Side && Alive _x})) -1; // -1 to remove the unit itself.
		
		if ((_Players != 0) && (_Friendlies <= _FriendliesNear)) then
		{
			if !(Alive _Unit) exitWith {}; // Failsafe.
			_Unit setVariable ["NEKY_AI_Surrender_Surrendered",True];
			
			// Add current weapon to ground.
			_CurrentW = CurrentWeapon _Unit;
			_GroundHolder = createVehicle ["GroundWeaponHolder", (_Unit getRelPos [0.5, (getDir _Unit)]), [], 0, "CAN_COLLIDE"];
			_GroundHolder AddItemCargoGlobal [_CurrentW,1];
			_Unit RemoveWeaponGlobal _CurrentW;
			
			// Surrender
			[[_Unit],
			{
				Params ["_Unit"];
				_Unit PlayMoveNow "AmovPercMstpSsurWnonDnon";
				_Unit setCaptive True;
			}] remoteExec ["BIS_FNC_CALL",_Unit];
		};
	} forEach _Units;
}];