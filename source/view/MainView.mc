using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
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
        new DailyLoadRepository().request(method(:onRepositoryResponse));
    }

    function onUpdate(dc) {
        if (values.size() > 0) {
            mainViewGraphics.drawFieldValues(dc, values);
        }
    }

    function onHide() {
    }

    function onRepositoryResponse(dailyLoads) {
        Log.Debug.logMessage("MainView", "repository responded = " + dailyLoads);
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

        WatchUi.requestUpdate();
    }
}
