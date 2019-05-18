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

	hidden var dailyLoadCommand;
	hidden var errorOccured = false;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var settingsRepository = new SettingsRepository(new Settings().FIELDS_MAP);
        selectedFields = settingsRepository.getSelectedFields();

        fieldNames = getFieldNames(selectedFields);
    }

    function onShow() {
        var resource = new TodaysPlanStatusResource(new Settings());
        dailyLoadCommand = new DailyLoadCommand(resource);
        dailyLoadCommand.commandLastNDays(0, method(:onRepoSuccess), method(:onRepoFail));
    }

    function onUpdate(dc) {
        Logger.log("MainView", "up");

		var dailyLoads = new DailyLoadRepository(new Settings().DAILY_LOADS_STORAGE_KEY).get();
        var values = getValues(dailyLoads);

        new MainViewGraphics().draw(dc, errorOccured, fieldNames, values);
    }

    function onHide() {
    }

    function onRepoSuccess(dailyLoads) {
        new DailyLoadRepository(new Settings().DAILY_LOADS_STORAGE_KEY).save(dailyLoads);
        WatchUi.requestUpdate();
    }

    function onRepoFail(data) {
		showWarning();
        WatchUi.requestUpdate();
    }

    function getValues(dailyLoads) {
        if (dailyLoads.size() == 0) {
            return UiTools.getArrayOfItems("...", selectedFields.size());
        }

        var dailyLoad = dailyLoads[dailyLoads.size() - 1];
        return dailyLoad.getStringValues(selectedFields);
    }

    function getFieldNames(fieldsIds) {
        var fieldsTitles = new Settings().FIELDS_TITLES;

        var titles = [];
        for(var i = 0; i < fieldsIds.size(); i++) {
            var fieldId = fieldsIds[i];
            titles.add(fieldsTitles[fieldId]);
        }

        return titles;
    }

    function showWarning() {
        errorOccured = true;

        var timer = new Timer.Timer();
        timer.start(method(:hideWarning), 2000, false);
    }

    function hideWarning() {
        errorOccured = false;
        WatchUi.requestUpdate();
    }
}
