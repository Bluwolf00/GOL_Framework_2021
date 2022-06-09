Params ["_Talker","_Channel","_Message"];
/* 
 Local Execution - Requires to be run on all Clients (Globally) to show everyone a message.
   
 Parameters:
 _Talker = Entity (Person) or String (Preset-Callsign)
 Preset Callsigns: "Base" "HQ" "PAPA_BEAR" "AirBase" "BLU" "OPF" "IND" "IND_G"

 _Channel = "side" or "local" defaults to "side". "Side" is a radio message, and must be sent by the same side as the player to be visible (Cannot be captive).
            "local" can be sent by any entity however cannot be sent by Preset callsigns. Local range is 20m, Radio range is 1000m.
 
 ["HQ","side","Test"] execVM "Scripts\OKS_Ambience\OKS_Chat.sqf"; - Has to be executed globally, for example using a trigger.
 [person1,"local","Hello World!"] remoteExec ["OKS_Chat",0]; - Has to be executed server/1 client ONLY, for example using a trigger with "Server Only".
*/ 

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
