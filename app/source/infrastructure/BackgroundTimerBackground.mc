using Toybox.Background;
using Toybox.System;

(:background)
class BackgroundTimerServiceDelegate extends System.ServiceDelegate {
	hidden var dailyLoadCommand;

    function initialize(dailyLoadCommand) {
        ServiceDelegate.initialize();

		self.dailyLoadCommand = dailyLoadCommand;
        Logger.log("BackgroundTimerServiceDelegate", "BackgroundTimerServiceDelegate created");
    }

    function onTemporalEvent() {
        Logger.log("BackgroundTimerServiceDelegate", "temporal event occured");

        dailyLoadCommand.commandLastNDays(0, method(:onRepoSuccess), method(:onRepoFail));
    }

    function onRepoSuccess(dailyLoads) {
        Background.exit(dailyLoads);
    }

    function onRepoFail(data) {
        Background.exit(null);
    }
}
