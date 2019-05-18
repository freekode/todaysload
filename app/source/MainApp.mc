using Toybox.Application;
using Toybox.Background;
using Toybox.System;

class MainApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
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
