using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using LogMonkey as Log;

class TodaysPlanStatusResource {
	hidden var _onSuccess;
    hidden var _onFail;
	hidden var _startDate;
	hidden var _endDate;

	function request(startDate, endDate, onSuccess, onFail) {
		_onSuccess = onSuccess;
        _onFail = onFail;
        _startDate = startDate;
        _endDate = endDate;

        var hostname = WatchUi.loadResource(Rez.JsonData.hostname);

		var url = hostname + "rest/users/day/search/0/0000000000";
		var parameters = {
			"criteria" => {
				"ranges" => [{
					"floorTs" => getTime(_startDate),
					"ceilTs" => getTime(_endDate)
				}]
			},
			"fields" => [
				"load.ride.tscore.ctl","load.ride.tscore.atl","load.ride.tscore.mask","load.ride.tscore.value",
				"load.swim.tscore.ctl","load.swim.tscore.atl","load.swim.tscore.mask","load.swim.tscore.value",
				"load.gym.tscore.ctl","load.gym.tscore.atl","load.gym.tscore.mask","load.gym.tscore.value",
				"load.walk.tscore.ctl","load.walk.tscore.atl","load.walk.tscore.mask","load.walk.tscore.value",
				"load.run.tscore.ctl","load.run.tscore.atl","load.run.tscore.mask","load.run.tscore.value",
				"restingBpm"],
			"opts" => 3
		};

		new Resource().send(url, "post", parameters, method(:success), method(:fail));
	}

	function success(responseCode, data) {
		var results = data["result"]["results"];

		var fieldsConverter = new FieldsConverter();
		var dailyLoads = fieldsConverter.convertAll(results);

		Log.Debug.logMessage("TodaysPlanStatusResource", "converted daily loads = " + dailyLoads.size());

		_onSuccess.invoke(dailyLoads);
	}

	function fail(responseCode, data) {
		Log.Debug.logMessage("TodaysPlanStatusResource", "failed " + data);
		_onFail.invoke(data);
	}

	function getTime(date) {
		return date.value().toString() + "000";
	}
}

