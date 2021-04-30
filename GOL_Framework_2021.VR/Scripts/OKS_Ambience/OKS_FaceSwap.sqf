/*

	_null = [east,"african"] execVM "OKS_FaceSwap.sqf";
	[civilian_1,"african"] execVM "OKS_FaceSwap.sqf";

	Options:
	african
	asian
	caucasian
	middleeast
	russian

*/

Params
[
	["_Faction", East, [sideUnknown,ObjNull]],
	["_Face", "african", [""]]
];

switch (_Face) do
{

	case "african":
	{
		OKS_faces = ["Barklem","TanoanHead_A3_03","TanoanHead_A3_04","AfricanHead_02","AfricanHead_03","TanoanHead_A3_05","TanoanHead_A3_07","TanoanHead_A3_01","TanoanHead_A3_06","TanoanHead_A3_08","AfricanHead_01"];
	};

	case "asian":
	{
		OKS_faces = ["AsianHead_A3_01","AsianHead_A3_07","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_02","AsianHead_A3_05"];
	};

	case "caucasian":
	{
		OKS_faces = ["WhiteHead_01","WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13",
					"WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20","WhiteHead_21","WhiteHead_22","WhiteHead_23","WhiteHead_24","WhiteHead_25","WhiteHead_26"];
	};

	case "middleeast":
	{
		OKS_faces = ["PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03"];
	};

	case "russian":
	{
		OKS_faces = ["RussianHead_1","RussianHead_2","RussianHead_3","RussianHead_4","RussianHead_5"];
	};

	default{
		OKS_faces = ["AsianHead_A3_01","AsianHead_A3_07","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_02","AsianHead_A3_05"];
	};


};

if(typeName _Faction == "OBJECT") exitWith {
	_Faction setVariable ["OKS_FaceSwap",true];
	_SelectedFace = OKS_faces call BIS_fnc_selectRandom;
	_Faction setFace _SelectedFace;
	[_Faction,_SelectedFace,"ace_novoice"] call BIS_fnc_setIdentity;
};

while {true} do
{

	{
		if((side _X == _Faction || side _X == civilian) && !(isPlayer _X)) then
		{
			//SystemChat format ["%1",side _X];
			if !(_X getVariable["OKS_FaceSwap",false]) then
			{
				_X setVariable ["OKS_FaceSwap",true];
				_SelectedFace = OKS_faces call BIS_fnc_selectRandom;
				_X setFace _SelectedFace;
				[_X,_SelectedFace,"ace_novoice"] call BIS_fnc_setIdentity;

			};
		sleep 0.5;
		};
	} foreach AllUnits;
	sleep 30;
}