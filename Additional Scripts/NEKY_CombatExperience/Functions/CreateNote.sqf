//	[Modules, Weight] call NEKY_CombatExperience_CreateNote;
//	
//	This function creates a note stating module states and versions.
//	
//	Made by NeKo-ArroW
//	Version 0.9

Params ["_Modules","_Weight"];

_Start = "==============================================<br/>";
_End = "==============================================";

_ModuleNames = ["Medical","Menu","KeyPress","Animations","Tracker","HUD","AI"];
_Count = (Count _ModuleNames) -1;
_Frame = "";

_Modules = _Modules Apply { if (_x) then {"<font color='#00FF00'>ENABLED</font>"} else {"<font color='#FF0000'>DISABLED</font>"} };

{
	_State = _Modules select _ForEachIndex;
	_Version = if (_State == "<font color='#00FF00'>ENABLED</font>") then { Call Compile PreProcessFileLineNumbers ("Scripts\NEKY_CombatExperience\Modules\"+_x+"\Version.sqf") } else { "N/A" };
	
	_Frame = _Frame + 
	(
		Format ["
		<font color='#F7FE2E'>%1:</font>   %2.<br/>
		<font color='#F7FE2E'>Version:</font>   %3.<br/>
		%4
		", _x, _State, _Version, if (_ForEachIndex == _Count) then {""} else {"<br/>"}]
	);
} forEach _ModuleNames;

_Frame = (_Start + _Frame + _End);

Player createDiarySubject ["NEKY_CE","CombatExperience"];	
Player createDiaryRecord ["NEKY_CE", ["Modules",_Frame]];