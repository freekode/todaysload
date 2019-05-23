using Toybox.WatchUi;

class FieldsConverter {

	function convertAll(results) {
        var dailyLoadsDicts = [];
        for(var i = 0; i < results.size(); i++) {
            var result = results[i];
            dailyLoadsDicts.add(convert(result));
        }

        return dailyLoadsDicts;
	}

	function convert(result) {
		var atlField = new AtlField(result);
		var ctlField = new CtlField(result);
		var tscoreField = new TscoreField(result);
	    var restHrField = new RestHrField(result);
	    var dateField = new DateField(result);
	    var tsbField = new TsbField(ctlField, atlField);
	    var tsbrField = new TsbrField(ctlField, atlField);
	    var weightField = new WeightField(result);

		var fields = [atlField, ctlField, tscoreField, restHrField, dateField, tsbField, tsbrField, weightField];

		var dailyLoadFields = [];
        for(var i = 0; i < fields.size(); i++) {
            var field = fields[i];
            dailyLoadFields.add({
                "key" => field._id,
                "value" => field._value
            });
        }

        return dailyLoadFields;
	}
}
