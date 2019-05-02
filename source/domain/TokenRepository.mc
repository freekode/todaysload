using Toybox.Application;

class TokenRepository {

	function get() {
		return Application.getApp().getProperty("token");
	}

	function save(token) {
		Application.getApp().setProperty("token", token);
	}
}
