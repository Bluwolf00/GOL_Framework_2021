params ["_unit"];

_unit = _this select 0;

_class = str(typeOf _unit);

if (_class find "UH60" != -1) then {

	//hint "Test1";
	_unit addAction ["Open Right Cargo Door",{_target = _this select 0; _target animateDoor ['doorRB',1]; _target animate ['doorHandler_R',1]},nil,1.5,true,true,"","(_target getRelDir _this > 35) && _target getRelDir _this < 120 && _target doorPhase 'DoorRB' == 0 && _target distance _this < 6 && !(_this in _target)"];

	_unit addAction ["Close Right Cargo Door",{_target = _this select 0; _target animateDoor ['doorRB',0]; _target animate ['doorHandler_R',0]},nil,1.5,true,true,"","_target getRelDir _this > 35 && _target getRelDir _this < 120 && _target doorPhase 'DoorRB' == 1 && _target distance _this < 6 && !(_this in _target)"];

	_unit addAction ["Open Left Cargo Door",{_target = _this select 0; _target animateDoor ['doorLB',1]; _target animate ['doorHandler_L',1]},nil,1.5,true,true,"","_target getRelDir _this < 320 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 0 && _target distance _this < 6 && !(_this in _target)"];

	_unit addAction ["Close Left Cargo Door",{_target = _this select 0; _target animateDoor ['doorLB',0]; _target animate ['doorHandler_L',0]},nil,1.5,true,true,"","_target getRelDir _this < 320 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 1 && _target distance _this < 6 && !(_this in _target)"];
};

if (_class find "UH1" != -1) then {

	_unit addAction ["Open Right Cargo Door",{_target = _this select 0; _target animateDoor ['doorRB',1]; _target animate ['doorHandler_R',1]},nil,1.5,true,true,"","(_target getRelDir _this > 25) && _target getRelDir _this < 150 && _target doorPhase 'DoorRB' == 0 && _target distance _this < 8 && !(_this in _target)"];

	_unit addAction ["Close Right Cargo Door",{_target = _this select 0; _target animateDoor ['doorRB',0]; _target animate ['doorHandler_R',0]},nil,1.5,true,true,"","_target getRelDir _this > 25 && _target getRelDir _this < 150 && _target doorPhase 'DoorRB' == 1 && _target distance _this < 8 && !(_this in _target)"];

	_unit addAction ["Open Left Cargo Door",{_target = _this select 0; _target animateDoor ['doorLB',1]; _target animate ['doorHandler_L',1]},nil,1.5,true,true,"","_target getRelDir _this < 340 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 0 && _target distance _this < 8 && !(_this in _target)"];

	_unit addAction ["Close Left Cargo Door",{_target = _this select 0; _target animateDoor ['doorLB',0]; _target animate ['doorHandler_L',0]},nil,1.5,true,true,"","_target getRelDir _this < 340 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 1 && _target distance _this < 8 && !(_this in _target)"];

};

if (_class find "Mi24" != -1) then {

	_unit addAction ["Open cargo doors",{_target = _this select 0; _target animateDoor ['Door_Cargo',1]},nil,1.5,true,true,"","!(_target getRelDir _this < 35 && _target getRelDir _this > 340) && !(_target getRelDir _this > 90 && _target getRelDir _this < 270) && _target doorPhase 'Door_Cargo' == 0 && _target distance _this < 7.8 && !(_this in _target)"];

	_unit addAction ["Close cargo doors",{_target = _this select 0; _target animateDoor ['Door_Cargo',0]},nil,1.5,true,true,"","!(_target getRelDir _this < 35 && _target getRelDir _this > 340) && !(_target getRelDir _this > 90 && _target getRelDir _this < 270) && _target doorPhase 'Door_Cargo' == 1 && _target distance _this < 7.8 && !(_this in _target)"];
	
};

if (_class find "Mi8" != -1) then {

	_unit addAction ["Open Left Cargo Door",{_target = _this select 0; _target animateDoor ['LeftDoor',1]; _target animate ['doorHandler_R',1]},nil,1.5,true,true,"","(_target getRelDir _this > 300) && _target getRelDir _this < 340 && _target doorPhase 'LeftDoor' == 0 && _target distance _this < 8 && _target distance _this > 4.5 && !(_this in _target)"];

	_unit addAction ["Close Left Cargo Door",{_target = _this select 0; _target animateDoor ['LeftDoor',0]; _target animate ['doorHandler_R',0]},nil,1.5,true,true,"","_target getRelDir _this > 300 && _target getRelDir _this < 340 && _target doorPhase 'LeftDoor' == 1 && _target distance _this < 8 && _target distance _this > 4.5 && !(_this in _target)"];

	_unit addAction ["Open Rear Cargo Doors",{_target = _this select 0; [_target,14,15] call rhs_fnc_mi8_checkDoor},nil,1.5,true,true,"","_target getRelDir _this < 200 && _target getRelDir _this > 160 && _target doorPhase 'RearDoors' == 0 && _target distance _this < 8 && !(_this in _target)"];

	_unit addAction ["Close Rear Cargo Doors",{_target = _this select 0; [_target,14,15] call rhs_fnc_mi8_checkDoor},nil,1.5,true,true,"","_target getRelDir _this < 200 && _target getRelDir _this > 160 && _target doorPhase 'RearDoors' == 1 && _target distance _this < 8 && !(_this in _target)"];

};

/*
_unit addAction ["Open right cargo door",{_target = _this select 0; _target animateDoor ['doorRB',1]; _target animate ['doorHandler_R',1]},nil,1.5,true,true,"","(_target getRelDir _this > 35) && _target getRelDir _this < 120 && _target doorPhase 'DoorRB' == 0 && _target distance _this < 6 && !(_this in _target)"];

_unit addAction ["Close right cargo door",{_target = _this select 0; _target animateDoor ['doorRB',0]; _target animate ['doorHandler_R',0]},nil,1.5,true,true,"","_target getRelDir _this > 35 && _target getRelDir _this < 120 && _target doorPhase 'DoorRB' == 1 && _target distance _this < 6 && !(_this in _target)"];

_unit addAction ["Open left cargo door",{_target = _this select 0; _target animateDoor ['doorLB',1]; _target animate ['doorHandler_L',1]},nil,1.5,true,true,"","_target getRelDir _this < 320 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 0 && _target distance _this < 6 && !(_this in _target)"];

_unit addAction ["Close left cargo door",{_target = _this select 0; _target animateDoor ['doorLB',0]; _target animate ['doorHandler_L',0]},nil,1.5,true,true,"","_target getRelDir _this < 320 && _target getRelDir _this > 240 && _target doorPhase 'DoorLB' == 1 && _target distance _this < 6 && !(_this in _target)"];
*/


/*
DoorL1_Close
statement = "this animateDoor ['door_L', 0]";

DoorL1_Open
statement = "this animateDoor ['door_L', 1]";

DoorR1_Close
statement = "this animateDoor ['door_R', 0]";

DoorR1_Open
statement = "this animateDoor ['door_R', 1]";
*/