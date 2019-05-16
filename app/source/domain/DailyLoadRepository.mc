using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Application.Storage as Storage;
using Toybox.Time.Gregorian;
using LogMonkey as Log;

class DailyLoadRepository {
	hidden var resource;

	hidden var _onSuccess;
    hidden var _onFail;

    function initialize() {
        resource = new TodaysPlanStatusResource();
    }

	function getToday(onSuccess, onFail) {
		getLastNDays(0, onSuccess, onFail);
	}

	function getLastNDays(nDays, onSuccess, onFail) {
        self._onSuccess = onSuccess;
        self._onFail = onFail;

        var today = Time.today();
        var nDaysDuration = new Time.Duration(Gregorian.SECONDS_PER_DAY * nDays);
        var nDaysAgo = today.subtract(nDaysDuration);

        resource.request(nDaysAgo, today, method(:successResponse), method(:failResponse));
    }

	function successResponse(dailyLoads) {
        save(dailyLoads);
        Log.Debug.logMessage("DailyLoadRepository", "dailyLoads saved = " + dailyLoads);

        _onSuccess.invoke(get());
    }

    function failResponse(data) {
        Log.Debug.logMessage("DailyLoadRepository", "fail response " + data);
		var dailyLoads = get();
        if (dailyLoads.size == 0) {
	        Log.Debug.logMessage("DailyLoadRepository", "save empty");

            dailyLoads = [DailyLoad.empty()];
            save(dailyLoads);
        }

        _onFail.invoke(get());
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
}