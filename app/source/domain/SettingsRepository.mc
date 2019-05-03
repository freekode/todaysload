using Toybox.Application;
using Toybox.WatchUi;

class SettingsRepository {
	hidden var app;
	hidden var fieldsMap;

	function initialize() {
		app = Application.getApp();
        fieldsMap = WatchUi.loadResource(Rez.JsonData.fieldsMap);
	}

	function getSelectedFields() {
		var firstField = firstField();
		var secondField = secondField();
        var thirdField = thirdField();
        var fourthField = fourthField();
        var fifthField = fifthField();
        var sixthField = sixthField();

		var fields = [firstField, secondField, thirdField, fourthField, fifthField, sixthField];

		var fieldsIds = [];
		for(var i = 0; i < fields.size(); i++) {
            var field = fields[i];
            if (field != null) {
                fieldsIds.add(field);
            }
        }

        return fieldsIds;
    }

	function firstField() {
		var propertyNumber = app.getProperty("firstField");
		return fieldsMap[propertyNumber.toString()];
	}

	function secondField() {
        var propertyNumber = app.getProperty("secondField");
        return fieldsMap[propertyNumber.toString()];
    }

    function thirdField() {
        var propertyNumber = app.getProperty("thirdField");
        return fieldsMap[propertyNumber.toString()];
    }

    function fourthField() {
        var propertyNumber = app.getProperty("fourthField");
        return fieldsMap[propertyNumber.toString()];
    }

    function fifthField() {
        var propertyNumber = app.getProperty("fifthField");
        return fieldsMap[propertyNumber.toString()];
    }

    function sixthField() {
        var propertyNumber = app.getProperty("sixthField");
        return fieldsMap[propertyNumber.toString()];
    }
}
