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

    function getStringValues(keys) {
        var values = [];
        for(var i = 0; i < keys.size(); i++) {
            var value = getValue(keys[i]);
            values.add(value.toNumber().toString());
        }

        return values;
    }
}
