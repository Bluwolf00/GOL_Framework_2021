#include "script_Component.hpp"

#ifdef LOAD_MODULES
	class COMPONENT: GW_Modules_Base {
		name = COMPONENT;
		Authors[] = {"GuzzenVonLidl"};
		version = 2;
		description = "Configures radio for players, Supports ACRE2 and TFAR";
		requiredModules[] = {"Gear"};
	};
#endif
