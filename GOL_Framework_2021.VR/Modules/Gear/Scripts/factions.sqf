
switch (_side) do {
	case "AAF-W": {
		#include "Classes\AAF-W.sqf"
	};
	case "AAF-SF-W": {
		#include "Classes\AAF-SF-W.sqf"
	};
		case "IRISH-UN": {
		#include "Classes\IRISH-UN.sqf"
	};
	case "CBRN-WINTER": {
		#include "Classes\CBRN-WINTER.sqf"
	};
	case "BAF-W": {
		#include "Classes\BAF-W.sqf"
	};
	case "BAF-D": {
		#include "Classes\BAF-D.sqf"
	};	
	case "CTRG-W": {
		#include "Classes\CTRG-W.sqf"
	};
	case "CTRG-D": {
		#include "Classes\CTRG-D.sqf"
	};	
	case "BAF-W-FALK": {
		#include "Classes\BAF-W-FALK.sqf"
	};
	case "FRANCE-D": {
		#include "Classes\FRANCE-D.sqf"
	};	
	case "FRANCE-W": {
		#include "Classes\FRANCE-W.sqf"
	};		
	case "RWANDA-W": {
		#include "Classes\RWANDA-W.sqf"
	};
	case "UKRAINE-W": {
		#include "Classes\UKRAINE-W.sqf"
	};
	case "CIVI-AFRICA": {
		#include "Classes\CIVI-AFRICA.sqf"
	};
	case "CIVI-ALTIS": {
		#include "Classes\CIVI-ALTIS.sqf"
	};
	case "CIVI-CHERNARUS": {
		#include "Classes\CIVI-CHERNARUS.sqf"
	};
	case "CIVI-TAKISTAN": {
		#include "Classes\CIVI-TAKISTAN.sqf"
	};
	case "FINLAND-W": {
		#include "Classes\FINLAND-W.sqf"
	};
	case "LIVONIA-W": {
		#include "Classes\LIVONIA-W.sqf"
	};
	case "CZECH-W": {
		#include "Classes\CZECH-W.sqf"
	};
	case "CZECH-D": {
		#include "Classes\CZECH-D.sqf"
	};
	case "CZECH-SOVIET-W":{
		#include "Classes\CZECH-SOVIET-W.sqf"
	};
	case "TURKEY-D": {
		#include "Classes\TURKEY-D.sqf"
	};
	case "TANOA-SF": {
		#include "Classes\TANOA-SF.sqf"
	};	
	case "TANOA-ARMY": {
		#include "Classes\TANOA-ARMY.sqf"
	};		
	case "SYRIA-W": {
		#include "Classes\SYRIA-W.sqf"
	};
	case "CDF-W": {
		#include "Classes\CDF-W.sqf"
	};
	case "CHDKZ-SF-W": {
		#include "Classes\CHDKZ-SF-W.sqf"
	};
	case "CSAT-H": {
		#include "Classes\CSAT-H.sqf"
	};
	case "CSAT-SF-W": {
		#include "Classes\CSAT-SF-W.sqf"
	};
	case "CSAT-W": {
		#include "Classes\CSAT-W.sqf"
	};
	case "CSAT-U": {
		#include "Classes\CSAT-U.sqf"
	};
	case "CUSTOM-E": {
		#include "Classes\CUSTOM-E.sqf"
	};
	case "CUSTOM-I": {
		#include "Classes\CUSTOM-I.sqf"
	};
	case "CUSTOM-W": {
		#include "Classes\CUSTOM-W.sqf"
	};
	case "ISLAMICSTATE": {
		#include "Classes\ISLAMICSTATE.sqf"
	};
	case "TAKISTAN-D": {
		#include "Classes\TAKISTAN-D.sqf"
	};
	case "TAKISTAN-SF-D": {
		#include "Classes\TAKISTAN-SF-D.sqf"
	};
	case "AFRICAN-ARMY":{
		#include "Classes\AFRICAN-ARMY.sqf"
	};
	case "INSURGENT-ME": {
		#include "Classes\INSURGENT-ME.sqf"
	};
	case "INSURGENT-CHDKZ": {
		#include "Classes\INSURGENT-CHDKZ.sqf"
	};
	case "INSURGENT-AFRICA": {
		#include "Classes\INSURGENT-AFRICA.sqf"
	};
	case "INSURGENT-TANOA": {
		#include "Classes\INSURGENT-TANOA.sqf"
	};
	case "INSURGENT-FIA": {
		#include "Classes\INSURGENT-FIA.sqf"
	};	
	case "INSURGENT-MALDEN": {
		#include "Classes\INSURGENT-MALDEN.sqf"
	};		
	case "AUS-TAN": {
		#include "Classes\AUS-TAN.sqf"
	};
	case "IRAQ-SF": {
		#include "Classes\IRAQ-SF.sqf"
	};
	case "AFGHAN-W": {
		#include "Classes\AFGHAN-W.sqf"
	};
	case "NATO-D": {
		#include "Classes\NATO-D.sqf"
	};
	case "NATO-W": {
		#include "Classes\NATO-W.sqf"
	};
	case "MALDEN-W": {
		#include "Classes\MALDEN-W.sqf"
	};	
	case "GERMAN-W": {
		#include "Classes\GERMAN-W.sqf"
	};
	case "GERMAN-D": {
		#include "Classes\GERMAN-D.sqf"
	};	
	case "PMC": {
		#include "Classes\PMC.sqf"
	};
	case "SOVIET-D": {
		#include "Classes\SOVIET-D.sqf"
	};
	case "SOVIET-SF-D": {
		#include "Classes\SOVIET-SF-D.sqf"
	};
	case "SOVIET-W": {
		#include "Classes\SOVIET-W.sqf"
	};
	case "RUSSIAN-W": {
		#include "Classes\RUSSIAN-W.sqf"
	};
	case "RUSSIAN-SF-W": {
		#include "Classes\RUSSIAN-SF-W.sqf"
	};
	case "USA-CW-W": {
		#include "Classes\USA-CW-W.sqf"
	};
	case "USA-W": {
		#include "Classes\USA-W.sqf"
	};
	case "USA-D": {
		#include "Classes\USA-D.sqf"
	};
	case "USMC-D": {
		#include "Classes\USMC-D.sqf"
	};
	case "USMC-W": {
		#include "Classes\USMC-W.sqf"
	};

	case "SWEDISH": {
		#include "Classes\SWEDISH.sqf"
	};
	case "ISRAELI": {
		#include "Classes\ISRAELI.sqf"
	};
	case "CHINA": {
		#include "Classes\CHINA.sqf"
	};
	default {
		_errorCode = true;
		ERROR(FORMAT_1("Faction does not exist: %1", _side));
	};
};