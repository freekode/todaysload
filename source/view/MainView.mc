using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;

class MainView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.TodayStatus(dc));
    }

    function onShow() {
        new DailyLoadRepository().request(method(:onRepositoryResponse));
    }

    function onUpdate(dc) {
        View.onUpdate(dc);
    }

    function onHide() {
    }

    function onRepositoryResponse(dailyLoads) {
        System.println("repository responded = " + dailyLoads);
        setValues(dailyLoads[0]);
    }

    function setValues(status) {
        System.println("setValues");

        var ctl = status._combinedCtl.toNumber().toString();
        var atl = status._combinedAtl.toNumber().toString();
        var tscore = status._combinedTscore.toNumber().toString();
        var tsb = status._combinedTsb.toNumber().toString();
        var tsbr = status._combinedTsbr.toNumber().toString();
        var restHr = status._restHr.toNumber().toString();

        configuraValue(ctl, "ctl");
        configuraValue(atl, "atl");
        configuraValue(tscore, "tscore");
        configuraValue(tsb, "tsb");
        configuraValue(tsbr, "tsbr");
        configuraValue(restHr, "restHr");

        WatchUi.requestUpdate();
    }

    function configuraValue(value, id) {
        var drawable = View.findDrawableById(id);
        drawable.setText(value);
        drawable.setLocation(drawable.locX + 10, drawable.locY);
    }
}
