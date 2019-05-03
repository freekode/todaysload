using Toybox.WatchUi;

class UiTools {
	hidden var _dc;

	function drawColumn(dc, x, y, paddingBottom, justification, font, values) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        for(var i = 0; i < values.size(); i++) {
            dc.drawText(x, y, font, "       ", justification);
            dc.drawText(x, y, font, values[i], justification);

            y += paddingBottom;
        }

        return y;
    }

    function clear(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
    }

    function mapToStrings(array) {
        var mappedArray = [];
        for(var i = 0; i < array.size(); i++) {
            var value = array[i];
            mappedArray.add(value.toNumber().toString());
        }

        return mappedArray;
    }

    function showWarning(dc) {
        _dc = dc;

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
}
