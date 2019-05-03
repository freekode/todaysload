using Toybox.WatchUi;

class TsbField extends AbstractField {
	hidden var fieldId = "tsb";

	function initialize(ctlField, atlField) {
        AbstractField.initialize(fieldId, convert(ctlField, atlField));
    }

	hidden function convert(ctlField, atlField) {
        return ctlField._value - atlField._value;
	}
}
