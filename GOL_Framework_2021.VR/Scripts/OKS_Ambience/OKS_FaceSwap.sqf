/*

	_null = [east,"african"] execVM "OKS_FaceSwap.sqf";
	[civilian_1,"african"] execVM "Scripts\OKS_Ambience\OKS_FaceSwap.sqf";

	Apply in Init.sqf like this at the end of code:

	if(isServer) then {
		[civilian_1,"african"] execVM "Scripts\OKS_Ambience\OKS_FaceSwap.sqf";
	};

	Options:
	african
	asian
	english
	american
	middleeast
	russian
	french
	greek
	polish

*/

Params
[
	["_Faction", East, [sideUnknown,ObjNull]],
	["_Face", "african", [""]]
];

Private ["_OKS_faces","_OKS_speakers"];

switch (_Face) do
{

	case "polish":{
		_OKS_faces = [
			"LivonianHead_5","LivonianHead_2","Ioannou","LivonianHead_7","LivonianHead_6","LivonianHead_3","LivonianHead_1","LivonianHead_10",
			"LivonianHead_8","LivonianHead_4","LivonianHead_9"
		];
		_OKS_speakers = ["Male01POL","Male02POL","Male03POL"];	
	};

	case "greek":{
		_OKS_faces = [
			"GreekHead_A3_13","GreekHead_A3_01","GreekHead_A3_02","GreekHead_A3_07","GreekHead_A3_03","GreekHead_A3_04","GreekHead_A3_14",
			"GreekHead_A3_05","GreekHead_A3_11","GreekHead_A3_06","GreekHead_A3_08","GreekHead_A3_12","Mavros","GreekHead_A3_09"
		];
		_OKS_speakers = ["Male01GRE","Male02GRE","Male03GRE","Male04GRE","Male05GRE","Male06GRE"];		
	};

	case "african":
	{
		_OKS_faces = [
			"Barklem","TanoanHead_A3_03","TanoanHead_A3_04","AfricanHead_02","AfricanHead_03","TanoanHead_A3_05",
			"TanoanHead_A3_07","TanoanHead_A3_01","TanoanHead_A3_06","TanoanHead_A3_08","AfricanHead_01","TanoanHead_A3_02","TanoanHead_A3_09"
		];
		_OKS_speakers = ["Male01FRE","Male02FRE","Male03FRE"];
	};

	case "asian":
	{
		_OKS_faces = ["AsianHead_A3_01","AsianHead_A3_07","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_02","AsianHead_A3_05"];
		_OKS_speakers = ["Male01CHI","Male02CHI","Male03CHI"];
	};

	case "american":
	{
		_OKS_faces = [
			"WhiteHead_31","Sturrock","WhiteHead_30","WhiteHead_32","WhiteHead_28","WhiteHead_27","WhiteHead_01",
			"WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08",
			"WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13",
			"WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20",
			"WhiteHead_21","WhiteHead_22","WhiteHead_23","WhiteHead_24","WhiteHead_25","WhiteHead_26"
		];
		_OKS_speakers = ["Male01ENG","Male02ENG","Male03ENG","Male04ENG","Male05ENG","Male06ENG","Male07ENG","Male08ENG","Male09ENG","Male010ENG","Male11ENG","Male12ENG"];
	};

	case "english":
	{
		_OKS_faces = [
			"WhiteHead_31","Sturrock","WhiteHead_30","WhiteHead_32","WhiteHead_28","WhiteHead_27","WhiteHead_01",
			"WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08",
			"WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13",
			"WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20",
			"WhiteHead_21","WhiteHead_22","WhiteHead_23","WhiteHead_24","WhiteHead_25","WhiteHead_26"
		];
		_OKS_speakers = ["Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB","Male05ENGB"];
	};

	case "french":
	{
		_OKS_faces = [
			"WhiteHead_31","Sturrock","WhiteHead_30","WhiteHead_32","WhiteHead_28","WhiteHead_27","WhiteHead_01",
			"WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08",
			"WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13",
			"WhiteHead_14","WhiteHead_15","WhiteHead_16","WhiteHead_17","WhiteHead_18","WhiteHead_19","WhiteHead_20",
			"WhiteHead_21","WhiteHead_22","WhiteHead_23","WhiteHead_24","WhiteHead_25","WhiteHead_26"
		];
		_OKS_speakers = ["Male01FRE","Male02FRE","Male03FRE","Male01ENGFRE","Male02ENGFRE"];
	};

	case "middleeast":
	{
		_OKS_faces = ["PersianHead_A3_01","PersianHead_A3_02","PersianHead_A3_03"];
		_OKS_speakers = ["Male01PER","Male02PER","Male03PER"];
	};

	case "russian":
	{
		_OKS_faces = ["RussianHead_1","RussianHead_2","RussianHead_3","RussianHead_4","RussianHead_5","RussianHead_4","RussianHead_1"];
		_OKS_speakers = ["Male01RUS","Male02RUS","Male03RUS","RHS_Male01RUS","RHS_Male02RUS","RHS_Male03RUS","RHS_Male04RUS","RHS_Male052US"];
	};

	default{
		_OKS_faces = ["AsianHead_A3_01","AsianHead_A3_07","AsianHead_A3_03","AsianHead_A3_04","AsianHead_A3_02","AsianHead_A3_05"];
		_OKS_speakers = ["Male01CHI","Male02CHI","Male03CHI"];
		SystemChat "OKS_FACESWAP - No faction found - Default";
	};


};

if(typeName _Faction == "OBJECT") exitWith {
	_Faction setVariable ["OKS_FaceSwap",true];
	_Face = (selectRandom _OKS_faces);
	_Voice = (selectRandom _OKS_speakers);
	_Faction setSpeaker _Voice;
	_Faction setFace _Face;
	[_Faction,_Face,_Voice] call BIS_fnc_setIdentity;
};
while {true} do
{

	{
		if((side _X == _Faction || side _X == civilian) && !(isPlayer _X) && !(_X getVariable["OKS_FaceSwap",false])) then
		{

			_X setVariable ["OKS_FaceSwap",true];
			_Face = (selectRandom _OKS_faces);
			_Voice = (selectRandom _OKS_speakers);
			_X setSpeaker _Voice;
			_X setFace _Face;
			[_X,_Face,_Voice] call BIS_fnc_setIdentity;
			sleep 0.05;
		};
	} foreach AllUnits;
	sleep 15;
};


