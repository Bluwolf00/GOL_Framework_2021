    // OKS_CreateUnitMarker
    // [_marker,_Side,"mechanized",_Count] spawn OKS_CreateUnitMarker;
    // _null = ["respawn_west",east,"mechanized",10] execVM "Scripts\OKS_Dynamic\OKS_CreateUnitMarker.sqf";
	Params["_Marker","_Side","_Type","_CountUnits","_Size"];

	private ["_marker","_sideMarker","_UnitType"];
	private _Debug_Variable = false;
	_sideMarker = "";
	_UnitType = "";
	// [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,0,_MainTriggerAngle,"colorGreen",0.5,"RECTANGLE"]

	switch (_Side) do {
		case west: {_Marker setMarkerColor "colorBLUFOR"; _sideMarker ="b_"};
		case east: {_Marker setMarkerColor "colorOPFOR"; _sideMarker ="o_"};
		case independent: {_Marker setMarkerColor "colorINDEPENDENT"; _sideMarker ="n_"};
	};

	switch (_Type) do {
		case "infantry":{_UnitType = "inf"};
		case "motorised":{_UnitType = "motor_inf"};
		case "mechanized":{_UnitType = "mech_inf"};
		case "armor":{_UnitType = "armor"};
	};
	_Marker setMarkerType format["%1%2",_sideMarker,_UnitType];
	_Marker setMarkerSize [_Size,_Size];

	private _sizeMarker = createMarker [format ["oks_UnitSizeMarker_%1",str round(random 80000 + random 9999)],getMarkerPos _Marker];
	_sizeMarker setMarkerSize [(_Size * 2),(_Size * 2)];
	_sizeMarker setMarkerShape "ICON";


	switch (true) do {
		case (_CountUnits > 0 && _CountUnits <= 5):{ if(_Debug_Variable) then {systemChat "FireTeam"}; _sizeMarker setMarkerType "group_0"};
		case (_CountUnits > 5 && _CountUnits <= 12):{ if(_Debug_Variable) then {systemChat "Squad"}; _sizeMarker setMarkerType "group_1"};
		case (_CountUnits > 12 && _CountUnits <= 25):{ if(_Debug_Variable) then {systemChat "Section"}; _sizeMarker setMarkerType "group_2"};
		case (_CountUnits > 25 && _CountUnits <= 75):{ if(_Debug_Variable) then {systemChat "Platoon"}; _sizeMarker setMarkerType "group_3"};
		case (_CountUnits > 75):{if(_Debug_Variable) then {systemChat "Company"}; _sizeMarker setMarkerType "group_4"};
 	};
