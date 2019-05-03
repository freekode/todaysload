using Toybox.WatchUi;

class TsbrField extends AbstractField {
	hidden var fieldId = "tsbr";

	function initialize(ctlField, atlField) {
        AbstractField.initialize(fieldId, convert(ctlField, atlField));
    }

	hidden function convert(ctlField, atlField) {
		var value = 0.0;
        if (ctlField._value != 0) {
            value = ((atlField._value / ctlField._value) * 100.0);
        }

        return value;
	}
}
