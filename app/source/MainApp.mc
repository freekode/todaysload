using Toybox.Application;
using LogMonkey as Log;

class MainApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        Log.Debug.logMessage("MainApp", "started");
    }

    function onStop(state) {
    }

    function getInitialView() {
    	Log.Debug.logMessage("MainApp", "initial view");

    	var token = new TokenRepository().get();

		if (token != null) {
            return [ new MainView() ];
		} else if (!System.getDeviceSettings().phoneConnected) {
            return [ new ConnectToGcmView() ];
		} else {
            return [ new LoginView(), new LoginDelegate() ];
		}
    }
}
