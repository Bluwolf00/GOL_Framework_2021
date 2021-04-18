
class ace_advanced_fatigue_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_advanced_fatigue_enableStaminaBar {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_advanced_fatigue_performanceFactor {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};
class ace_advanced_fatigue_recoveryFactor {
	value = 2;
	typeName = "SCALAR";
	force = 1;
};
class ace_advanced_fatigue_loadFactor {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_advanced_fatigue_terrainGradientFactor {
	value = 0.5;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_advanced_throwing_enabled {
	value = 1;
	typeName = "BOOL";
};
class ace_advanced_throwing_showThrowArc {
	value = 1;
	typeName = "BOOL";
};
class ace_advanced_throwing_showMouseControls {
	value = 1;
	typeName = "BOOL";
};
class ace_advanced_throwing_enablePickUp {
	value = 1;
	typeName = "BOOL";
};
class ace_advanced_throwing_enablePickUpAttached {
	value = 1;
	typeName = "BOOL";
};

// -------------------------------------------

class ace_captives_allowHandcuffOwnSide {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_captives_requireSurrender {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_captives_allowSurrender {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_cargo_enable {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------
/* CLASS NO LONGER EXISTS!!!
class ace_common_forceAllSettings {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
*/
class ace_common_checkPBOsAction {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_common_checkPBOsCheckAll {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_common_checkPBOsWhitelist {
	value = "['ace_tracers']";
	typeName = "STRING";
};

// -------------------------------------------

class ace_cookoff_enable {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

class ace_cookoff_enableAmmoCookoff {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

/*
class ace_cookoff_enableAmmobox {
    value = 1;
    typeName = "BOOL";
	force = 1;
};
*/

// -------------------------------------------

class ace_explosives_punishNonSpecialists {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_explosives_explodeOnDefuse {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_finger_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_finger_maxRange {
	value = 7;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_frag_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_frag_maxTrack {
	value = 50;
	typeName = "SCALAR";
	force = 1;
};
class ace_frag_maxTrackPerFrame {
	value = 50;
	typeName = "SCALAR";
	force = 1;
};

class ace_frag_enableDebugTrace {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_gforces_enabledFor {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_goggles_effects {
	value = 2;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_hearing_enableCombatDeafness {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_hearing_enabledForZeusUnits {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_hearing_autoAddEarplugsToUnits {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_hitreactions_minDamageToTrigger {
	value = 0.1;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_interaction_enableTeamManagement {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_laserpointer_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_map_mapIllumination {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_map_mapGlow {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_map_mapShake {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_map_mapLimitZoom {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_map_mapShowCursorCoordinates {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_map_defaultChannel {
	value = 3;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_map_gestures_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_map_gestures_maxRange {
	value = 7;
	typeName = "SCALAR";
	force = 1;
};
class ace_map_gestures_interval {
	value = 0.05;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_mk6mortar_airResistanceEnabled {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_mk6mortar_allowComputerRangefinder {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_mk6mortar_allowCompass {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_mk6mortar_useAmmoHandling {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_nametags_showPlayerNames {
	value = 1;
	typeName = "SCALAR";
	force = 0;
};

class ace_nametags_playerNamesViewDistance {
	value = 50;
	typeName = "SCALAR";
	force = 1;
};

class ace_nightvision_effectScaling {
	value = 0.5;
	typeName = "SCALAR";
	force = 1;
};

class ace_nightvision_fogScaling {
	value = 0.0;
	typeName = "SCALAR";
	force = 1;
};

class ace_nightvision_aimDownSightsBlur {
	value = 0.8;
	typeName = "SCALAR";
	force = 1;
};


// -------------------------------------------

class ace_overheating_overheatingDispersion {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_overheating_unJamOnreload {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_overheating_unJamFailChance {
	value = 0.1;
	typeName = "SCALAR";
	force = 1;
};
class ace_overheating_enabled {
	value = 1;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_respawn_savePreDeathGear {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_respawn_removeDeadBodiesDisconnected {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_respawn_bodyRemoveTimer {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_spectator_filterUnits {
	value = 1;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_ui_allowSelectiveUI {
	value = 0;
	typeName = "BOOL";
	force = 1;
};

// -------------------------------------------

class ace_viewdistance_enabled {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_viewdistance_limitViewDistance {
	value = 10000;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_weather_enableServerController {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_weather_useACEWeather {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_weather_syncRain {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_weather_syncWind {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_weather_syncMisc {
	value = 1;
	typeName = "BOOL";
	force = 1;
};
class ace_weather_serverUpdateInterval {
	value = 60;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_winddeflection_enabled {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_winddeflection_vehicleEnabled {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_winddeflection_simulationRadius {
	value = 1000;
	typeName = "SCALAR";
	force = 1;
};

// -------------------------------------------

class ace_zeus_zeusAscension {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_zeus_zeusBird {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_zeus_remoteWind {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_zeus_radioOrdnance {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
class ace_zeus_revealMines {
	value = 0;
	typeName = "SCALAR";
	force = 1;
};
class ace_zeus_autoAddObjects {
	value = 0;
	typeName = "BOOL";
	force = 1;
};
