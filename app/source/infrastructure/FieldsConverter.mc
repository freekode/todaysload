using Toybox.Time.Gregorian;

(:background)
class FieldsConverter {
	hidden var sportTypes;

	function initialize(sportTypes) {
        self.sportTypes = sportTypes;
    }

	function convertAll(jsonArray) {
        var dailyLoadsDicts = [];
        for(var i = 0; i < jsonArray.size(); i++) {
            var jsonObject = jsonArray[i];
            dailyLoadsDicts.add(convert(jsonObject));
        }

        return dailyLoadsDicts;
	}

	function convert(jsonObject) {
		var atlField = getAtlField(jsonObject, sportTypes);
		var ctlField = getCtlField(jsonObject, sportTypes);
		var tscoreField = getTscoreField(jsonObject, sportTypes);
	    var restHrField = getRestHrField(jsonObject);
	    var dateField = getDateField(jsonObject);
	    var tsbField = getTsbField(ctlField, atlField);
	    var tsbrField = getTsbrField(ctlField, atlField);

		return [atlField, ctlField, tscoreField, restHrField, dateField, tsbField, tsbrField];
	}

	hidden function getDictionaryForField(key, value) {
        return {
            "key" => key,
            "value" => value
        };
    }

	hidden function getAtlField(jsonObject, sportTypes) {
		var fieldId = "atl";
		return getDictionaryForField(fieldId, convertSportTypeField(jsonObject, sportTypes, fieldId));
	}

	hidden function getCtlField(jsonObject, sportTypes) {
        var fieldId = "ctl";
        return getDictionaryForField(fieldId, convertSportTypeField(jsonObject, sportTypes, fieldId));
    }

	hidden function getTscoreField(jsonObject, sportTypes) {
        var fieldId = "tscore";
        var key = "value";
        return getDictionaryForField(fieldId, convertSportTypeField(jsonObject, sportTypes, key));
    }

    hidden function getRestHrField(jsonObject) {
    	var fieldId = "restHr";
    	var key = "restingBpm";
        return getDictionaryForField(fieldId, convertSimpleTypeField(jsonObject, key));
    }

    hidden function getTsbField(ctlField, atlField) {
		var fieldId = "tsb";
        return getDictionaryForField(fieldId, ctlField["value"] - atlField["value"]);
    }

    hidden function getTsbrField(ctlField, atlField) {
        var fieldId = "tsbr";

        var value = 0.0;
        if (ctlField["value"] != 0) {
            value = ((atlField["value"] / ctlField["value"]) * 100.0);
        }

        return getDictionaryForField(fieldId, value);
    }

    hidden function getDateField(jsonObject) {
        var fieldId = "date";

        var day = jsonObject["day"];
        var year = jsonObject["year"];

        var firstJanuary = UiTools.getFirstJanuary(year.toNumber());
        var currentDate = UiTools.addToDate(firstJanuary, day.toNumber() - 1);
        var dateString = UiTools.formatDate(currentDate);

        return getDictionaryForField(fieldId, dateString);
    }

	hidden function convertSportTypeField(jsonObject, sportTypes, key) {
        var value = 0.0;

        var load = jsonObject["load"];
        for(var i = 0; i < sportTypes.size(); i++) {
            var sportType = sportTypes[i];

            var sportLoad = load[sportType];
            if (sportLoad == null) {
                continue;
            }

            value += sportLoad["tscore"][key];
        }

        return value;
    }

    hidden function convertSimpleTypeField(jsonObject, key) {
        if (jsonObject[key] != null) {
            return jsonObject[key];
        }

        return 0;
    }
}
