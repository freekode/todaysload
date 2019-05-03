using Toybox.WatchUi;

class AtlField extends AbstractField {
	hidden var fieldId = "atl";

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

	        value += sportLoad["tscore"]["atl"];
        }

        return value;
	}
}
