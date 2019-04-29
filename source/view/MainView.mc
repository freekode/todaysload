using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using Toybox.Attention;
using LogMonkey as Log;

class MainView extends WatchUi.View {

	var mainViewGraphics;

	var values = [];

    function initialize() {
        View.initialize();

        mainViewGraphics = new MainViewGraphics();
    }

    function onLayout(dc) {
        mainViewGraphics.init(dc);
    }

    function onShow() {
        new DailyLoadRepository().getToday(method(:onRepoSuccess), method(:onRepoFail));
    }

    function onUpdate(dc) {
        if (values.size() > 0) {
            mainViewGraphics.drawFieldValues(dc, values);
        }
    }

    function onHide() {
    }

    function onRepoSuccess(dailyLoads) {
        Log.Debug.logMessage("MainView", "repository responded = " + dailyLoads);
        setValues(dailyLoads[0]);
    }

    function onRepoFail(dailyLoads) {
        Log.Debug.logMessage("MainView", "repository responded with error, loading old or default values");

		vibrate();
        setValues(dailyLoads[0]);
    }

    function setValues(status) {
        Log.Debug.logMessage("MainView", "setValues");

        var ctl = status._combinedCtl.toNumber().toString();
        var atl = status._combinedAtl.toNumber().toString();
        var tscore = status._combinedTscore.toNumber().toString();
        var tsb = status._combinedTsb.toNumber().toString();
        var tsbr = status._combinedTsbr.toNumber().toString();
        var restHr = status._restHr.toNumber().toString();

		values = [ctl, atl, tscore, tsb, tsbr, restHr];

		backlight();

        WatchUi.requestUpdate();
    }

    function vibrate() {
		if (Attention has :vibrate) {
		    var vibeData = [new Attention.VibeProfile(50, 500)];
			Attention.vibrate(vibeData);
		}
    }

    function backlight() {
	    if (Attention has :backlight) {
	        Attention.backlight(true);
	    }
    }
}
