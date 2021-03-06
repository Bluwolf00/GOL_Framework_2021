//	#define DEBUG_MODE_FULL

#define	COMPONENT Gear
#include "..\script_Component.hpp"

#define ISMAG(Class) (isClass (configfile >> "CfgMagazines" >> Class))
#define MAGCOUNT(Class) (getNumber (configfile >> "CfgMagazines" >> Class >> "count"))
#define ADD_MAG(Class) [Class, MAGCOUNT(Class)]

//#define COUNT_MAGS(Class, Amount) [Class, Amount, MAGCOUNT(Class)]
//#define COUNT_MAGS_162(Class, Amount) [Class, MAGCOUNT(Class), Amount]
#define COUNT_MAGS(Class, Amount) [Class, Amount, MAGCOUNT(Class)]

#define COUNT_AG_MAGS(Class) (400 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_AR_MAGS(Class) (800 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))

#define COUNT_AMMG_MAGS(Class) (500 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))
#define COUNT_MMG_MAGS(Class) (500 / (getNumber (configfile >> "CfgMagazines" >> Class >> "count")))

#define ISNILS(VARIABLE,DEFAULT_VALUE) if (isNil #VARIABLE) then { VARIABLE = DEFAULT_VALUE }
