# Spawn Multiplier — Implementation Pattern

Apply `GOL_SpawnMultiplier` support to a spawn script in the GOL Framework.

## What it does

`GOL_SpawnMultiplier` is a mission parameter (set in `Description.ext` under `class Params`) that lets admins reduce AI spawns globally from 100% down to 10%, in 10% steps. When the handler fires, unit and vehicle arrays are randomly trimmed to the selected percentage before spawning. Count always rounds **up** so at least 1 unit/vehicle is kept.

## Where it lives

- **Parameter definition**: `Description.ext` → `class Params` → `class SpawnMultiplier`
- **Variable name**: `GOL_SpawnMultiplier` (set globally via the `variable` field, default `100`)
- **Core logic**: `Modules\Common\Functions\fnc_spawnHandler.sqf` — applied once just before the unit-spawn `forEach` loop

## Rules for applying to a new spawn script

1. **Only apply when the script directly iterates a unit/vehicle array to spawn units.** Do not apply if the script delegates to `FUNC(spawnHandler)` — it already inherits the multiplier there.
2. Read the variable with a default fallback: `missionNamespace getVariable ["GOL_SpawnMultiplier", 100]`
3. Only modify arrays when `_multiplier < 100` to avoid unnecessary work at full strength.
4. Shuffle the array first (`BIS_fnc_arrayShuffle`), then trim with `select [0, _keepCount]`.
5. Use `ceil` for rounding so the result always rounds up.
6. Apply to both `_unitArray` and `_vehicleArray` (when present and > 0).

## How the variable is set

`GOL_SpawnMultiplier` is initialized in `Modules\Common\postInit.sqf` on every machine at mission start:

```sqf
GOL_SpawnMultiplier = 100;
{
	if (configName _x isEqualTo "SpawnMultiplier") exitWith {
		GOL_SpawnMultiplier = paramsArray select _forEachIndex;
	};
} forEach (configProperties [missionConfigFile >> "Params", "isClass _x", true]);
```

`configProperties` + `paramsArray` is the only reliable way to look up a param by class name. `BIS_fnc_getParamValue` only accepts a numeric index — passing a string always returns the default.

## Blacklisting a spawn from the multiplier

Pass `true` as the 5th argument to `GW_Common_fnc_spawnGroup` to exempt a specific spawn entirely from the multiplier. The 4th argument is always the side.

```sqf
// Normal spawn — affected by multiplier
[_unitArray, _vehicleArray, _waypointArray, east] call GW_Common_fnc_spawnGroup;

// Blacklisted spawn — always spawns full strength regardless of multiplier
[_unitArray, _vehicleArray, _waypointArray, east, true] call GW_Common_fnc_spawnGroup;
```

Use this for spawns that are scripted/required (e.g. convoy escorts, counter-attack lines, objective guards that must always be present).

**`fnc_spawnGroup` signature:**
```
#0: ARRAY  - unit array
#1: ARRAY  - vehicle array
#2: ARRAY  - waypoint array
#3: SIDE   - faction (default: GVAR(Faction))
#4: BOOL   - blacklist from spawn multiplier (default: false)
```

Note: `_skipQueue` and `_skipDelays` were removed from the mission-editor-facing signature — they are hardcoded to `false` internally when delegating to `spawnHandler`.

## Code block to insert

Place this block **after** the `params [...]` block and **before** the first spawn loop:

```sqf
private _multiplier = missionNamespace getVariable ["GOL_SpawnMultiplier", 100];
if (_multiplier < 100) then {
	if ((count _unitArray) > 0) then {
		private _keepCount = ceil ((count _unitArray) * (_multiplier / 100));
		_unitArray = _unitArray call BIS_fnc_arrayShuffle;
		_unitArray = _unitArray select [0, _keepCount];
	};
	if ((count _vehicleArray) > 0) then {
		private _keepCount = ceil ((count _vehicleArray) * (_multiplier / 100));
		_vehicleArray = _vehicleArray call BIS_fnc_arrayShuffle;
		_vehicleArray = _vehicleArray select [0, _keepCount];
	};
};
```

## Scripts already covered

| Script | Status | Notes |
|---|---|---|
| `fnc_spawnHandler.sqf` | Implemented | All callers inherit this automatically |
| `fnc_spawnGroup.sqf` | Inherited | Delegates to `spawnHandler` |
| `fnc_spawn3DEN.sqf` | Not applicable | Eden editor preview only, no live spawning |
| `fnc_spawnObjects.sqf` | Not applicable | Props/objects only, not AI units |

## Description.ext reference

Add to `class Params` — no `function` callback required. `BIS_fnc_getParamValue` reads the selected value by class name at call time, available on all machines.

```cpp
class SpawnMultiplier
{
	title = "Spawn Multiplier";
	texts[] = { "100%", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%" };
	values[] = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 };
	default = 100;
};
```
