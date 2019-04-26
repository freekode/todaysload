using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using LogMonkey as Log;

class MainViewGraphics {
	var yInit = 25;
	var yFields = yInit + 35;
    var yPadding = 25;
	var xFieldNames = 115;
	var xFieldValues = xFieldNames + 10;
    var xTitle;

    function init(dc) {
        xTitle = dc.getWidth() / 2;

        clear(dc);

		drawTitle(dc);

		drawFieldsNames(dc);

		drawFieldValues(dc, ["...", "...", "...", "...", "...", "..."]);
    }

    function drawTitle(dc) {
        dc.setColor(Graphics.COLOR_DK_RED, Graphics.COLOR_BLACK);
		dc.drawText(xTitle, yInit,
            Graphics.FONT_MEDIUM,
            WatchUi.loadResource(Rez.Strings.title),
            Graphics.TEXT_JUSTIFY_CENTER);

        return yInit;
    }

    function drawFieldsNames(dc) {
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;
        var font = Graphics.FONT_SMALL;
        var amount = 6;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return drawColumn(dc, xFieldNames, yFields, amount, justification, font, [
            WatchUi.loadResource(Rez.Strings.ctl), WatchUi.loadResource(Rez.Strings.atl),
            WatchUi.loadResource(Rez.Strings.tscore), WatchUi.loadResource(Rez.Strings.tsb),
            WatchUi.loadResource(Rez.Strings.tsbr), WatchUi.loadResource(Rez.Strings.restHr)
        ]);
    }

    function drawFieldValues(dc, values) {
        var justification = Graphics.TEXT_JUSTIFY_LEFT;
        var font = Graphics.FONT_SMALL;
        var amount = 6;

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return drawColumn(dc, xFieldValues, yFields, amount, justification, font, values);
    }

    function drawColumn(dc, x, y, amount, justification, font, values) {
	    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

	    for(var i = 0; i < amount; i++) {
	        dc.drawText(x, y, font, "       ", justification);
	        dc.drawText(x, y, font, values[i], justification);

            y += yPadding;
        }

        return y;
	}

    function clear(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
    }
}
