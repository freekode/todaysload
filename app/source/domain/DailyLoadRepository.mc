using Toybox.Application.Storage as Storage;

class DailyLoadRepository {
	hidden var storageKey;

	function initialize(storageKey) {
		self.storageKey = storageKey;
	}

    function get() {
        var array = Storage.getValue(storageKey);

        if (array == null || array.size() == 0) {
            return [];
        }

        var dailyLoads = [];
        for(var i = 0; i < array.size(); i++) {
            var dailyLoad = new DailyLoad(array[i]);
            dailyLoads.add(dailyLoad);
        }

        return dailyLoads;
    }

    function save(array) {
        Logger.log("DailyLoadRepository", "dailyLoads saved = " + array);
        Storage.setValue(storageKey, array);
    }
}
