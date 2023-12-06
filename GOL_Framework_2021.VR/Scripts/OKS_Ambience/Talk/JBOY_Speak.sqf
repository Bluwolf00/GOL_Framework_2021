		if (!isServer)  exitwith {};

		params["_unit","_soundFileName","_Debug_Variable"];

		if (isNull _unit or !alive _unit) exitWith {};

		_speaker = "";
		if (isNull _unit) exitwith {};

		_speaker = speaker _unit;
		_behaviour = behaviour _unit;

		if (["CARELESS","AWARE"] find _behaviour >= 0) then {_behaviour = "NORMAL";}; // No sound file path exists for "CARELESS","AWARE"
		_s = format["JBOY_Speak: No match found for _soundFileName %1",_soundFileName];

		_lastSubDir = "100_Commands"; // most stack related commands are in this subdirectory
		switch (true) do 
		{ 	
			case (_soundFileName find "OnTheWay_1" >= 0):{_lastSubDir = "130_Com_Reply"; };
			case (_soundFileName find "Engage" >= 0):{_lastSubDir = "015_Targeting"; };
			case (_soundFileName find "Attack" >= 0):{_lastSubDir = "015_Targeting"; };
			case (_soundFileName find "moveUp" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
			case (_soundFileName find "moveBack" >= 0):{_lastSubDir = "070_MoveDirectionRelative1"; };
		};
		
		switch (alive _unit) do 
		{ 	
			case (_speaker find "eng" >= 0 and _soundFileName == 'Clear'): {_s = "a3\dubbing_f_bootcamp\boot_m04\85_All_Clear\boot_m04_85_all_clear_LAC_0.ogg";};
			// sounds per language
			case (_speaker find "pervr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolPER\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "grevr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolGRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "engvr" >= 0): {_s = "A3\Dubbing_Radio_F\data\VR\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "engb" >= 0): {_s = "A3\Dubbing_Radio_F\data\ENGB\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "engfre" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\ENGFRE\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "eng" >= 0): {_s = "A3\Dubbing_Radio_F\data\ENG\"+_speaker+"\RadioProtocolENG\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "gre" >= 0): {_s = "A3\Dubbing_Radio_F\data\GRE\"+_speaker+"\RadioProtocolGRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "per" >= 0): {_s = "A3\Dubbing_Radio_F\data\PER\"+_speaker+"\RadioProtocolPER\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "fre" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\FRE\"+_speaker+"\RadioProtocolFRE\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "chi" >= 0): {_s = "A3\Dubbing_Radio_F_EXP\data\CHI\"+_speaker+"\RadioProtocolCHI\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "pol" >= 0): {_s = "A3\Dubbing_Radio_F_Enoch\data\POL\"+_speaker+"\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};
			case (_speaker find "rus" >= 0): {_s = "A3\Dubbing_Radio_F_Enoch\data\RUS\"+_speaker+"\"+_behaviour+"\"+_lastSubDir+"\" + _soundFileName + ".ogg";};

			};

		if (!isNull _unit and alive _unit) then
		{
			if(_Debug_Variable) then {
				SystemChat format["%1 spoke %2",_unit,_soundFileName];
			};
			playSound3D [_s, _unit];
		};