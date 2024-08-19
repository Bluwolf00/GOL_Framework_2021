
/*
 	Parameters:
	Player - Player Variable
*/

Params ["_Player"];

if (isMultiplayer || isDedicated) then
{
    waitUntil{
		sleep 0.5;
        !isNil "TFAR_fnc_activeSWRadio" &&
        !isNil "TFAR_fnc_activeLrRadio" && 
        !isNil "TFAR_fnc_radiosList" && 
        !isNil "TFAR_fnc_setSwVolume" &&
        !isNil "TFAR_fnc_setLrVolume"
    };
    _radiosSW = _Player call TFAR_fnc_radiosList;
    _activeLR = _Player call TFAR_fnc_haveLRRadio;

    if(!isNil "_radiosSW") then {
        private _i = 0;
        {
            private _volume = 5;
            if(_i == 1) then {
                _volume = 6;
                [_X, 4] call TFAR_fnc_setSwChannel;
            } else {
				[_X, _volume] call TFAR_fnc_setSwVolume;
			};		
            _i = _i + 1;
        } foreach _radiosSW;
    };

    if(_activeLR == true) then {		
        [_Player call TFAR_fnc_activeLrRadio, 6] call TFAR_fnc_setLrVolume; 
        [_Player call TFAR_fnc_activeLrRadio, 4] call TFAR_fnc_setLrChannel;
		[_Player call TFAR_fnc_activeLrRadio, 2] call TFAR_fnc_setLrStereo;
    };	
};