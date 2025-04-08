/*
	Author: GuzzenVonLidl
	Gets the deploy type for the mhq

	Usage:
	[mhq_1, "small"] call GW_MHQ_Fnc_getDeployType;

	Arguments:
	0: Unit <OBJECT>
	1: Type <STRING>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"

params [
	"_type"
];

private _return = [];

switch (_type) do {

	case "boat": {
		_return = [
			["Box_NATO_Equip_F",165,[0.5,7,0.56345],["gearbox",(_mhq getVariable QGVAR(Side))]],
			["SatelliteAntenna_01_Olive_F",(166+180),[-0.5,8,-0.381792]],
			["Land_BagFence_01_round_green_F",(343-180),[0.0244141,9.5,0.133886]]
		];
	};
	case "small": {
		_return = [
			["Box_NATO_Equip_F",268,[-0.19632,4.67848,-2.17615],["gearbox",(_mhq getVariable QGVAR(Side))]],
			["Box_NATO_Equip_F",271,[0.0817223,-6.44015,-2.17615],["gearbox",(_mhq getVariable QGVAR(Side))]],
			//["CamoNet_BLUFOR_open_F",88,[-0.580032,-0.977325,-2.17615]],
			["Land_BagFence_01_round_green_F",23,[-2.69328,-7.52737,-2.17745]],
			["Land_BagFence_01_round_green_F",320,[3.15591,-7.21935,-2.17745]],
			["Land_BagFence_01_round_green_F",201,[2.13588,5.71606,-2.17745]],
			["Land_BagFence_01_round_green_F",155,[-2.906,5.49521,-2.17745]],
			["Land_BagFence_01_long_green_F",269,[-4.28108,-3.35187,-2.17715]],
			["Land_BagFence_01_long_green_F",269,[-4.33076,0.936893,-2.17715]],
			["Land_BagFence_01_long_green_F",269,[4.3396,-2.86632,-2.17715]],
			["Land_BagFence_01_long_green_F",269,[4.19077,1.29527,-2.17715]]
		];
	};

	case "medium": {
		_return = [
			["Box_NATO_Equip_F",268,[-4.02506,-1.39868,-2.20595],["gearbox",(_mhq getVariable QGVAR(Side))]],
			["Box_NATO_Equip_F",268,[3.92525,-1.25739,-2.20595],["gearbox",(_mhq getVariable QGVAR(Side))]],
			["CamoNet_BLUFOR_big_F",180,[0.109093,-2.48904,-2.20595]],
			["Land_BagFence_01_round_green_F",121,[-6.79787,2.03528,-2.20725]],
			["Land_BagFence_01_round_green_F",144,[-4.97442,3.68629,-2.20725]],
			["Land_BagFence_01_round_green_F",207,[4.83183,4.01045,-2.20725]],
			["Land_BagFence_01_long_green_F",348,[-2.44761,4.40547,-2.20695]],
			["Land_BagFence_01_long_green_F",80,[-6.90128,-1.83427,-2.20695]],
			["Land_BagFence_01_long_green_F",56,[-5.02162,-6.55472,-2.20695]],
			["Land_BagFence_01_long_green_F",13,[-1.70855,-8.84624,-2.20695]],
			["Land_BagFence_01_long_green_F",354,[1.96452,-9.2169,-2.20695]],
			["Land_BagFence_01_long_green_F",307,[5.95254,-7.16691,-2.20695]],
			["Land_BagFence_01_long_green_F",245,[6.41019,1.50032,-2.20695]],
			["Land_BagFence_01_long_green_F",272,[7.04918,-2.94966,-2.20695]]
		];
	};
	case "fob": {
		_return = [
			["Land_HBarrier_Big_F",45,[1.49596,6.9942,-0.00528622]],
			["Land_HBarrier_Big_F",215,[-8.31532,16.5477,-0.00528622]],
			["Land_HBarrierWall4_F",50,[-4.26378,11.1359,-0.00528622]],
			["Land_HBarrier_Big_F",95,[4.08037,0.0249233,-0.00528622]],
			["Land_HBarrierWall4_F",145,[-5.62723,-11.5474,-0.00528622]],
			["Land_HBarrierWall_corner_F",145,[0.131363,-10.6316,-0.00528622]],
			["Land_HBarrierWall_corner_F",55,[3.41786,-7.54755,-0.00528622]],
			["Land_HBarrier_Big_F",50,[-17.8708,-11.5409,-0.00528622]],
			["Land_HBarrier_Big_F",230,[-28.7146,0.409781,-0.00528622]],
			["Land_HBarrier_Big_F",50,[-23.0594,-5.9409,-0.00528622]],
			["Land_HBarrierWall_corner_F",230,[-32.4326,6.59099,-0.00528622]],
			["Land_HBarrier_Big_F",5,[-11.2988,-14.5115,-0.00528622]],
			["Land_HBarrierWall4_F",320,[-29.2914,10.0427,-0.00528622]],
			["Land_HBarrierWall_corner_F",320,[-22.0327,16.9493,-0.00528622]],
			["Land_HBarrierWall_corridor_F",230,[-26.2647,14.2141,-0.00528622]],
			["Land_HBarrier_Big_F",5,[-15.9098,18.9867,-0.00528622]],
			["Land_CargoBox_V1_F",80,[-26.6234,2.00134,-0.00528622]],
			["Land_CargoBox_V1_F",25,[-24.6146,-0.392542,-0.00528622]],
			["Land_PaperBox_closed_F",80,[-6.61691,6.55055,-0.00528622]],
			["Land_PaperBox_open_full_F",35,[-7.4754,4.85114,-0.00528622]],
			["Land_PaperBox_closed_F",45,[-5.33134,5.01846,-0.00528622]],
			["WaterPump_01_sand_F",250,[-15.6401,14.9704,-0.00528622]],
			["Land_WaterTank_F",195,[-12.2666,16.0062,-0.00528622]],
			["Land_WaterTank_F",300,[-10.4374,14.604,-0.00528622]],
			["Land_HelipadCircle_F",320,[-12.6296,-4.36905,-0.00528622]],
			["Box_NATO_Equip_F",273.672,[-2.4827,-9.07201,-0.00528622],["gearbox",(_mhq getVariable QGVAR(Side))]]
		];
	};
};

_return
