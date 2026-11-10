//	[] execVM "Scripts\NEKY_PickUp\NEKY_Init.sqf"; 
//	
//	1. Add:	 [] execVM "Scripts\NEKY_PickUp\NEKY_Init.sqf";	 to your init.sqf
//	2. Open NEKY_Settings.sqf and edit _Callers to those you want to be able to run the script.
//	3. While in NEKY_Settings.sqf also edit the _Channels, see description for channels in there.
//	4. Remember to add names from _Callers to your units in-game that are supposed to have the actions.
//	5. Done.
//		
//	Made by NeKo-ArroW
//	
//	This is the init file for radio controlled supply drops. It uses SupplySettings for parameters.

Private ["_Array","_Index","_Callers","_Trg","_x","_i","_y","_Temp","_pos","_Click","_Channel","_Text"];

#include "NEKY_Settings.sqf"

// Make array lower case \\
_Index = 0;
_Array = [];
for "_i" from 1 to (count _Callers) do
{
	_Array pushBack (toLower ([_Callers, _Index, "", [""]] call BIS_fnc_Param));
	_Index = _Index +1;
};
sleep 0.5;

// See if player is a pick up caller \\
if !(toLower (format ["%1",Player]) in _Array) exitWith {FALSE};

// Creating Diary Record \\
Player createDiarySubject ["Supports","Supports"];
_Text = "Pick Up Call Signs<br></br><br></br>";
_Index = 0;
for "_i" from 1 to (count _Channels) do
{
	_Text = Format ["%1Radio: %2 -- %3<br></br>",_Text,((_Channels select _Index) select 0), ((_Channels select _Index) select 1)];
	_Index = _Index +1;
};
Player CreateDiaryRecord ["Supports",["Pick Up", _Text]];
{	_x deleteAt 1	} forEach _Channels;
sleep 1;

//	Turn STTD markers in to XYZ \\
_Index = 0;
for "_i" from 1 to (count _Channels) do
{
	_Index2 = 0;
	_Channel = (_Channels select _Index);
	for "_y" from 1 to 4 do 
	{
		if (typeName ((_Channel select 3) select _Index2) == "STRING") then 
		{
			(_Channel select 3) set [_Index2, (toLower ((_Channel select 3) select _Index2))];
			if !(((_Channel select 3) select _Index2) == "_pos") then
			{
				_Temp = (getMarkerPos ((_Channel select 3) select _Index2));
				(_Channel select 3) set [_Index2, _Temp];		
			};
		};
		_Index2 = _Index2 +1;
	};
	_Index = _Index +1;
};
sleep 1;

//	Trigger Creator \\
_Index = 0;
For "_i" from 1 to (count _Channels) do 
{
	_Channel = (_Channels select _Index);
	_Click = False;
	_Trg = CreateTrigger ["EmptyDetector", [0,0,0], false];
	_Trg setTriggerActivation [(_Channel select 0), "PRESENT", True];
	_Channel deleteAt 0;
	if (typeName ((_Channel select 2) select 1) == "STRING") then
	{
		_Temp = (_Channel select 2) set [1, (toLower ((_Channel select 2) select 1))];
		if (((_Channel select 2) select 1) == "_pos") then {_Click = True};
	};
	
	if (_Click) then
	{
		_Temp = Format 
		["
			openMap true;
			'Supports' call BIS_fnc_selectDiarySubject;
			[%1,'%2',[%3,'_pos','_pos',%4],%5] execVM 'Scripts\NEKY_PickUp\NEKY_PickUpTrigger.sqf';
		",(_Channel select 0), (_Channel select 1), (_Channel select 2 select 0), (_Channel select 2 select 3), (_Channel select 3)];
	} else {
		_Temp = Format 
		["
			SystemChat 'Pilot: Helicopter inbound';
			[%1,'%2',%3,%4] execVM 'Scripts\NEKY_PickUp\NEKY_PickUp.sqf';
		",(_Channel select 0), (_Channel select 1), (_Channel Select 2), (_Channel select 3)];
	};
	_Trg setTriggerStatements ["this", _Temp, ""];
	_Index = _Index +1;
};