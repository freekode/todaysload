using Toybox.Test;

const DAILY_LOAD_CONVERTER_TEST_DATA = {
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

const DAILY_LOAD_CONVERTER_TEST_DATA_EMPTY = {
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
function fieldsConverterTest(logger) {
    var results = $.DAILY_LOAD_CONVERTER_TEST_DATA["result"]["results"];

    var converter = new FieldsConverter();
    var dailyLoads = converter.convertAll(results);

    logger.debug("dailyLoads = " + dailyLoads);

	Test.assert(dailyLoads.size() == 1);

    return true;
}

(:test)
function fieldsConverterTestEmpty(logger) {
    var results = $.DAILY_LOAD_CONVERTER_TEST_DATA_EMPTY["result"]["results"];

    var converter = new FieldsConverter();
    var dailyLoads = converter.convertAll(results);

    logger.debug("dailyLoads = " + dailyLoads);

	Test.assert(dailyLoads.size() == 1);

    return true;
}
