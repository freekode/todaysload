(:background)
class DailyLoadCommand {
	hidden var onSuccess;
    hidden var onFail;
    hidden var resource;

    function initialize(resource) {
        self.resource = resource;
    }

	function commandToday(onSuccess, onFail) {
		commandLastNDays(0, onSuccess, onFail);
	}

	function commandLastNDays(nDays, onSuccess, onFail) {
        self.onSuccess = onSuccess;
        self.onFail = onFail;


        var today = Time.today();
        var nDaysAgo = UiTools.substractFromDate(today, nDays);

        resource.request(nDaysAgo, today, method(:resourceSuccess), method(:resourceFail));
        resource = null;
    }

	function resourceSuccess(dailyLoads) {
        Logger.log("DailyLoadCommand", "dailyLoads received");
        onSuccess.invoke(dailyLoads);
        clearCallbacks();
    }

    function resourceFail(data) {
        Logger.log("DailyLoadCommand", "fail response " + data);
        onFail.invoke(data);
        clearCallbacks();
    }

    function clearCallbacks() {
        onSuccess = null;
        onFail = null;
    }
}
