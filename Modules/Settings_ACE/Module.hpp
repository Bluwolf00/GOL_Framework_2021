#include "script_Component.hpp"

#ifdef LOAD_MODULES
	class COMPONENT: GW_Modules_Base {
		name = COMPONENT;
		Authors[] = {"GuzzenVonLidl"};
		version = 3.7.0;
		description = "Configures all ACE settings";
		postInit = "";

	};
#endif

#ifdef LOAD_ACE		// ACE3 - Version 3.6.2
	#include "ACE\Settings_Common.hpp"	// Everything else
	#include "ACE\Settings_Medical.hpp"	// Only medical
#endif
