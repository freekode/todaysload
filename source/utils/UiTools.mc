using Toybox.WatchUi;

class UiTools {
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
}
