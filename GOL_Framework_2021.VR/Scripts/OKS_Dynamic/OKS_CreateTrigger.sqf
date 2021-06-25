    // OKS_CreateTrigger

	Params["_Trigger","_sizeA","_sizeB","_trueAngle","_Angle","_Multiplier","_isRectangle"];
	Private ["_Debug_Variable"];
	_Debug_Variable = false;

	// [_MainTrigger,_MainTriggerSizeA,_MainTriggerSizeB,0,_MainTriggerAngle,0.5,_MainTriggerIsRectangle]
	_trg = createTrigger ["EmptyDetector", _Trigger getPos [_sizeA * (_Multiplier select 0),_trueAngle + _Angle]];
	_trg setTriggerArea [_sizeA * (_Multiplier select 1), _sizeB * (_Multiplier select 2), _Angle, _isRectangle];

	if(_Debug_Variable) then {
		_trg setTriggerActivation ["ANYPLAYER","PRESENT",false];
		_trg setTriggerStatements ["this", format ["hint 'Activated Trigger %1'",_trueAngle], ""];
	};

	_trg