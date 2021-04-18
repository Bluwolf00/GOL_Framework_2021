/*

	_null = [east,"african"] execVM "OKS_FaceSwap.sqf";
	[civilian_1,"african"] execVM "OKS_FaceSwap.sqf";

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

	case "white":
	{
		OKS_faces = [""];
	};

	case "arab":
	{
		OKS_faces = [""];
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