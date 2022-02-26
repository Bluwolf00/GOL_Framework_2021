/* [this] execVM "Scripts\OKS_Ambience\OKS_VehicleParadrop.sqf"; */

params ["_Vehicle"];
private ["_para"];

waitUntil {getPos _Vehicle select 2 < 250};
_para = "B_Parachute_02_F" createVehicle [0,0,0];
_velocity = (velocityModelSpace _Vehicle);
_para setVelocityModelSpace _velocity;
_para setVelocity [0,0,-200];
_para setPos getPosWorld _Vehicle;
_Vehicle attachTo [_para,[0,1.3,1]];

waitUntil {getPos _Vehicle select 2 < 5};
detach _Vehicle;
_para setVelocity [0,0,-50];