/// [vehicle player] execVM "Scripts\OKS_Vehicles\OKS_DeleteCrew.sqf";


		if (hasInterface && !isServer) exitWith {false};		// Ensures only server or HC runs this script

		params["_Player"];
		[[vehicle _Player,{{ if(!isPlayer _X && side _X == side _this) then {deleteVehicle _X}} foreach crew _this}],"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
