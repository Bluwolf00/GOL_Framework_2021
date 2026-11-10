//	#include NEKY_Settings;
//
//	Settings for NEKY_Paradrop
//
//	Made by NeKo-ArroW
//	Version 1.01

if (isNil "NEKY_Paradrop_AllowReinsert") then
{
	NEKY_Paradrop_AllowReinsert = True;	// Allow people to reinsert using paradrop addaction. (You can change this mid-game)
};
Private "_Settings_MarkerColor";

switch (OKS_FRIENDLY_SIDE) do {

	case west: {
		_Settings_MarkerColor = "ColorBlufor";
	};
	case east: {
		_Settings_MarkerColor = "ColorOpfor";
	};
	case independent: {
		_Settings_MarkerColor = "ColorIndependent";
	};
	default{
		_Settings_MarkerColor = "ColorBlack";
	}
};
