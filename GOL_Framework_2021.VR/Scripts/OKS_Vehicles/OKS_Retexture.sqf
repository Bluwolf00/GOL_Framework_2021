/* 

[this,
	[
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\apc_tracked_03_ext_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\apc_tracked_03_ext2_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\camonet_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\cage_baf_co.paa"
	]
] execVM "Scripts\OKS_Vehicles\OKS_Retexture.sqf";

[this,
	[
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\apc_tracked_03_ext_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\apc_tracked_03_ext2_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\camonet_baf_co.paa",
		"uk3cb_baf_vehicles\addons\uk3cb_baf_vehicles_warrior_a3\data\cage_baf_co.paa"
	]
] spawn OKS_Retexture;

*/

if(!isServer) exitWith {};

Params
[
	["_Vehicle", ObjNull, [ObjNull]],
	["_TextureArray",[],[[]]]
];

for "_i" from 1 to (count _TextureArray) do {
	_Vehicle setObjectTextureGlobal [_i,_TextureArray select _i];
};


