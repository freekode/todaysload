using Toybox.WatchUi;

class RestHrField extends AbstractField {
	hidden var fieldId = "restHr";

	function initialize(result) {
        AbstractField.initialize(fieldId, convert(result));
    }

	hidden function convert(result) {
		var restHr = 0;
        if (result["restingBpm"] != null) {
            restHr = result["restingBpm"];
        }

        return restHr;
	}
}
