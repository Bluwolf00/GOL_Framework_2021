//	[side, "heli type classname" (default mid size heli of said side), ["spawn","_pos","_pos","despawn"], (Vulnerable, true or false)] execVM "Scripts\NEKY_PickUp\NEKY_PickUpTrigger.sqf";
//
//
//
//

Params ["_side","_HeliClass","_STTDs","_ShouldCreateMarker"];

NEKY_PickUp_Array = [];
NEKY_PickUp_Ready = False;
_Time = (Time + 20);

openMap true;
[Player, systemChat 'Pilot: Where do you want us to insert the reinforcements?'] onMapSingleClick {NEKY_PickUp_Array pushBack _Pos; NEKY_PickUp_Ready = True};
WaitUntil {NEKY_PickUp_Ready or (_Time < Time)};

if (_Time < Time) exitWith
{
	SystemChat "Pilot: Not enough coordinates recieved in 20 seconds. Come back to me when you know what you want.";
	player onMapSingleClick "";
	False;
};

SystemChat "Pilot: Copy that, coordinates recieved";
sleep 1;

[Player, systemChat 'Pilot: Where do you want the reinforcements to deploy once inserted?'] onMapSingleClick {NEKY_PickUp_Array pushBack _Pos; NEKY_PickUp_Ready = False};
WaitUntil {!NEKY_PickUp_Ready or (_Time < Time)};

player onMapSingleClick "";

if (_Time < Time) exitWith
{
	SystemChat "Pilot: Not enough coordinates recieved in 20 seconds. Come back to me when you know what you want.";
	False;
};

if ((NEKY_PickUp_Array select 0) distance (NEKY_PickUp_Array select 1) > 500) exitWith
{
	SystemChat "Pilot: These cordinates are too far away from each other, you expect them to run that far?!";
	False;
};
if(_ShouldCreateMarker) then {
	_side spawn
	{
		[(NEKY_PickUp_Array select 0), " Insertion", "insert",_this] execVM "Scripts\OKS_Reinforcement\OKS_CreateMarker.sqf";
		sleep 1;
		[(NEKY_PickUp_Array select 1), " Reinforce", "defend",_this] execVM "Scripts\OKS_Reinforcement\OKS_CreateMarker.sqf";
	};
};


/*
	["_Side", west, [SideUnknown]],
	["_HeliType", "", [""]],
	["_UnloadOrDrop", "unload", [""]],
	["_Ingress", "", ["",[],objNull]],
	["_UnloadOrDropMarker", "", ["",[]]],
	["_Egress", "", ["",[],objNull]],
	["_Units", [1,1], [[]]],
	["_GarrisonPosition", [""], [[""],[]]],
	["_Override", false, [true]],	
*/
[_Side,_HeliClass,(_STTDs select 0), (NEKY_PickUp_Array select 0), (_STTDs select 3), 1,(NEKY_PickUp_Array select 1)] execVM "Scripts\OKS_Reinforcement\OKS_Reinforcement_MapClick.sqf";