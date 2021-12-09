Params ["_Talker","_Channel","_Message"];
//
// ["HQ","side","Test"] execVM "Scripts\OKS_Ambience\OKS_Chat.sqf";
//

if(!HasInterface) exitWith {false};

_Channel = toLower _Channel;
Private _Code = {};
Private ["_Range"];

Switch (_Channel) do {

	case "side":{
		_Range = 1000;
		_Code = {
					Params ["_Talker","_Message","_Range"];
					if(typeName _Talker != "STRING") then {
						if(player distance _talker < _Range) then {
							_talker setRandomLip true;
							_Talker sideChat _Message
						}
					} else {
						[side player,_Talker] sideChat _Message
					}
				};
	};
	case "local":{
		_Range = 20;
		_Code = {
					Params ["_Talker","_Message","_Range"];
					_Message = format ["%1: %2",[_Talker] call BIS_fnc_getName,_Message];
					if(player distance _talker < _Range) then {
						_talker setRandomLip true; SystemChat _Message
					}
				};
	};
	default {
		_Range = 1000;
		_Code = {
					Params ["_Talker","_Message","_Range"];
					if(typeName _Talker != "STRING") then {
						if(player distance _talker < _Range) then {
							_talker setRandomLip true;
							_Talker sideChat _Message
						}
					} else {
						 [side player,_Talker] sideChat _Message
					 }
				};
	}
};
[_Talker,_Message,_Range] spawn _Code;
