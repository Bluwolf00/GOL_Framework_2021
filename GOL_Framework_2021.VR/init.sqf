/*
	Initialization script for FW.

	Use this file if you want to run code at the start of the mission.
	If you want tasks to appear on the briefing screen, place the task creations below here.

	Global Commands can be used here, but be wary of locality issues. Do not spawn global effects "globally" (All clients)
	Example: Spawn a vehicle globally means, every single client will spawn a vehicle, resulting in.. a lot of vehicles.

	Server Commands should be within the isServer check.
*/
sleep 2;
if(isServer) then {
	[[
		[[88.1528,275.195,0],175,"Auto",[],"I_Soldier_AR_F"],
		[[82.7483,279.755,0],175,"Auto",[],"I_Soldier_M_F"],
		[[92.7125,280.599,0],175,"Auto",[]],
		[[77.3437,284.314,0],175,"Auto",[]],
		[[97.2722,286.004,0],175,"Auto",[],"I_Sniper_F"],
		[[71.9392,288.874,0],175,"Auto",[]],
		[[101.832,291.409,0],175,"Auto",[]],
		[[66.5346,293.434,0],175,"Auto",[],"rhssaf_army_m10_para_mgun_m84"]
	],[
		["O_MRAP_02_hmg_F",[54.5722,288.975,0],111,[],[[6,["Hex",1]]]],
		["O_MRAP_02_hmg_F",[111.229,285.494,0],197,[["driver",-1,[]],["gunner",-1,[0]]],[[6,["Hex",1]]]]
	],[], resistance] call GW_Common_fnc_spawnGroup;

	[[
		[[5.02631,341.347,0],0,[],"rhssaf_army_o_m10_para_mgun_m84"],
		[[10.0263,339.347,0],0,[],"rhssaf_army_o_m10_para_mgun_m84"]
	],[
		["O_MRAP_02_hmg_F",[15.8485,344.463,0],92,[["driver",-1,[]],["gunner",-1,[0]]],[[6,["Hex",1]]]]
	],[
		[[166.55,372.234,0],[[0,"Move"]]],
		[[127.034,273.085,0],[[0,"Move"]]],
		[[36.61,254.044,0],[[0,"Move"]]],
		[[16.568,336.477,0],[[0,"Cycle"]]]
	], independent] call GW_Common_fnc_spawnGroup;
};