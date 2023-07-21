#include "script_Component.hpp"

#ifdef LOAD_MODULES
	class COMPONENT: GW_Modules_Base {
		name = COMPONENT;
		Authors[] = {"GuzzenVonLidl"};
		version = 1.8;
		description = "Common Function used through out the framework";
	};
#endif

#ifdef LOAD_SpawnUnits
	class SpawnUnits {
		class West {
			Side = 1;
			Leader[] = {
				"B_Soldier_TL_F",
				"B_Soldier_SL_F"
			};
			Units[] = {
				"B_Soldier_AR_F",
				"B_medic_F",
				"B_Soldier_GL_F",
				"B_HeavyGunner_F",
				"B_soldier_M_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_F",
				"B_Soldier_LAT_F"
			};
		};
		class East {
			Side = 0;
			Leader[] = {
				"O_Soldier_TL_F",
				"O_Soldier_SL_F"
			};
			Units[] = {			
				"O_Soldier_AR_F",
				"O_medic_F",
				"O_Soldier_GL_F",
				"O_HeavyGunner_F",
				"O_soldier_M_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_F",
				"O_Soldier_LAT_F"
			};
		};
		class Independent {
			Side = 2;
			Leader[] = {
				"I_Soldier_TL_F",
				"I_Soldier_SL_F"
			};
			Units[] = {			
				"I_Soldier_AR_F",
				"I_medic_F",
				"I_Soldier_GL_F",
				"I_HeavyGunner_F",
				"I_soldier_M_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_F",
				"I_Soldier_LAT_F"
			};
		};
		class Civilian {
			Side = 3;
			Leader[] = {"C_man_1"};
			Units[] = {"C_Man_casual_4_F","C_Man_casual_5_F","C_Man_casual_6_F"};
		};
	};
#endif
