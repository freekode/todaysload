using Toybox.Test;

const FIELDS_CONVERTER_TEST_DATA = {
	"result" => {
		"results" => [
			{
				"id" => 397933040,
				"user" => {
					"id" => 7185324
				},
				"year" => 2019,
				"day" => 23,
				"restingBpm" => 49,
				"load" => {
					"ride" => {
						"tscore" => {
							"ctl" => 35.5335,
							"atl" => 36.0743,
							"value" => 68
						}
					},
					"swim" => {
						"tscore" => {
							"ctl" => 7.55691,
							"atl" => 7.95912,
							"value" => 4
						}
					},
					"gym" => {
						"tscore" => {
							"ctl" => 12.9131,
							"atl" => 21.0258,
							"value" => 11
						}
					},
					"walk" => {
						"tscore" => {
							"ctl" => 0.375835,
							"atl" => 0.001392,
							"value" => 9
						}
					}
				}
			}
		]
	}
};

const FIELDS_CONVERTER_TEST_DATA_EMPTY = {
	"result" => {
		"results" => [
			{
				"id" => 397933040,
				"user" => {
					"id" => 7185324
				},
				"year" => 2019,
				"day" => 23,
				"restingBpm" => 49,
				"load" => {}
			}
		]
	}
};

(:test)
function restHrFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var field = new RestHrField(result);

    Test.assert(field._id.equals("restHr"));
    Test.assert(field._value.equals(49));

    return true;
}

(:test)
function tscoreFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var field = new TscoreField(result);

    logger.debug("field = " + field._value);

    Test.assert(field._id.equals("tscore"));
    Test.assert(field._value.equals(92));

    return true;
}

(:test)
function ctlFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var field = new CtlField(result);

    logger.debug("field = " + field._value);

    Test.assert(field._id.equals("ctl"));
    Test.assert(field._value.equals(56.379349));

    return true;
}

(:test)
function atlFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var field = new AtlField(result);

    logger.debug("field = " + field._value);

    Test.assert(field._id.equals("atl"));
    Test.assert(field._value.equals(65.060608));

    return true;
}

(:test)
function dayFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var field = new DayField(result);

    Test.assert(field._id.equals("day"));
    Test.assert(field._value.equals(23));

    return true;
}

(:test)
function tsbFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var ctlField = new CtlField(result);
    var atlField = new AtlField(result);
    var field = new TsbField(ctlField, atlField);

    logger.debug("field = " + field._value);

    Test.assert(field._id.equals("tsb"));
    Test.assert(field._value.equals(-8.681259));

    return true;
}

(:test)
function tsbrFieldTest(logger) {
    var result = $.FIELDS_CONVERTER_TEST_DATA["result"]["results"][0];

    var ctlField = new CtlField(result);
    var atlField = new AtlField(result);
    var field = new TsbrField(ctlField, atlField);

    logger.debug("field = " + field._value);

    Test.assert(field._id.equals("tsbr"));
    Test.assert(field._value.equals(115.397942));

    return true;
}
