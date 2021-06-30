//	[side, "heli type classname" (default mid size heli of said side), ["spawn","_pos","_pos","despawn"], (Vulnerable, true or false)] execVM "Scripts\NEKY_PickUp\NEKY_PickUpTrigger.sqf";
//
//
//
//

Params ["_side","_HeliClass","_STTDs","_Vulnerable"];

NEKY_PickUp_Array = [];
NEKY_PickUp_Ready = False;
_Time = (Time + 20);

openMap true;
[Player, systemChat 'Pilot: Where do you want to be picked up?'] onMapSingleClick {NEKY_PickUp_Array pushBack _Pos; NEKY_PickUp_Ready = True};
WaitUntil {NEKY_PickUp_Ready or (_Time < Time)};

if (_Time < Time) exitWith
{
	SystemChat "Pilot: Not enough coordinates recieved in 20 seconds. Come back to me when you know what you want.";
	player onMapSingleClick "";
	False;
};

SystemChat "Pilot: Copy that, coordinates recieved";
sleep 1;

[Player, systemChat 'Pilot: Where do you want to be dropped off?'] onMapSingleClick {NEKY_PickUp_Array pushBack _Pos; NEKY_PickUp_Ready = False};
WaitUntil {!NEKY_PickUp_Ready or (_Time < Time)};

player onMapSingleClick "";

if (_Time < Time) exitWith
{
	SystemChat "Pilot: Not enough coordinates recieved in 20 seconds. Come back to me when you know what you want.";
	False;
};

if ((NEKY_PickUp_Array select 0) distance (NEKY_PickUp_Array select 1) < 500) exitWith
{
	SystemChat "Pilot: These cordinates are too close to eachother, use your feet soldier!";
	False;
};

[] spawn
{
	[(NEKY_PickUp_Array select 0), " Extraction", "extract"] execVM "Scripts\NEKY_PickUp\NEKY_CreateMarker.sqf";
	sleep 1;
	[(NEKY_PickUp_Array select 1), " Insertion", "insert"] execVM "Scripts\NEKY_PickUp\NEKY_CreateMarker.sqf";
};
[_Side,_HeliClass,[(_STTDs select 0), (NEKY_PickUp_Array select 0), (NEKY_PickUp_Array select 1), (_STTDs select 3)], _Vulnerable] execVM "Scripts\NEKY_PickUp\NEKY_MapClick.sqf";