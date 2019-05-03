using Toybox.WatchUi;

class CtlField extends AbstractField {
	hidden var fieldId = "ctl";

	function initialize(result) {
        AbstractField.initialize(fieldId, convert(result));
    }

	hidden function convert(result) {
		var value = 0.0;

        var sportTypes = WatchUi.loadResource(Rez.JsonData.sportTypes);

		var load = result["load"];
		for(var i = 0; i < sportTypes.size(); i++) {
            var sportType = sportTypes[i];

            var sportLoad = load[sportType];
            if (sportLoad == null) {
                continue;
            }

	        value += sportLoad["tscore"]["ctl"];
        }

        return value;
	}
}
