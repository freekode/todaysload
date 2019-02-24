using Toybox.Application;

class MainApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        System.println("started");
    }

    function onStop(state) {
    }

    function getInitialView() {
    	System.println("initial view");

    	var token = new TokenRepository().get();

        if (!System.getDeviceSettings().phoneConnected) {
            return [ new ConnectToGcmView() ];
        } else if (token == null) {
            return [ new LoginView(), new LoginDelegate() ];
        } else {
            return [ new MainView() ];
        }
    }
}
