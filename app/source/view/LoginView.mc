using Toybox.WatchUi;

class LoginView extends WatchUi.View {
    hidden var running;

    function initialize() {
        View.initialize();
        running = false;
    }

    function onLayout(dc) {
        UiTools.clear(dc);

        var openPhoneMessage = WatchUi.loadResource(Rez.Strings.openPhone);

        dc.drawText(120, 90,
            Graphics.FONT_TINY,
            openPhoneMessage,
            Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onUpdate(dc) {
    }

    function onShow() {
        if(running == false) {
            var resource = new OAuthResource(method(:callback));
            resource.request();
            running = true;
        }
    }

    function callback() {
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
