    // OKS_CreateMarker

	Params["_Trigger","_sizeA","_sizeB","_trueAngle","_Angle","_Color","_Multiplier","_Shape"];

	private ["_marker"];

	// [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,0,_MainTriggerAngle,"colorGreen",0.5,"RECTANGLE"]
	_marker = createMarker [format ["oks_Marker_%1",str round(random 80000 + random 9999)],_Trigger getPos [_sizeA * (_Multiplier select 0) , _trueAngle + _Angle]];
	_marker setMarkerSize [_sizeA * (_Multiplier select 1),_sizeB * (_Multiplier select 2)];
	_marker setMarkerDir _Angle;

	if(_Debug_Variable) then {
		_marker setMarkerColor _Color;
		_marker setMarkerShape _Shape;
		_marker setMarkerBrush "DiagGrid";
		_marker setMarkerAlpha 0.7;
	} else {
		_marker setMarkerAlpha 0;
	};

	_marker