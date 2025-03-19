/// [this] execVM "Scripts\OKS_Vehicles\OKS_AbandonVehicle.sqf";
/// [this] spawn OKS_AbandonVehicle;
/// [vehicle]

if(!isServer) exitWith {};

Params
[
	["_Vehicle", ObjNull, [ObjNull]]
];

waitUntil {sleep 5; not canFire _Vehicle && count (crew _Vehicle) > 0};
_CrewArray = crew _Vehicle;
_CrewArray allowGetIn false;
{
	unassignVehicle _X;
	_X leaveVehicle _Vehicle;
} foreach _CrewArray;


if({_Vehicle isKindOf _X} count ["TrackedAPC","Tank","WheeledAPC"] > 0) then {
	sleep (random 5 + (random 5));
	_random = random 10;
	if(_random > 5) then {
		_Vehicle setDamage 1;
	} else {
		// create smokestack in vehicle?
	};
};
