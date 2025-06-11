
#define PREFIX GW

#ifndef isDescription	// Will crash on server otherwise
	#include "\x\cba\addons\main\script_macros_mission.hpp"
#endif

/* -------------------------------------------
Group: General
------------------------------------------- */
// Custom

#define	DEVCONSOLE(VAR1)	"debug_console" callExtension (VAR1)

#define conBeep DEVCONSOLE("A")
#define conClear DEVCONSOLE("C")
#define conClose DEVCONSOLE("X")

// *************************************	// Do not edit below
// Internal
#define	FALSE -1
#define	TRUE -2
#define PRIVATE 0
#define PUBLIC 2

#define MAJOR 0
#define MINOR 7
#define PATCHLVL 0
#define BUILD 100418	// We will use the DATE for the BUILD# in the format DDMMYY
#define VERSION MAJOR.MINOR.PATCHLVL.BUILD

#define COMPONENTPATH(var1) CUSTOM_FOLDER\fnc_##var1.sqf
#define PREP(var1) ##ADDON##_fnc_##var1 = compile preProcessFileLineNumbers QUOTE(COMPONENTPATH(var1));
#define PREPMAIN(var1) ##PREFIX##_fnc_##var1 = compile preProcessFileLineNumbers QUOTE(COMPONENTPATH(var1));
#define PREPMAINFOLDER(var1) ##PREFIX##_fnc_##var1 = compile preProcessFileLineNumbers QUOTE(var1.sqf);

#define RANDOM_PICTURES __EVAL(selectRandom [ \
	'\x\gw\addons\ui\data\official_a3.jpg', \
	'\x\gw\addons\ui\data\official_a3_2.jpg', \
	'\x\gw\addons\ui\data\official_apex.jpg', \
	'\x\gw\addons\ui\data\official_eden.jpg', \
	'\x\gw\addons\ui\data\official_firing_veh_2.jpg', \
	'\x\gw\addons\ui\data\official_firing_veh_3.jpg', \
	'\x\gw\addons\ui\data\official_helicopters.jpg', \
	'\x\gw\addons\ui\data\official_low.jpg', \
	'\x\gw\addons\ui\data\official_low_2.jpg', \
	'\x\gw\addons\ui\data\official_marksman.jpg', \
	'\x\gw\addons\ui\data\official_nexus.jpg', \
	'\x\gw\addons\ui\data\official_zeus.jpg' \
])

#define	GETSIDE(var1) getNumber(configfile >> "CfgVehicles" >> (typeOf var1) >> "side")
#define	GETSIDESTRING(var1) \
	switch (GETSIDE(var1)) do { \
		case 0: { \
			"East" \
		}; \
		case 1: { \
			"West" \
		}; \
		case 2: { \
			"Independent" \
		}; \
		case 3: { \
			"Civilian" \
		}; \
	}

#define CBA_CANOVERWRITE 0
#define CBA_SERVEROVERWRITE 1
#define CBA_BLOCKOVERWRITE 2

/* -------------------------------------------
Group: Debugging
------------------------------------------- */
//	#define DEBUG_SETTINGS [true, true, true]

#ifdef DEBUG_MODE_FULL
	#define DEBUG_MODE_NORMAL
#endif

#ifdef DEBUG_MODE_NORMAL
	#define DEBUG_MODE_MINIMAL
#endif

#ifndef DEBUG_MODE_MINIMAL
	#define DEBUG_MODE_NORMAL
	#define DEBUG_MODE_MINIMAL
#endif

#ifdef DEBUG_MODE_FULL
	#define LOG(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "DEBUG", false] call GW_fnc_log
	#define LOG_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "DEBUG", true] call GW_fnc_log
#else	// disabled
	#define LOG(MESSAGE)
	#define LOG_ADMIN(MESSAGE)
#endif

#ifdef DEBUG_MODE_NORMAL
	#define WARNING(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "WARNING", false] call GW_fnc_log
	#define WARNING_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "WARNING", true] call GW_fnc_log
#else	// disabled
	#define WARNING(MESSAGE)
	#define WARNING_ADMIN(MESSAGE)
#endif

#define ERROR(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "ERROR", false] call GW_fnc_log
#define ERROR_ADMIN(MESSAGE) [__LINE__, #COMPONENT, MESSAGE, "ERROR", true] call GW_fnc_log

#ifdef DEBUG_MODE_FULL
	#define TRACE_1(MESSAGE,A) LOG(PFORMAT_1(MESSAGE,A));
	#define TRACE_2(MESSAGE,A,B) LOG(PFORMAT_2(MESSAGE,A,B));
	#define TRACE_3(MESSAGE,A,B,C) LOG(PFORMAT_3(MESSAGE,A,B,C));
	#define TRACE_4(MESSAGE,A,B,C,D) LOG(PFORMAT_4(MESSAGE,B,C,D));
	#define TRACE_5(MESSAGE,A,B,C,D,E) LOG(PFORMAT_5(MESSAGE,B,C,D,E));
	#define TRACE_6(MESSAGE,A,B,C,D,E,F) LOG(PFORMAT_6(MESSAGE,B,C,D,E,F));
	#define TRACE_7(MESSAGE,A,B,C,D,E,F,G) LOG(PFORMAT_7(MESSAGE,B,C,D,E,F,G));
	#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) LOG(PFORMAT_8(MESSAGE,B,C,D,E,F,G,H));
	#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) LOG(PFORMAT_9(MESSAGE,B,C,D,E,F,G,H,I));
#else	// disabled
	#define TRACE_1(MESSAGE,A)
	#define TRACE_2(MESSAGE,A,B)
	#define TRACE_3(MESSAGE,A,B,C)
	#define TRACE_4(MESSAGE,A,B,C,D)
	#define TRACE_5(MESSAGE,A,B,C,D,E)
	#define TRACE_6(MESSAGE,A,B,C,D,E,F)
	#define TRACE_7(MESSAGE,A,B,C,D,E,F,G)
	#define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H)
	#define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I)
#endif
