using Toybox.Application;

class SettingsRepository {
	hidden var app;
	hidden var fieldsMap;

	function initialize(fieldsMap) {
        self.fieldsMap = fieldsMap;

		app = Application.getApp();
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
