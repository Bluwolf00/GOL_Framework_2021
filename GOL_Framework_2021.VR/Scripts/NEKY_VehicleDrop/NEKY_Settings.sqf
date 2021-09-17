//	#include "NEKY_Settings.sqf"
//	
//	This is where you set all the settings for the Vehicle Drop drop
//

// Name of units allowed to call in Vehicle drops \\
_Callers = ["DUDE","Player1"];


// Available Radio Commands \\
_Channels = 
[
	["Echo", "Quadbike", blufor, "B_Heli_Light_01_F", ["Spawn","_pos","deSpawn"], true, "B_Quadbike_01_F",nil,nil,nil,nil,nil],
	["Foxtrot", "Hunter HMG", blufor, "B_Heli_Transport_03_F", ["Spawn","_pos","deSpawn"], true, "B_MRAP_01_hmg_F",nil,nil,nil,nil,nil],
	["Golf", "Strider HMG", Independent, "", ["Spawn","_pos","deSpawn"], true, "I_MRAP_03_hmg_F",nil,Independent,0,["wp1","wp2"],nil],
	["Hotel", "MBT", BLUFOR, "", ["spawn","_pos","despawn"], true, "B_MBT_01_cannon_F", nil, BLUFOR, 0, ["WP1","WP2"], nil]
];


/////////////////////////
// Channel description 
/////////////////////////
// Param 1: String, Radio channel, select what radio channel it will be. Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India and Juliet available.
// Param 2: String, Description for the supplies that will be seen in the map screen (Supports --> Vehicle Drop).
// Param 3: Side, The side of the helicopter crew. (west/blufor, east/opfor, independent).
// Param 4: String, Heli classname. "" will create a Ghost Hawk/Taru/Merlin.
// Param 5: Array of strings, ["","",""]. "Spawn","DropOff","Despawn" markers. typing "_pos" instead of a marker name in "DropOff" will make it so you can select the delivery position yourself.
// Param 6: Boolean, Whether the heli can take damage and be destroyed or not. True = can take damage, false = cannot take damage.
// Param 7: String, ClassName of the vehicle you want delivered.
// Param 8: Array, Adjustments for where the vehicle is attached (AttachedTo).
// Param 9: Side, Side of the crew in the vehicle (if you want crew)
// Param 10: Number, How many percent of the vehicle's cargo seats you want filled with units (0 = 0%, 1 = 100%).
// Param 11: Array, Waypoints for the vehicle and it's units. Can be markers or [X,Y,Z].
// Param 12: CODE, unique code to perform on delivered object. Refer to the object itself using: (_This select 0)
/////////////////////////
//
// ["Channel", "Diary Description", side, "heli classname", "type", ["spawn marker", "DropOff Marker" "despawn marker"], (can take damage, true or false), "Vehicle class name", [Adjustment,based on,AttachTo], CrewSide, % of vehicle cargo to fill, [Waypoints, "Marker", [or X,Y,Z]]
// example: ["Alpha", "QuadBike", blufor, "B_Heli_Light_01_F", ["spawn","_pos","despawn"], true, "B_Quadbike_01_F", nil, nil, nil, nil]
//
/////////////////////////