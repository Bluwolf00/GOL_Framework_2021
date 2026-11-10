/*
How to USE:
Script is dynamic, it should launch as soon as first trigger or mission starts depending on your preference. When the enemy faction knows of the players on the ground, all enemy forces in specified radius will start hunting the players. They will not follow if players are extracted via helicopters or hunt helilcopters on their own. Ground vehicles will be hunted.
Add the Ignore line to the leader of the groups you wish the hunt script to ignore. It will always ignore static units spawned from the framework.

Code to Ignore:
this setVariable ["oks_disable_hunt",true];

Code to Launch:
null = [ENEMYFACTION,MINRANGE,MAXANGE] execVM "Oksman_Dynamic_Hunt.sqf";

Example:
null = [WEST,1000,2000] execVM "Oksman_Dynamic_Hunt.sqf";
*/


if (!isServer) exitWith {false};	// Ensures only server or HC runs this script - Tack Neky

			params ["_Hunter","_NearestPlayer"];


				_NextPosition = getPos _NearestPlayer;
				_Hunter setVariable ["isTracking", true];

				if(count waypoints group _Hunter>0 && _Hunter distance _NearestPlayer < OKS_MaxRange && !(_Hunter getVariable ["gw_common_disableai_path",false]) && (!(_Hunter getVariable ["oks_disable_hunt",false]) || !(vehicle _Hunter getVariable ["oks_disable_hunt",false])))
				then
				{
						{deleteWaypoint((waypoints group _Hunter)select 0)}forEach waypoints group _Hunter;

						if !(Vehicle _Hunter isKindOf "LandVehicle") then
						{
							{ doStop _X; _X doFollow leader group _X; _X disableAI "AUTOCOMBAT"; _X enableAttack false; _X setBehaviour "AWARE"; _X setBehaviourStrong "AWARE";} foreach units group _Hunter;
						};
				};

				sleep 5;

					if(_Hunter distance _NearestPlayer < OKS_MaxRange && !(_Hunter getVariable ["gw_common_disableai_path",false]) && (!(_Hunter getVariable ["oks_disable_hunt",false]) || !(vehicle _Hunter getVariable ["oks_disable_hunt",false])))
					then
					{

					if(oks_debug) then {SystemChat format ["Nearest Player: %1  Hunter: %2",_nearestPlayer,_Hunter]; };

						_wp = group _Hunter addWaypoint [position _nearestPlayer, 0];
						_wp setWaypointType "MOVE";
						_wp setWaypointSpeed "NORMAL";

							{ _X setWaypointSpeed "NORMAL"; } foreach waypoints _Hunter;

						if (vehicle _Hunter isKindOf "Car" || vehicle _Hunter isKindOf "Helicopter") then { _wp setWaypointBehaviour"SAFE";}
						else { _Hunter setBehaviour "AWARE"; group _Hunter setBehaviourStrong "AWARE"; _wp setWaypointBehaviour "AWARE"; };

						if (vehicle _Hunter isKindOf "Car" || vehicle _Hunter isKindOf "Helicopter") then { {_x setWaypointBehaviour "AWARE"} foreach waypoints _Hunter; }
						else {  {_x setWaypointBehaviour "SAFE"} foreach waypoints _Hunter	};

						waitUntil{_Hunter distance _NextPosition < 300;};
						{ _X enableAI "AUTOCOMBAT"; _X enableAttack true; _X setBehaviour "AWARE"; _X setBehaviourStrong "AWARE";} foreach units group _Hunter;

						waitUntil{_Hunter distance _NextPosition < 100; };
						_Hunter setVariable ["isTracking", false];
						_Hunter setVariable ["isHunting", false];
						if (oks_debug) then {SystemChat "Track - Complete"; };

					};