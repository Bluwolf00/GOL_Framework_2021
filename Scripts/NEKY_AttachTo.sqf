//	[Object to Attach, Object to attach to, detach if main object is destroyed, detach if attached object is destroyed] execVM "Scripts\NEKY_AttachTo.sqf";
//
//	This attaches an object to the position it is currently placed in the editor.
//
///////////////////////
//	Parameters
//
//	1. Object to attach, the object you are attaching.
//
//	2. Object which parameter 1 is being attached to.
//
//	3. Detach if main object is destroyed. True = Detach when destroyed, False = Never detach.
//
//	4. Detach if attached object is destroyed. True = Detach when destroyed, False = Never detach.
//
//////////////
//	Examples:
//
//	[This, Table1] execVM "Scripts\NEKY_AttachTo.sqf";
//	[Pole, Car, true] execVM "Scripts\NEKY_AttachTo.sqf";
//	[This, Car, true] execVM "Scripts\NEKY_AttachTo.sqf";
//	[This, Car, true, true] execVM "Scripts\NEKY_AttachTo.sqf";
//
//	Made by NeKo-ArroW
//	Version 1.0

if !(isServer) exitWith {};

Params
[
	["_Object", ObjNull, [ObjNull]],
	["_Surface", ObjNull, [ObjNull]],
	["_SurDamage", false, [true]],
	["_ObjDamage", false, [true]]
];



// Error messages
if (isNull _Object) exitWith {SystemChat "NEKY_AttachTo: Error, missing object"};
if (isNull _Surface) exitWith {SystemChat "NEKY_AttachTo: Error, missing surface"};

// Collect position and vectors and then attach the object
_Object disableCollisionWith _Surface;
_Pos = getPosWorld _Object;
_Pos = ASLToAGL _Pos;
_VectorDir = _Surface vectorWorldToModel (VectorDir _Object);
_VectorUp = VectorUp _Object;
_AttachPos = _Surface worldToModel _Pos;
_Object attachTo [_Surface, _AttachPos];
_Object setVectorDirAndUp [_VectorDir, _VectorUp];
_Object setVariable ["NEKY_Attached",true];

// Destroyed EHs
if ((_SurDamage) && !(_Surface getVariable ["NEKY_AttachTo_EHAdded",false])) then
{
	// Surface EH
	_Surface setVariable ["NEKY_AttachTo_EHAdded",true];
	_Surface addEventhandler ["Killed",
	{
		Params ["_Surface"];

		_Attached = (AttachedObjects _Surface) select {_x getVariable "NEKY_Attached"};
		{ Detach _x } forEach _Attached;
	}];
};

if ((_ObjDamage) && !(_Object getVariable ["NEKY_AttachTo_EHAdded",false])) then
{
	// Attached Object
	_Object setVariable ["NEKY_AttachTo_EHAdded",true];
	_Object addEventhandler ["Killed",
	{
		Params ["_Object"];

		Detach _Object;
	}];
};