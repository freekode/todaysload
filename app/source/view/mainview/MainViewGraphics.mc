using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;

class MainViewGraphics {
	hidden var yInit = 25;
	hidden var yFields = yInit + 35;
	hidden var xFieldNames = 115;
	hidden var xFieldValues = xFieldNames + 10;
	hidden var height = 180;

    function draw(dc, visibleWarning, fieldNames, values) {
        UiTools.clear(dc);

		drawFieldsNames(dc, fieldNames);

		drawFieldValues(dc, values);

		if (visibleWarning) {
	        UiTools.drawWarning(dc);
		}
    }

    hidden function drawFieldsNames(dc, names) {
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;
        var font = Graphics.FONT_SMALL;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(dc, xFieldNames, yInit, height, justification, font, names);
    }

    hidden function drawFieldValues(dc, values) {
        var justification = Graphics.TEXT_JUSTIFY_LEFT;
        var font = Graphics.FONT_SMALL;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(dc, xFieldValues, yInit, height, justification, font, values);
    }
}
