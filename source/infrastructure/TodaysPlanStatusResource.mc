using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using LogMonkey as Log;

class TodaysPlanStatusResource {
	var _callback;
	var _startDate;
	var _endDate;

	function initialize(startDate, endDate, callback) {
		_callback = callback;
		_startDate = startDate;
		_endDate = endDate;
	}

	function get() {
		var url = $.HOST + "rest/users/day/search/0/0000000000";
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

		new Resource().send(url, "post", parameters, method(:received), method(:failed));
	}

	function received(responseCode, data) {
		Log.Debug.logMessage("TodaysPlanStatusResource", "data received");

		var results = data["result"]["results"];

		var converter = new DailyLoadDictConverter();
		var statuses = converter.convertAll(results);

		Log.Debug.logMessage("TodaysPlanStatusResource", "received daily loads = " + statuses.size());

		_callback.invoke(statuses);
	}

	function failed(responseCode, data) {
		Log.Debug.logMessage("TodaysPlanStatusResource", "failed " + data);
	}

	function getTime(date) {
		return date.value().toString() + "000";
	}
}

