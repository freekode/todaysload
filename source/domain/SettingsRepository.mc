using Toybox.Application;

class SettingsRepository {

	function isShowCtl() {
		return Application.getApp().getProperty("showCtl");
	}

	function isShowAtl() {
		return Application.getApp().getProperty("showAtl");
	}

	function isShowTscore() {
		return Application.getApp().getProperty("showTscore");
	}

	function isShowTsb() {
		return Application.getApp().getProperty("showTsb");
	}

	function isShowTsbr() {
		return Application.getApp().getProperty("showTsbr");
	}

	function isShowRhr() {
		return Application.getApp().getProperty("showRhr");
	}
}
