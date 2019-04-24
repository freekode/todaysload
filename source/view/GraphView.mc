using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;
using Toybox.System;
using Toybox.Time;
using LogMonkey as Log;

class GraphView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        var graphWidth = 200;
        var graphHeight = 40;
        var values = [100, 20, 60, 50, 90];

        clear(dc);

        drawGraph(dc, graphWidth, graphHeight, values);

    }

    function clear(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
    }

    function drawGraph(dc, graphWidth, graphHeight, values) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        var cellWidth = graphWidth / values.size();

        var graphStartY = (height - graphHeight) / 2;
        var graphStartX = (width - graphWidth) / 2;

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.drawRectangle(graphStartX, graphStartY, graphWidth, graphHeight);

        for(var i = 1; i < values.size(); i++) {
            var x = graphStartX + (cellWidth * i);

           dc.drawLine(x, graphStartY, x, graphStartY + graphHeight);
        }

		var barFillingWidth = 0.6;
		var barFillingHeight = 0.9;

		var barPaddingX = cellWidth * ((1.0 - barFillingWidth) / 2.0);
		var barWidth = cellWidth * barFillingWidth;
		var barMaxHeight = graphHeight * barFillingHeight;

        dc.setColor(0xff5555, Graphics.COLOR_BLACK);

        for(var i = 0; i < values.size(); i++) {
            var x = graphStartX + (cellWidth * i);

            var barValueHeight = values[i] / 100.0 * barMaxHeight;
			var barPaddingY = graphHeight - barValueHeight;

	        Log.Debug.logMessage("MainView", "val" + barValueHeight);

            dc.fillRectangle(x + barPaddingX, graphStartY + barPaddingY, barWidth, barValueHeight);
        }
    }

    function onShow() {
    }

    function onUpdate(dc) {
    }

    function onHide() {
    }
}

class GraphViewDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onTap(event) {
        Log.Debug.logMessage("GraphView", "tap event");
        WatchUi.switchToView(new MainView(), new MainViewDelegate(), WatchUi.SLIDE_LEFT);
        return true;
    }
}
