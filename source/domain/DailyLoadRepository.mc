using Toybox.Application;
using LogMonkey as Log;

class DailyLoadRepository {
	var _callback;

	function request(callback) {
		_callback = callback;

		var resource = new TodaysPlanStatusResource(Time.today(), Time.today(), method(:onResourceReponse));
        resource.get();
	}

	function onResourceReponse(dailyLoads) {
        save(dailyLoads);
        Log.Debug.logMessage("DailyLoadRepository", "dailyLoads saved = " + dailyLoads);

        _callback.invoke(get());
    }

	function get() {
		var array = Application.getApp().getProperty($.PREFIX + "dailyLoads");

        var dailyLoads = [];
        for(var i = 0; i < array.size(); i++) {
            var dailyLoad = new DailyLoad(array[i]);
            dailyLoads.add(dailyLoad);
        }

        return dailyLoads;
	}

	function save(array) {
		Application.getApp().setProperty($.PREFIX + "dailyLoads", array);
	}
}
