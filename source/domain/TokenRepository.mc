using Toybox.Application;

class TokenRepository {

	function get() {
		return Application.getApp().getProperty($.PREFIX + "token");
	}

	function save(token) {
		Application.getApp().setProperty($.PREFIX + "token", token);
	}
}
