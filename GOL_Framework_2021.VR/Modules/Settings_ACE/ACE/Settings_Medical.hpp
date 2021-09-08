/*

class ace_medical_increaseTrainingInLocations {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_enableFor {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_enableOverdosing {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_enableAirway {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_enableAdvancedWounds {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_enableVehicleCrashes {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_enableScreams {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
*/

// Only Used to Define Bandages in GW Framework
class ace_medical_level {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_medicSetting {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
//

class ace_medical_fractures {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_spontaneousWakeUpChance {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_fatalDamageSource {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_playerDamageThreshold {
	value = 1.25;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_AIDamageThreshold {
	value = 0.8;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_ai_enabledFor {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_blood_enabledfor {
	value = 2;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_gui_enableActions {
	value = 0;
	typeName = "SCALAR";
	force = 0;
};

class ace_medical_feedback_bloodVolumeEffectType {
	value = 2;
	typeName = "SCALAR";
	force = 0;
};

class ace_medical_statemachine_AIUnconsciousness {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_statemachine_cardiacArrestTime {
	value = 90;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_bleedingCoefficient {
	value = 1.2;
	typeName = "SCALAR";
	force = 0;
};
class ace_medical_painCoefficient {
	value = 0.7;
	typeName = "SCALAR";
	force = 0;
};

class ace_medical_painUnconsciousChance {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_ivFlowRate {
	value = 20;
	typeName = "SCALAR";
	force = 0;
};

class ace_medical_treatment_advancedBandages {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_advancedDiagnose {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_treatment_advancedMedication {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_treatment_clearTraumaAfterBandage {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_treatment_locationsBoostTraining {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_treatment_allowLitterCreation {
	value = 1;
	typeName = "BOOL";
};
class ace_medical_treatment_litterCleanUpDelay {
	value = 900;
	typeName = "SCALAR";
};

class ace_medical_treatment_medicEpinephrine {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_locationEpinephrine {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_medicPAK {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_locationPAK {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_consumePAK {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_allowSelfPAK {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_timeCoefficientPAK {
	value = 0.1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_medicSurgicalKit {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_locationSurgicalKit {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_consumeSurgicalKit {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_treatment_allowSelfStitch {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_allowSharedEquipment {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_convertItems {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_treatmentTimeAutoinjector {
	value = 2;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_treatmentTimeTourniquet {
	value = 2;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_medicIV {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_locationIV {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_allowSelfIV {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_treatmentTimeIV {
	value = 4;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_cprSuccessChance {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_treatment_treatmentTimeCPR {
	value = 4;
	typeName = "SCALAR";
	force = 1;
};
/*
class ace_medical_remoteControlledAI {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_preventInstaDeath {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_allowDeadBodyMovement {	// Remove ?
	value = 0;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_keepLocalSettingsSynced {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

class ace_medical_painIsOnlySuppressed {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_allowUnconsciousAnimationOnTreatment {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_moveUnitsFromGroupOnUnconscious {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_medical_delayUnconCaptive {
	value = 3;
	typeName = "SCALAR";
	force = 1;
};

class ace_medical_enableRevive {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_maxReviveTime {
	value = 300;
	typeName = "SCALAR";
	force = 1;
};
class ace_medical_amountOfReviveLives {
	value = -1;
	typeName = "SCALAR";
	force = 1;
};


