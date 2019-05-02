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

	var _dc;

	function initialize(dc) {
		_dc = dc;
	}

    function init() {
        Log.Debug.logMessage("MainViewGraphics", "width = " + _dc.getWidth() + "; height = " + _dc.getHeight());

        UiTools.clear(_dc);

		drawTitle();

		drawFieldsNames();

		drawFieldValues(["...", "...", "...", "...", "...", "..."]);
    }

    function showWarning() {
        _dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);
        _dc.fillRectangle(0, 0, 240, 20);

        var timer = new Timer.Timer();
        timer.start(method(:hideWarning), 2000, false);
    }

    function hideWarning() {
        _dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        _dc.fillRectangle(0, 0, 240, 20);

        WatchUi.requestUpdate();
    }

    function drawTitle() {
        var xTitle = _dc.getWidth() / 2;

        _dc.setColor(0xff5555, Graphics.COLOR_BLACK);
		_dc.drawText(xTitle, yInit,
            Graphics.FONT_MEDIUM,
            WatchUi.loadResource(Rez.Strings.title),
            Graphics.TEXT_JUSTIFY_CENTER);

        return yInit;
    }

    function drawFieldsNames() {
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;
        var font = Graphics.FONT_SMALL;

        _dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(_dc, xFieldNames, yFields, yPadding, justification, font, [
            WatchUi.loadResource(Rez.Strings.ctl), WatchUi.loadResource(Rez.Strings.atl),
            WatchUi.loadResource(Rez.Strings.tscore), WatchUi.loadResource(Rez.Strings.tsb),
            WatchUi.loadResource(Rez.Strings.tsbr), WatchUi.loadResource(Rez.Strings.restHr)
        ]);
    }

    function drawFieldValues(values) {
        var justification = Graphics.TEXT_JUSTIFY_LEFT;
        var font = Graphics.FONT_SMALL;

        _dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        return UiTools.drawColumn(_dc, xFieldValues, yFields, yPadding, justification, font, values);
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
