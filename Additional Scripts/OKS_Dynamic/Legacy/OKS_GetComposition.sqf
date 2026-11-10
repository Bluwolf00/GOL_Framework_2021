/*
	Author: GuzzenVonLidl Adapted By Oksman
	Gets the deploy type for the mhq

	Usage:
	["small"] call OKS_GetComposition;

	Arguments:
	0: Unit <OBJECT>
	1: Type <STRING>

	Return Value: ObjectArray

	Public: No
*/

params [
	"_type"
];
systemChat str _type;
private _return = [];

switch (_type) do {
	case "small": {
		_return = [
			["Land_IRMaskingCover_02_F",90,[-0.796722,-3.09734,-0.00529003]],
			["Land_CampingTable_F",189.946,[-1.85233,-6.61244,-0.00528622]],
			["Land_CampingChair_V2_F",230,[-2.26124,-7.54794,-0.00528622]],
			["Land_CampingChair_V2_F",353.474,[-1.2665,-5.82129,-0.00528622]],
			["Land_Portable_generator_F",110,[-2.7164,-5.33063,-0.00528622]],
			["Land_CanisterFuel_F",320,[-2.04576,-5.67267,-0.00528622]],
			["PortableHelipadLight_01_red_F",340,[-1.69991,-6.54645,0.807719]],
			["Land_Sleeping_bag_folded_F",38,[-1.80033,-6.83354,0.807719]],
			["Land_Sleeping_bag_folded_F",121.391,[-2.10519,-6.41302,0.807719]]
		];
	};

	case "medium": {
		_return = [
			["Land_IRMaskingCover_01_F",90,[-0.500839,-5.47292,-0.00528622]],
			["CargoNet_01_barrels_F",210,[3.62416,-6.34792,-0.00528622]],
			["Land_WaterBarrel_F",0,[3.74916,-7.97292,-0.00528622]],
			["Land_CampingTable_F",230,[-3.12584,-10.5979,-0.00528622]],
			["Land_CampingChair_V1_F",30,[-2.87584,-9.47292,-0.00528622]],
			["PortableHelipadLight_01_red_F",0,[-2.87584,-11.2229,0.807719]]
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
			["Land_HelipadCircle_F",320,[-12.6296,-4.36905,-0.00528622]]
		];

		case "roadblock": {
			_return = [["Land_BagBunker_Tower_F",106,[-8.56641,-2.00781,-2.10446]],
			["Land_CncBarrier_F",289,[9.21924,2.59375,-2.20917]],
			["Land_CncBarrier_F",289,[6.57715,2.62598,-2.21246]],
			["Land_CncBarrier_F",333,[11.498,1.59863,-2.20081]],
			["Land_CncBarrier_F",21,[12.3696,-0.671875,-2.1875]],
			["Land_CncBarrier_F",284,[-7.30347,4.30566,-2.13876]],
			["Land_CncBarrier_F",284,[-9.9375,4.13965,-2.06998]],
			["Land_CncBarrier_F",242,[-12.1313,3.10547,-2.01611]],
			["Land_CncBarrier_F",194,[-13.0161,0.75293,-1.89722]],
			["RoadBarrier_F",288,[-7.68555,6.10742,-2.12079]],
			["RoadBarrier_F",285,[6.84326,4.6416,-2.21896]]];
		};
	};
};
systemChat str _return;
_return
