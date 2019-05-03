using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using Toybox.Attention;
using LogMonkey as Log;

class MainView extends WatchUi.View {
	hidden var mainViewGraphics;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var settingsRepository = new SettingsRepository();
        var selectedFields = settingsRepository.getSelectedFields();

        Log.Debug.logMessage("MainView", "selectedFields = " + selectedFields);

        mainViewGraphics = new MainViewGraphics(dc, selectedFields);
        mainViewGraphics.init();
    }

    function onShow() {
        var dailyLoadRepository = new DailyLoadRepository();
        dailyLoadRepository.getToday(method(:onRepoSuccess), method(:onRepoFail));
    }

    function onUpdate(dc) {
    }

    function onHide() {
    }

    function onRepoSuccess(dailyLoads) {
        setValues(dailyLoads[dailyLoads.size() - 1]);
    }

    function onRepoFail(dailyLoads) {
        Log.Debug.logMessage("MainView", "repository responded with error, loading old or default values");

		AttentionTools.vibrate();
        setValues(dailyLoads[dailyLoads.size() - 1]);
    }

    function setValues(dailyLoad) {
        Log.Debug.logMessage("MainView", "setValues");

		mainViewGraphics.setFieldValues(dailyLoad);

        AttentionTools.backlight();

        WatchUi.requestUpdate();
    }
}
