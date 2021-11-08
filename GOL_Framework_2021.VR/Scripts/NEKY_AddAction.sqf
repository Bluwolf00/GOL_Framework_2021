//	[This,"Name","Variable",false,true] execVM "Scripts\NEKY_AddAction.sqf";
//
//	1. This - The object you want to add the addaction to.
//	 a) This = The object of which init this code is executed from.
//	2. "Name" - The name of the addaction in the scrollwheel list.
//	3. "Variable" - A Unique variable name which will be turned to True upon interaction.
//	 a) Make sure it is unique by adding a code name before, like, NEKY_ or similar.
//	4. True - Whether you want the object that you interact with, to dissapear after use.
//	 a) True = Remove.
//	 b) False = Do not remove.
// 	5. True - If you want the action to be removed after use
//   a) True = Remove.
//	 b) False = Do not Remove.
//
///////////////
//	Examples //
///////////////
//
//	[This,"Take Notes","NEKY_NotesTaken",True,True] execVM "Scripts\NEKY_AddAction.sqf";
//	[Map,"Search Map","Map_Searched",False,true] execVM "Scripts\NEKY_AddAction.sqf";
//
//
//	Version 0.9
//	Made by NeKo-ArroW

Params ["_Object","_Name","_Variable","_Delete","_RemoveAction"];

// Exit if object is missing/dead
if !(Alive _Object) exitWith {};

// Action
_Object addAction [_Name,
{
	Params ["_Object","_Player","_ID","_Args"];
	_Args Params ["_Variable","_Delete","_RemoveAction"];
	if (_RemoveAction) then { _Object removeAction _ID };
	if (_Delete) then { DeleteVehicle _Object };

	Call Compile Format ["%1 = True; PublicVariable '%1'",_Variable];
},[_Variable,_Delete,_RemoveAction],10,True,True];