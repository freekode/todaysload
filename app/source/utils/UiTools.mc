using Toybox.WatchUi;
using LogMonkey as Log;

class UiTools {
	function drawColumn(dc, x, y, height, justification, font, values) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

		var fontHeight = dc.getFontHeight(font);

		y += (height - (fontHeight * values.size())) / 2;
		fontHeight -= 2;

        for(var i = 0; i < values.size(); i++) {
            dc.drawText(x, y, font, values[i], justification);

            y += fontHeight;
        }

        return y;
    }

    function clear(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
    }

    function getArrayOfItems(item, times) {
		var values = [];
		for(var i = 0; i < times; i++) {
		    values.add(item);
		}

		return values;
	}

    function drawWarning(dc) {
        var rectangleHeight = 60;

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        dc.fillRectangle(0, 0, dc.getWidth(), rectangleHeight);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_RED);

        dc.drawText(dc.getWidth() / 2, rectangleHeight / 4,
                    Graphics.FONT_SMALL, "!", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function vibrate() {
        if (Attention has :vibrate) {
            var vibeData = [new Attention.VibeProfile(50, 250)];
            Attention.vibrate(vibeData);
        }
    }

    function backlight() {
        if (Attention has :backlight) {
            Attention.backlight(true);
        }
    }
}
