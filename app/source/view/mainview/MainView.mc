using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using Toybox.Attention;
using Toybox.Time.Gregorian;

class MainView extends WatchUi.View {
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
    }

    function onShow() {
        var dailyLoadRepository = new DailyLoadRepository();
        dailyLoadRepository.getLastNDays(0, method(:onRepoSuccess), method(:onRepoFail));
    }

    function onUpdate(dc) {
        var mainViewGraphics = new MainViewGraphics();
        mainViewGraphics.draw(dc, visibleWarning, fieldNames, fieldValues);
    }

    function onHide() {
    }

    function onRepoSuccess(dailyLoads) {
        setValues(dailyLoads[dailyLoads.size() - 1]);
    }

    function onRepoFail(dailyLoads) {
        Logger.log("MainView", "repository responded with error, loading old or default values");

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
