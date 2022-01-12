//	[Side] Call OKS_Support_Settings;
//
//	Settings for OKS Support.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_AircraftClassname"];

switch (_Side) do
{
	case west:
	{
		_AircraftClassname = "RHSGREF_A29B_HIDF";
	};
	case east:
	{
		_AircraftClassname = "RHS_Su25SM_vvsc";
	};
	case independent:
	{
		_AircraftClassname = "rhsgref_cdf_su25";
	};
	default
	{
		_AircraftClassname = "B_Plane_CAS_01_F";
	};
};

// DO NOT EDIT ANYTHING BELOW \\
_AircraftClassname
