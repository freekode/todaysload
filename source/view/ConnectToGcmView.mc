using Toybox.WatchUi;
using LogMonkey as Log;


class ConnectToGcmView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        UiTools.clear(dc);

	    var phoneConnection = WatchUi.loadResource(Rez.Strings.phoneConnection);

	    dc.drawText(
            120,
            90,
            Graphics.FONT_TINY,
            phoneConnection,
            Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onUpdate(dc) {
    }
}
