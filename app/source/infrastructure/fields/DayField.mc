using Toybox.WatchUi;

class DayField extends AbstractField {
	hidden var fieldId = "day";

	function initialize(result) {
        AbstractField.initialize(fieldId, convert(result));
    }

	hidden function convert(result) {
		var restHr = 0;
        if (result["day"] != null) {
            restHr = result["day"];
        }

        return restHr;
	}
}
