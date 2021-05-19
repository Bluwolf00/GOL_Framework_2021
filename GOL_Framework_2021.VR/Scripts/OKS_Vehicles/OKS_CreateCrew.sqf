/// [player,_unit] execVM "Scripts\OKS_Vehicles\OKS_CreateCrew.sqf";


		if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

		params["_Player","_Unit"];
		private _crew = (group _Player) CreateUnit [_Unit, [0,0,0], [], 0, "NONE"];

		if(isNull _crew) exitWith {SystemChat "Create Crew Failed.."};

		[[_Player,{{ if(_X in vehicle _this) then {deleteVehicle _X}} foreach AllDeadMen}],"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
		sleep 1;
		_crew moveInDriver (vehicle _Player);
		_crew moveInGunner (vehicle _Player);
		_crew moveInCommander (vehicle _Player);
		sleep 1;
		if !(_crew in vehicle _Player) then {
			deleteVehicle _crew;
			SystemChat "No crew space in vehicle, crew deleted..";
		}
		else
		{
			_crew addEventHandler ["Killed",{ SystemChat "Your AI crew member was killed.."}];
			_crew addEventHandler ["SeatSwitched", {
				params ["_vehicle", "_unit1", "_unit2"];
				if((driver _vehicle != _unit1 || gunner _vehicle != _unit1 || commander _vehicle != _unit1) && (!isPlayer _unit1)) then {deleteVehicle _unit1}
			}];
		};