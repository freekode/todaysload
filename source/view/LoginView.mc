using Toybox.WatchUi;

class LoginView extends WatchUi.View {
    hidden var _running;

    function initialize() {
        View.initialize();
        _running = false;
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.LoginLayout(dc));
    }

    function onShow() {
        if(_running == false) {
            var resource = new OAuthResource(method(:onSuccess));
            resource.send();
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
