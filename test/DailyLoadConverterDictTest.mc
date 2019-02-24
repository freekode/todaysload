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

const DAILY_LOAD_CONVERTER_TEST_DATA_SHORT = {
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
function dailySportLoadConverterTest(logger) {
	var load = $.DAILY_LOAD_CONVERTER_TEST_DATA["result"]["results"][0]["load"];

	var converter = new DailySportLoadDictConverter();
    var sportsLoads = converter.convertAll(load);

    logger.debug("sportsLoads = " + sportsLoads);

    var sportLoad = sportsLoads[0];

	Test.assert(sportLoad["sport"].equals("ride"));
	Test.assert(sportLoad["ctl"].equals(35));

	return true;
}

(:test)
function dailyLoadConverterTest(logger) {
    var results = $.DAILY_LOAD_CONVERTER_TEST_DATA["result"]["results"];

    var converter = new DailyLoadDictConverter();
    var dailyLoads = converter.convertAll(results);

    logger.debug("dailyLoads = " + dailyLoads);

	Test.assert(dailyLoads.size() == 1);

    return true;
}

(:test)
function dailyLoadConverterTestShort(logger) {
    var results = $.DAILY_LOAD_CONVERTER_TEST_DATA_SHORT["result"]["results"];

    var converter = new DailyLoadDictConverter();
    var dailyLoads = converter.convertAll(results);

    logger.debug("dailyLoads = " + dailyLoads);

	Test.assert(dailyLoads[0]["sportsLoads"].size() == 0);

    return true;
}
