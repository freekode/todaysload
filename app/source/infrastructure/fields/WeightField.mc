using Toybox.WatchUi;

class WeightField extends AbstractField {
	hidden var fieldId = "weight";

	function initialize(result) {
        AbstractField.initialize(fieldId, convert(result));
    }

	hidden function convert(result) {
		var value = 0;
        if (result["weight"] != null) {
            value = result["weight"];
        }

        return value;
	}
}
