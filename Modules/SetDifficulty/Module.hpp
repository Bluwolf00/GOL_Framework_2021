#include "script_Component.hpp"

#ifdef LOAD_MODULES
	class COMPONENT: GW_Modules_Base {
		name = COMPONENT;
		Authors[] = {"GuzzenVonLidl"};
		version = 1.3;
		description = "Set skill level for each unit";
	};
#endif

#ifdef LOAD_Behaviour
	class Behaviour {
		class Testing {		//	Min	  Mid	Max
			aimingAccuracy[] = {1.00, 1.00, 1.00};
			aimingShake[]	 = {1.00, 1.00, 1.00};
			aimingSpeed[]	 = {1.00, 1.00, 1.00};
			commanding[]	 = {1.00, 1.00, 1.00};
			courage[] 		 = {1.00, 1.00, 1.00};
			endurance[] 	 = {1.00, 1.00, 1.00};
			general[]		 = {1.00, 1.00, 1.00};
			reloadSpeed[]	 = {1.00, 1.00, 1.00};
			spotDistance[]	 = {1.00, 1.00, 1.00};		// Reduce the distance at which AI can see enemy, reducing their calculations.
			spotTime[]		 = {1.00, 1.00, 1.00};
			Fleeing[]		 = {0.00, 0.00, 0.00};		// Fleeing values are inverted meaning that put it to 0 and units will never flee
			playerCamoCoef[] = {1.00, 1.00, 1.00};		// Lower value makes player harder to detect, Input values between 0.5 and 1.5. Higher or lower values will change the gameplay drasticly // Not Implemented yet
		};

		class Specialforces {
			aimingAccuracy[] = {0.30, 0.35, 0.40};
			aimingShake[]	 = {0.50, 0.70, 0.90};
			aimingSpeed[]	 = {0.50, 0.70, 0.90};
			commanding[]	 = {0.70, 0.80, 0.90};
			courage[]		 = {0.60, 0.70, 0.90};
			endurance[]		 = {0.80, 0.90, 1.00};
			general[]		 = {0.70, 0.80, 1.00};
			reloadSpeed[]	 = {1.00, 1.00, 1.00};
			spotDistance[]	 = {0.70, 0.80, 0.90};
			spotTime[]		 = {0.70, 0.80, 0.90};
			Fleeing[]		 = {0.10, 0.10, 0.20};
			playerCamoCoef[] = {1.00, 1.00, 1.20};
		};

		class Military {
			aimingAccuracy[] = {0.25, 0.30, 0.35};
			aimingShake[]	 = {0.50, 0.70, 0.90};
			aimingSpeed[]	 = {0.50, 0.70, 0.90};
			commanding[]	 = {0.60, 0.70, 0.80};
			courage[]		 = {0.40, 0.50, 0.60};
			endurance[]		 = {0.50, 0.60, 0.40};
			general[]		 = {0.60, 0.70, 0.80};
			reloadSpeed[]	 = {0.60, 0.70, 0.80};
			spotDistance[]	 = {1.00, 1.00, 1.00};
			spotTime[]		 = {1.00, 1.00, 1.00};
			Fleeing[]		 = {0.10, 0.20, 0.30};
			playerCamoCoef[] = {1.00, 1.00, 1.00};
		};

		class Insurgents {
			aimingAccuracy[] = {0.20, 0.25, 0.30};
			aimingShake[]	 = {0.50, 0.70, 0.90};
			aimingSpeed[]	 = {0.50, 0.70, 0.90};
			commanding[]	 = {0.60, 0.70, 0.80};
			courage[]		 = {0.20, 0.30, 0.40};
			endurance[]		 = {0.60, 0.70, 0.80};
			general[]		 = {0.60, 0.70, 0.80};
			reloadSpeed[]	 = {0.60, 0.70, 0.80};
			spotDistance[]	 = {1.00, 1.00, 1.00};
			spotTime[]		 = {1.00, 1.00, 1.00};
			Fleeing[]		 = {0.30, 0.40, 0.50};
			playerCamoCoef[] = {1.20, 1.30, 1.50};
		};

		class Dummy {
			aimingAccuracy[] = {0.15, 0.20, 0.25};
			aimingShake[]	 = {0.50, 0.70, 0.90};
			aimingSpeed[]	 = {0.50, 0.70, 0.90};
			commanding[]	 = {0.30, 0.40, 0.50};
			courage[]		 = {0.05, 0.15, 0.20};
			endurance[]		 = {0.30, 0.40, 0.50};
			general[]		 = {0.30, 0.40, 0.50};
			reloadSpeed[]	 = {0.30, 0.40, 0.50};
			spotDistance[]	 = {1.00, 1.00, 1.00};
			spotTime[]		 = {1.00, 1.00, 1.00};
			Fleeing[]		 = {0.50, 0.60, 0.70};
			playerCamoCoef[] = {1.20, 1.30, 1.50};
		};
	};
#endif
