#define	COMPONENT CORE
#define VERSION 1
#define CUSTOM_FOLDER Core\Framework\Functions
#include "script_Component.hpp"

LOG("postInit started");
if (isServer) then {
	LOG("Loading Server Variables");
	GVARMAIN(MACHINE) = "SERVER";
	["server"] call CBA_settings_fnc_clear;

	if (call EFUNC(Common,isDevBuild)) then {
		LOG("devBuild started");
		{
			deleteVehicle _x;
		} forEach switchableUnits;
	} else {
		{
			_x disableAI "All";
		} forEach switchableUnits;
	};
};

if (hasInterface) then {
	LOG("Loading Player Variables");
	player addRating 100000;
	player disableConversation true;
	player enableWeaponDisassembly false;	// 1.67
//	disableRemoteSensors true;
	enableEnvironment true;
	setCompassOscillation [(rad 5), 0.1, 1];
	player setVariable ["BIS_noCoreConversations", true, true];
	player setVariable ["BIS_enableRandomization", false, true];

	GVARMAIN(MACHINE) = str(player);
	GVARMAIN(logModules) sort false;
	player createDiarySubject ["framework_diary","Modules Loaded"];
	{
		player createDiaryRecord ["framework_diary", [FORMAT_1("%1", (_x select 0)),
			FORMAT_3("Version: %2  by %1, <br/>Description: %3", (_x select 1), (_x select 2), (_x select 3))
		]];
	} forEach GVARMAIN(logModules);

	[{
		private _framework = "==============================================
				<br/>
				<br/>	Framework by: GuzzenVonLidl
				<br/>	Version: "+GVARMAIN(Version)+"
				<br/>
				<br/>	==============================================
				<br/>
				<br/>	Guerrillas of Liberation
				<br/>	Teamspeak: teamspeak.gol-clan.co.uk
				<br/>	Website: http://www.gol-clan.co.uk/
				<br/>	==============================================";
		player createDiaryRecord ["framework_diary", ["Framework",_framework]];
	}, []] call CBA_Fnc_execNextFrame;
};

{
	[] call compile preprocessFileLineNumbers ("Modules\" + (_x select 0) +"\" + (_x select 1));
	LOG(FORMAT_1("Module postInit: %1", (_x select 0)));
} forEach GVARMAIN(postLoad);
LOG(FORMAT_1("Modules Settings: %1", (count GVARMAIN(postLoad))));
GVARMAIN(postLoad) = nil;

["CBA_settingsInitialized", {
	[] spawn {
		uisleep 0.1;
		["CBA_settingsInitializedDelayed", []] call CBA_fnc_localEvent;
	};
}] call CBA_fnc_addEventHandler;

[{(getClientStateNumber >= 9) || !isMultiplayer}, {
	LOG("Event mapLoaded");
	[QGVARMAIN(mapLoaded), []] call CBA_fnc_localEvent;
}, []] call CBA_fnc_waitUntilAndExecute;

[{(getClientStateNumber >= 10) || !isMultiplayer}, {
	LOG("Event missionLoaded");
	[QGVARMAIN(missionLoaded), []] call CBA_fnc_localEvent;

	[{
		LOG("Event missionStarted");
		[QGVARMAIN(missionStarted), []] call CBA_fnc_localEvent;

		if (isServer) then {
			LOG("Loading Server Settings");
			private ["_LogicCenter","_moduleGroup"];
			_LogicCenter = createCenter sideLogic;
			_moduleGroup = createGroup _LogicCenter;

			GVARMAIN(Gamelogic) = createVehicle ["Land_Matches_F", [0,0,0], [], 0, "CAN_COLLIDE"];
			GVARMAIN(Gamelogic) enableSimulationGlobal false;
			GVARMAIN(Gamelogic) hideObjectGlobal true;
			publicVariable QGVARMAIN(Gamelogic);

			GVARMAIN(ZeuzModuleAdminLogged) = _moduleGroup createUnit ["ModuleCurator_F",[0,0,0],[],0,"CAN_COLLIDE"];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Owner", "#adminLogged", true];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Name", "AdminZeus", true];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Addons", 3, true];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["Forced", 0, true];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["birdType", "", true];
			GVARMAIN(ZeuzModuleAdminLogged) setVariable ["showNotification", false, true];
			publicVariable QGVARMAIN(ZeuzModuleAdminLogged);

			[QGVARMAIN(serverReady), []] call CBA_fnc_localEvent;
		};

		if (hasInterface) then {
			if ((getPlayerUID player) in getArray(missionConfigFile >> "GW_FRAMEWORK" >> "Naming" >> "AuthorUID")) then {
				[QGVARMAIN(AddAdmin), player] call CBA_fnc_localEvent;
			};

			if (isMultiplayer && !(call EFUNC(Common,isDevBuild))) then {
				cutText ["Finalizing Settings","BLACK FADED",10];
				GVARMAIN(blockMovement) = player addeventhandler ["animChanged",{player switchMove "AmovPercMstpSnonWnonDnon_Ease";}];

				[{
					if !(isNil QGVARMAIN(blockMovement)) then {
						player removeEventHandler ["animChanged", GVARMAIN(blockMovement)];
					} else {
						systemChat "ERROR: Failed to load, rejoin mission";
//						"end1" call BIS_fnc_endMission;
					};
					player playMoveNow "AmovPercMstpSnonWnonDnon_EaseOut";
					player playMoveNow "AmovPknlMstpSlowWrflDnon";
					cutText ["","BLACK IN",10];
				}, [], 4.5] call CBA_fnc_waitAndExecute;
			};

			[QGVARMAIN(playerReady), []] call CBA_fnc_localEvent;
		};

		if (CBA_isHeadlessClient) then {
			[QGVARMAIN(headlessReady), []] call CBA_fnc_localEvent;
		};
	}, [], 0.5] call CBA_fnc_waitAndExecute;
}, []] call CBA_fnc_waitUntilAndExecute;

LOG("postInit finished");
