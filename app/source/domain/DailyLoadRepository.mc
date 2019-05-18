using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Application.Storage as Storage;
using Toybox.Time.Gregorian;

class DailyLoadRepository {
	hidden var onSuccess;
    hidden var onFail;

	function getToday(onSuccess, onFail) {
		getLastNDays(0, onSuccess, onFail);
	}

	function getLastNDays(nDays, onSuccess, onFail) {
        self.onSuccess = onSuccess;
        self.onFail = onFail;

        var today = Time.today();
        var nDaysDuration = new Time.Duration(Gregorian.SECONDS_PER_DAY * nDays);
        var nDaysAgo = today.subtract(nDaysDuration);

        var resource = new TodaysPlanStatusResource();
        resource.request(nDaysAgo, today, method(:successResponse), method(:failResponse));
    }

    function get() {
        var array = Storage.getValue("dailyLoads");

        var dailyLoads = [];
        for(var i = 0; i < array.size(); i++) {
            var dailyLoad = new DailyLoad(array[i]);
            dailyLoads.add(dailyLoad);
        }

        return dailyLoads;
    }

    function save(array) {
        var value = Storage.setValue("dailyLoads", array);
        if (value == null) {
            return [];
        }

        return value;
    }

	function successResponse(dailyLoads) {
        save(dailyLoads);
        Logger.log("DailyLoadRepository", "dailyLoads saved = " + dailyLoads);

        onSuccess.invoke(get());
    }

    function failResponse(data) {
        Logger.log("DailyLoadRepository", "fail response " + data);
		var dailyLoads = get();
        if (dailyLoads.size == 0) {
	        Logger.log("DailyLoadRepository", "save empty");

            dailyLoads = [DailyLoad.empty()];
            save(dailyLoads);
        }

        onFail.invoke(get());
    }
}
