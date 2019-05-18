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
		var firstField = app.getProperty("firstField");
		var secondField = app.getProperty("secondField");
        var thirdField = app.getProperty("thirdField");
        var fourthField = app.getProperty("fourthField");
        var fifthField = app.getProperty("fifthField");
        var sixthField = app.getProperty("sixthField");

		var fieldsNumbers = [firstField, secondField, thirdField, fourthField, fifthField, sixthField];

		var fieldsIds = [];
		for(var i = 0; i < fieldsNumbers.size(); i++) {
            var fieldNumber = fieldsNumbers[i];
            var fieldId = fieldsMap[fieldNumber.toString()];
            if (fieldId != null) {
                fieldsIds.add(fieldId);
            }
        }

        return fieldsIds;
    }
}
