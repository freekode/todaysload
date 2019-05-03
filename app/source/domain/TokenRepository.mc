using Toybox.Application;

class TokenRepository {
	hidden var app;

	function initialize() {
		app = Application.getApp();
	}

	function get() {
		return app.getProperty("token");
	}

	function save(token) {
		app.setProperty("token", token);
	}
}
