//	[Object, SpawnPos, Direction, ["Vehicle Types"]] execVM "Scripts\VehicleRequest.sqf";
//	
//	1. Object
//	  a) The object which the addaction is to be attached to.
//	2. SpawnPos
//	  a) The position where the vehicle will spawn.
//	  b) Also supports marker position.
//	  c) If the vehicle collision box is too close to an object, it will be moved up to 6 meters in the direction it will be facing.
//	3. Direction
//	  a) The direction the vehicle will face when spawned.
//	4. ["Vehicle Types"]
//	  a) What vehicle types will be selectable in the list of addactions.
//	  b) Available types: Car  IFV  Helicopter  Plane  Tank
//	
//	
//	Made by NeKo-ArroW
//	Version 0.9

Params
[
	["_Laptop", ObjNull, [ObjNull]],
	["_SpawnPos", [], [[],""]],
	["_Dir", 0, [0]],
	["_VehTypes", [], [[]]]
];

// Exits
if (isNull _Laptop) exitWith {};
if (TypeName _SpawnPos == "STRING") then { _SpawnPos = markerPos _SpawnPos };
if (Count _SpawnPos < 2) exitWith {};
if (Count _VehTypes == 0) exitWith {};

// Filter
_VehTypes = _VehTypes apply {toLower _x};
_Filter = [];
_Kind = "";
_Image = "";
{
	Switch _x do 
	{
		case "car": { _Filter pushBack "car"; _Kind = "Car"; _Image = "Images\cars.jpg" };
		case "ifv": { _Filter pushBack "car"; _Kind = "Armored"; _Image = "Images\ifv.jpg" };
		case "tank": { _Filter pushBack "tank"; _Image = "Images\tanks.jpg" };
		case "helicopter": { _Filter pushBack "helicopter"; _Image = "Images\helicopter.jpg"  };
		case "plane": { _Filter pushBack "plane"; _Image = "Images\plane.jpg"  };
		default { systemChat "DEBUG VehicleRequest.sqf - Unknown type" };
	};
} forEach _VehTypes;

_Laptop setObjectTextureGlobal [0,_Image];

// Define Vehicles
_C1 = Format ["_TempVehClass = ConfigName _x; (getNumber (_x >> 'Scope') == 2) && (({ _TempVehClass isKindOf _x } count %1) != 0)", _Filter];
_C2 = if (_Kind != "") then { Format [" && (getText (_x >> 'VehicleClass') == '%1')", _Kind] } else { "" };
_Cond = if (_C2 == "") then { _C1 } else { (_C1 + _C2) };
_Array = _Cond ConfigClasses (ConfigFile >> "CfgVehicles");
_Array = _Array Apply { ConfigName _x };
_Array = [_Array, [], {getText (configFile >> "CfgVehicles" >> _X >> "DisplayName")}, "ASCEND"] call BIS_fnc_sortBy;

// AddActions
_Filter = [];	// To avoid having each scheme of same vehicles appear.
{
	// Variables
	_Veh = _x;
	_Name = getText (configFile >> "CfgVehicles" >> _Veh >> "DisplayName");
	if !(_Name in _Filter) then 
	{
		_Filter pushBack _Name;
		_NameC = Format ["Request <t color='#99FF00'>%1</t>",_Name];
		
		// AddAction
		_Laptop addAction [_NameC,
		{
			Params ["_Laptop","","","_Args"];
			_Args Params ["_Veh","_Name","_SpawnPos","_Dir"];
			
			// Define Variables
			_Available = False;
			_Loop = 0;
			
			// Measure Vehicle Size
			_Ref = _Veh CreateVehicleLocal [0,0,0];
			_Ref setDir _Dir;
			_Ref enableSimulation False;
			_Box = BoundingBox _Ref;
			DeleteVehicle _Ref;
			
			_Box Params ["_BoxA","_BoxB"];
			_BoxB Params ["_Width","_Length","_Height"];
			_Size = _Length Max _Width;
			_Big = _Size > 4;
			_Size = _Size Max 5;
			_Size = _Size * 1.2;

			_Near = _SpawnPos nearEntities ["Air", 15];
			_Near = _Near select 
			{
				_V = _x;
				!isPlayer _V 
					&& 
				({ Alive _x } count (Crew _V) == 0)
					&& 
				(_x isKindOf "AllVehicles")
			};	
			{ deleteVehicle _x } forEach _Near;

			sleep 2;

			// Check for space
			_Near = _SpawnPos nearEntities ["Air", 5];
			_Available = Count _Near == 0;
			
			// Disable multi-use
			if (_Laptop getVariable ["NEKY_VehicleRequest_Spawning",False]) exitWith { SystemChat "Vehicle request already in progress, please wait." };
			_Laptop setVariable ["NEKY_VehicleRequest_Spawning",True,True];
			
			// Create Vehicle
			if (_Available) then 
			{
				// Dummy Model
				_Dummy = "Land_HelipadEmpty_F" CreateVehicleLocal [0,0,0];
				_Dummy setPos _SpawnPos;
				_Dummy setDir _Dir;
				
				// Define Positions
				_Positions = [ [_BoxA#0,_BoxA#1,0], [0,_BoxA#1,0], [_BoxB#0,_BoxA#1,0], [_BoxB#0,0,0], [_BoxB#0,_BoxB#1,0], [0,_BoxB#1,0], [_BoxA#0,_BoxB#1,0], [_BoxA#0,0,0] ];
				_Positions = _Positions Apply { _Dummy ModelToWorld _x };
				
				// Warning Lights
				_Spheres = [];
				_SphereClass = ["Sign_Sphere25cm_F","Sign_Sphere100cm_F"] select _Big;
				For "_y" from 0 to 2 step 1 do
				{
					For "_i" from 0 to 7 step 1 do 
					{
						_Pos = _Positions#_i;
						_Z = _Height * _y;
						_Pos set [2,_Z];
						_Light = CreateVehicle [_SphereClass, _Pos, [], 0, "CAN_COLLIDE"];
						_Light setVectorUp surfaceNormal position _Light;
						_Spheres pushBack _Light;
					};
					
					// Delay
					Sleep 1;
				};
				
				// Creation of Vehicle
				_Spawned = CreateVehicle [_Veh, _SpawnPos, [], 0, "CAN_COLLIDE"];
				_Spawned setDir _Dir;
				
				// Clean up
				{ DeleteVehicle _x } forEach (_Spheres + [_Dummy]);
				
				SystemChat Format ["%1 has been delivered.",_Name];
			} else {
				SystemChat Format ["Unable to deliver %1. There is something blocking it.",_Name];
			};
			
			// Enable use again
			_Laptop setVariable ["NEKY_VehicleRequest_Spawning",False,True];
		}, [_Veh, _Name, _SpawnPos, _Dir], 0, false, true, "", "", 4];
	};
} forEach _Array;

// Clear actions
_Laptop AddAction ["<t color='#FF0000'>Clear Area of vehicles 10m</t>",
{
	Params ["","","","_Args"];
	_Args Params ["_SpawnPos","_VehTypes"];
	
	_Near = _SpawnPos nearEntities 10;
	_Near = _Near select 
	{
		_V = _x;
		!isPlayer _V 
			&& 
		({ Alive _x } count (Crew _V) == 0)
			&& 
		(_x isKindOf "AllVehicles")
	};
	
	{ deleteVehicle _x } forEach _Near;
}, [_SpawnPos,_VehTypes], 1, false, true, "", "", 4];