using Toybox.Communications;

(:background)
class TodaysPlanStatusResource extends AbstractResource {
	hidden var onSuccess;
    hidden var onFail;
    hidden var settings;

    function initialize(settings) {
        self.settings = settings;
    }

	function request(startDate, endDate, onSuccess, onFail) {
		self.onSuccess = onSuccess;
        self.onFail = onFail;

		var url = settings.HOSTNAME + "rest/users/day/search/0/0000000000";
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
				"restingBpm"],
			"opts" => 3
		};

		send(url, "post", parameters);
	}

	function success(responseCode, data) {
		var jsonArray = data["result"]["results"];

		var fieldsConverter = new FieldsConverter(settings.SPORT_TYPES);
		var dailyLoads = fieldsConverter.convertAll(jsonArray);

		Logger.log("TodaysPlanStatusResource", "converted daily loads = " + dailyLoads.size());

		onSuccess.invoke(dailyLoads);
		onSuccess = null;
	}

	function fail(responseCode, data) {
		Logger.log("TodaysPlanStatusResource", "failed " + data);
		onFail.invoke(data);
		onFail = null;
	}

	function getTime(date) {
		return date.value().toString() + "000";
	}
}

