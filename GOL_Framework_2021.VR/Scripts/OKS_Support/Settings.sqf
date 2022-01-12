//	[Side] Call OKS_Support_Settings;
//
//	Settings for OKS Support.
//
//	Returns: [Settings]

Params["_Side"];
Private ["_AircraftClassname","_Timer"];

/* Select Aircraft Class based on Player Side */
switch (_Side) do
{
	case west:
	{
		_AircraftClassname = "B_Plane_CAS_01_F";
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

/* CAS 'Respawn' Time in seconds */
_Timer = 10;

// DO NOT EDIT ANYTHING BELOW \\
[_AircraftClassname,_Timer]
