using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;

class TodaysPlanStatusResource {
	hidden var onSuccess;
    hidden var onFail;

	function request(startDate, endDate, onSuccess, onFail) {
		self.onSuccess = onSuccess;
        self.onFail = onFail;

        var hostname = WatchUi.loadResource(Rez.JsonData.hostname);

		var url = hostname + "rest/users/day/search/0/0000000000";
		var parameters = {
			"criteria" => {
				"ranges" => [{
					"floorTs" => getTime(startDate),
					"ceilTs" => getTime(endDate)
				}]
			},
			"fields" => [
				"load.ride.tscore.ctl","load.ride.tscore.atl","load.ride.tscore.mask","load.ride.tscore.value",
				"load.swim.tscore.ctl","load.swim.tscore.atl","load.swim.tscore.mask","load.swim.tscore.value",
				"load.gym.tscore.ctl","load.gym.tscore.atl","load.gym.tscore.mask","load.gym.tscore.value",
				"load.walk.tscore.ctl","load.walk.tscore.atl","load.walk.tscore.mask","load.walk.tscore.value",
				"load.run.tscore.ctl","load.run.tscore.atl","load.run.tscore.mask","load.run.tscore.value",
				"restingBpm", "weight"]
		};

		new Resource().send(url, "post", parameters, method(:success), method(:fail));
	}

	function success(responseCode, data) {
		var results = data["result"]["results"];

		var fieldsConverter = new FieldsConverter();
		var dailyLoads = fieldsConverter.convertAll(results);

		Logger.log("TodaysPlanStatusResource", "converted daily loads = " + dailyLoads.size());

		onSuccess.invoke(dailyLoads);
	}

	function fail(responseCode, data) {
		Logger.log("TodaysPlanStatusResource", "failed " + data);
		onFail.invoke(data);
	}

	function getTime(date) {
		return date.value().toString() + "000";
	}
}

