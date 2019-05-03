using Toybox.WatchUi;
using LogMonkey as Log;

class LoginView extends WatchUi.View {
    hidden var _running;

    function initialize() {
        View.initialize();
        _running = false;
    }

    function onLayout(dc) {
        UiTools.clear(dc);

        var openPhoneMessage = WatchUi.loadResource(Rez.Strings.openPhone);

        dc.drawText(120, 90,
            Graphics.FONT_TINY,
            openPhoneMessage,
            Graphics.TEXT_JUSTIFY_CENTER);

//        var writer = new WrapText();
//        var posY = 50;
//        posY = writer.writeLines(dc, openPhoneMessage, Graphics.FONT_TINY, posY);
    }

    function onUpdate(dc) {
    }

    function onShow() {
        if(_running == false) {
            var resource = new OAuthResource(method(:onSuccess));
            resource.request();
            _running = true;
        }
    }

    function onSuccess() {
		WatchUi.switchToView(new MainView(), null, WatchUi.SLIDE_IMMEDIATE);
    }

    function onFail() {
    }
}

class LoginDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }
}
