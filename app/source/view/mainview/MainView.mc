using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using Toybox.Attention;
using Toybox.Time.Gregorian;
using LogMonkey as Log;

class MainView extends WatchUi.View {
	hidden var mainViewGraphics;
	hidden var selectedFields;

	hidden var fieldNames;
	hidden var fieldValues;
	hidden var visibleWarning = false;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var settingsRepository = new SettingsRepository();
        selectedFields = settingsRepository.getSelectedFields();

        fieldNames = getFieldNames(selectedFields);
        fieldValues = UiTools.getArrayOfItems("...", selectedFields.size());

        mainViewGraphics = new MainViewGraphics(dc);
    }

    function onShow() {
        var dailyLoadRepository = new DailyLoadRepository();
        dailyLoadRepository.getLastNDays(1, method(:onRepoSuccess), method(:onRepoFail));
    }

    function onUpdate(dc) {
        mainViewGraphics.draw(visibleWarning, fieldNames, fieldValues);

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
    }

    function onHide() {
    }

    function onRepoSuccess(dailyLoads) {
        setValues(dailyLoads[dailyLoads.size() - 1]);
    }

    function onRepoFail(dailyLoads) {
        Log.Debug.logMessage("MainView", "repository responded with error, loading old or default values");

		UiTools.vibrate();

		showWarning();

        setValues(dailyLoads[dailyLoads.size() - 1]);
    }

    function setValues(dailyLoad) {
        fieldValues = dailyLoad.getStringValues(selectedFields);

        UiTools.backlight();

        WatchUi.requestUpdate();
    }

    function getFieldNames(fieldsIds) {
        var fieldsTitles = WatchUi.loadResource(Rez.JsonData.fieldsTitles);

        var titles = [];
        for(var i = 0; i < fieldsIds.size(); i++) {
            var fieldId = fieldsIds[i];
            titles.add(fieldsTitles[fieldId]);
        }

        return titles;
    }

    function showWarning() {
        visibleWarning = true;

        var timer = new Timer.Timer();
        timer.start(method(:hideWarning), 2000, false);
    }

    function hideWarning() {
        visibleWarning = false;
        WatchUi.requestUpdate();
    }
}
