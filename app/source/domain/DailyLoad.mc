using LogMonkey as Log;

class DailyLoad {
	hidden var _fields = {};

	function initialize(fields) {
		for(var i = 0; i < fields.size(); i++) {
			var field = fields[i];
			_fields.put(field["key"], field["value"]);
	    }
	}

	function getValue(key) {
		var value = _fields.get(key);
		if (value != null) {
			return value;
		}

		return 0;
	}

	function getValues(keys) {
		var values = [];
		for(var i = 0; i < keys.size(); i++) {
			values.add(getValue(keys[i]));
        }

        return values;
    }

	function empty() {
		return new DailyLoad([]);
	}
}
