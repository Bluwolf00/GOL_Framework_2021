//	
//	
//	
//	
//	

Private ["_MsgPart1"];

Params 
[
	"_Msg",
	"_Veh",
	["_Spinner", false, [true]],
	"_SpinNumb"
];

_Driver = Driver _Veh;

if (_Spinner) then
{
	// Message
	Switch _SpinNumb do
	{
		Case 0: {_MsgPart1 = "--"};
		Case 1: {_MsgPart1 = "\"};
		Case 2: {_MsgPart1 = "/"};
	};
	_Msg = Format ["%1 %2", _Msg, _MsgPart1];
	[_Msg,_Veh] call NEKY_ServiceStation_Hints;
} else {
	if (IsNil "NEKY_Hints") then
	{
		if (((Player distance _Veh) <= 15) or (_Driver IsEqualTo Player)) then {Hint _Msg};
		if !(_Driver isEqualTo ObjNull) then { [[_Msg],{Hint (_This select 0)}] RemoteExec ["BIS_FNC_SPAWN",_Veh] };
	} else {
		if (((Player distance _Veh) <= 15) or (_Driver IsEqualTo Player)) then {[_Msg, 10] Spawn NEKY_Hints};
		if !(_Driver isEqualTo ObjNull) then { [_Msg] RemoteExec ["NEKY_Hints",_Veh] };
	};
};