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

_Settings_MarkerColor = "ColorBlufor";		// The color of the paradrop marker. Type "AUTO" for it to pick based on your faction (BLUFOR, OPFOR, INDEPENDENT).