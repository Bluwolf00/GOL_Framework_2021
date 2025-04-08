with uiNamespace do { 
	private _display = finddisplay 12; 
	private _RscCheckbox_2800 = _display ctrlCreate ["RscCheckbox", 2800]; 
	_RscCheckbox_2800 ctrlSetPosition [0.965937 * safezoneW + safezoneX, 0.948 * safezoneH + safezoneY, 0.018125 * safezoneW, 0.0336666 * safezoneH]; 
	_RscCheckbox_2800 ctrlSetTooltip "Show Unit Markers: ON"; 
	_RscCheckbox_2800 cbSetChecked true; 
	_RscCheckbox_2800 ctrlSetBackgroundColor [0,0.5,0,1]; 
	_RscCheckbox_2800 ctrlCommit 0; 
	_RscCheckbox_2800 ctrlAddEventHandler ["CheckedChanged",
	{ 
		params ["_control", "_checked"]; 

		if (_checked == 1) then  
		{ 
			setGroupIconsVisible [true,true]; 
			setGroupIconsSelectable true; 
			disableMapIndicators [RKAGHideFriendlyForces,true,false,false]; 
			RKAGShowGroups = true; 
			_control ctrlSetTooltip "Show Unit Markers: ON"; 
		} 
		else  
		{ 
			setGroupIconsVisible [false,false]; 
			setGroupIconsSelectable false; 
			RKAGShowGroups = false; 
			_control ctrlSetTooltip "Show Unit Markers: OFF"; 
		}; 
	}]; 
}; 
