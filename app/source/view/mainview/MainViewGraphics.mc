using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using LogMonkey as Log;

class MainViewGraphics {
	hidden var yInit = 25;
	hidden var yFields = yInit + 35;
    hidden var yPadding = 25;
	hidden var xFieldNames = 115;
	hidden var xFieldValues = xFieldNames + 10;

	hidden var _dc;
	hidden var _fieldsIds;

	function initialize(dc, fieldsIds) {
		_dc = dc;
		_fieldsIds = fieldsIds;
	}

    function init() {
        Log.Debug.logMessage("MainViewGraphics", "width = " + _dc.getWidth() + "; height = " + _dc.getHeight());

        UiTools.clear(_dc);

		drawTitle(_dc);

		drawFieldsNames(_dc);

		drawFieldValuesLoading(_dc);
    }

    function setFieldValues(dailyLoad) {
        var values = dailyLoad.getValues(_fieldsIds);

		var stringValues = UiTools.mapToStrings(values);

        drawFieldValues(_dc, stringValues);
    }

    hidden function drawFieldValuesLoading(dc) {
        var loadingDots = "...";

        var values = [];
        for(var i = 0; i < _fieldsIds.size(); i++) {
            values.add(loadingDots);
        }

		drawFieldValues(dc, values);
    }

    hidden function drawTitle(dc) {
        var xTitle = dc.getWidth() / 2;

        dc.setColor(0xff5555, Graphics.COLOR_BLACK);
		dc.drawText(xTitle, yInit,
            Graphics.FONT_MEDIUM,
            WatchUi.loadResource(Rez.Strings.title),
            Graphics.TEXT_JUSTIFY_CENTER);

        return yInit;
    }

    hidden function drawFieldsNames(dc) {
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;
        var font = Graphics.FONT_SMALL;
        var titles = getTitles();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(dc, xFieldNames, yFields, yPadding, justification, font, titles);
    }

    hidden function drawFieldValues(dc, values) {
        var justification = Graphics.TEXT_JUSTIFY_LEFT;
        var font = Graphics.FONT_SMALL;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(dc, xFieldValues, yFields, yPadding, justification, font, values);
    }

    hidden function getTitles() {
        var fieldsTitles = WatchUi.loadResource(Rez.JsonData.fieldsTitles);

        var titles = [];
        for(var i = 0; i < _fieldsIds.size(); i++) {
            var fieldId = _fieldsIds[i];
            titles.add(fieldsTitles[fieldId]);
        }

        return titles;
    }
}
