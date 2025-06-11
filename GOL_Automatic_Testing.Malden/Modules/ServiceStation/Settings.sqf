
/////////////////////
// Service Station //
/////////////////////
// General
_Radius = 8;								// Area (meters) the SS will scan for vehicles.
_Lights = True;								// Blinking lights on/off. True = on.

// Repair
_InspectionSpeed = 0.25;					// Time in seconds it takes to inspect each part of the vehicle.
_RepairingSpeed = 0.1;						// Percent of maximum HP (per part) repaired (ground vehicles and heli) per second.	0 = 0%, 1 = 100%.
_RepairingTrackSpeed = 0.05;				// Percent of maximum HP of left and right Track (per track)(Tanks) repaired per second. 0 = 0%, 1 = 100%.
_RemoveWheelSpeed = 5;						// Time in seconds it takes to remove a damaged wheel.
_MountWheelSpeed = 2.5;						// Time in seconds it takes to mount a new wheel.

// Refuel
_Refueling = 0.025;							// Percent of maximum fuel refueled per second. 0 = 0%, 1 = 100%.

// Rearm
_RearmSpeed = 0.17;							// Percent of maximum ammo (for each weapon) rearmed per second. 0 = 0%, 1 = 100%.

////////////////////////////
// Mobile Service Station //
////////////////////////////
// General
_MRadius = 20;								// Area (meters) the Mobile SS will scan for vehicles.
