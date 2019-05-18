using Toybox.WatchUi;
using Toybox.Application;
using Toybox.Background;
using Toybox.System;

(:background)
class MainApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function getInitialView() {
        registerBackgroundPeriod();

        var token = new TokenRepository().get();

        if (token != null) {
            return [ new MainView() ];
        } else if (!System.getDeviceSettings().phoneConnected) {
            return [ new ConnectToGcmView() ];
        } else {
            return [ new LoginView(), new LoginDelegate() ];
        }
    }

    function getServiceDelegate() {
        var dailyLoadCommand = getDailyLoadCommand();
        var delegate = new BackgroundTimerServiceDelegate(dailyLoadCommand);

        return [delegate];
    }

    function onBackgroundData(dailyLoads) {
        if (dailyLoads == null) {
            return;
        }

        Logger.log("MainApp", "background received = " + dailyLoads);

        new DailyLoadRepository(new Settings().DAILY_LOADS_STORAGE_KEY).save(dailyLoads);

        WatchUi.requestUpdate();
    }

    hidden function registerBackgroundPeriod() {
        if (!(Toybox.System has :ServiceDelegate)) {
            Logger.log("MainApp", "background not available");
            return;
        }

		var lastTime = Background.getLastTemporalEventTime();
		if (lastTime == null) {
	        Background.registerForTemporalEvent(new Settings().BACKGROUND_PERIOD_DURATION);
		}
    }

    hidden function getDailyLoadCommand() {
        var resource = new TodaysPlanStatusResource(new Settings());
        return new DailyLoadCommand(resource);
    }
}
