using Toybox.Application;
using Toybox.Application.Storage as Storage;
using LogMonkey as Log;

class DailyLoadRepository {
	var _onSuccess;
    var _onFail;

	function getToday(onSuccess, onFail) {
		_onSuccess = onSuccess;
		_onFail = onFail;

		var resource = new TodaysPlanStatusResource(Time.today(), Time.today(), method(:successResponse), method(:failResponse));
        resource.request();
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
            dailyLoads = [DailyLoad.empty()];
            save(dailyLoads);
        }

        _onFail.invoke(get());
    }

	function get() {
		var array = Storage.getValue($.PREFIX + "dailyLoads");

        var dailyLoads = [];
        for(var i = 0; i < array.size(); i++) {
            var dailyLoad = new DailyLoad(array[i]);
            dailyLoads.add(dailyLoad);
        }

        return dailyLoads;
	}

	function save(array) {
		var value = Storage.setValue($.PREFIX + "dailyLoads", array);
		if (value == null) {
			return [];
		}

		return value;
	}
}
