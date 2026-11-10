//	#include "NEKY_Settings.sqf"
//	
//	This is where you set all the settings for the Pick Up


// Name of units allowed to call in supply drops \\
_Callers = ["wsl","w1a1","w1b1","w1c1","w1d1","w1e1","e1a1","e1b1","e1c1","e1d1","e1e1","i1a1","i1b1","i1c1","i1d1","i1e1"];


// Available Radio Commands \\
_Channels = 
[
	["Golf", "Small helicopter", blufor, "B_Heli_Light_01_F", ["ingress","_pos","_Pos","egress"], true], 
	["Hotel", "Big helicopter", blufor, "B_Heli_Transport_03_F", ["ingress","_pos","_pos","egress"], true]
];

// Channel description \\
/////////////////////////
// Param 1: String, Radio channel, select what radio channel it will be. Alpha, Bravo, Charlie, Delta, Echo, Foxtrot, Golf, Hotel, India and Juliet available.
// Param 2: String, Description for the Helicopters that will be seen in the map screen (Supports --> Pick Up).
// Param 3: Side, The side of the helicopter crew. (west/blufor, east/opfor, independent).
// Param 4: String, Heli classname. "" will create a Ghost Hawk/Taru/Hellcat.
// Param 5: Array of strings, ["","","",""]. "Spawn","PickUp","DropOff","Despawn" markers. typing "_pos" instead of a marker name in "PickUp" will make it so you can select the PickUp position yourself. (Same for "DropOff")
// Param 6: Boolean, Whether the heli can take damage and be destroyed or not. True = can take damage, false = cannot take damage.
/////////////////////////
//
// ["Channel", "Diary Description", side, "heli classname", "type", ["spawn marker",("PickUp Marker" or "_pos1"), ("DropOff Marker" or "_pos2"), "despawn marker"], (can take damage, true or false)]
// example: ["Alpha", "Small helo", blufor, "", ["spawn","_pos1","_pos2","despawn"], true]
//
/////////////////////////