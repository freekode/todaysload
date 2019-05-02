using Toybox.WatchUi;
using LogMonkey as Log;

class OAuthResource {
    hidden var _complete;
    hidden var _onSuccess;
    hidden var _clientId;
    hidden var _clientSecret;
    hidden var _hostname;


    function initialize(onSuccess) {
        _complete = false;
        _onSuccess = onSuccess;

        _clientId = WatchUi.loadResource(Rez.JsonData.clientId);
        _clientSecret = WatchUi.loadResource(Rez.JsonData.clientSecret);
        _hostname = WatchUi.loadResource(Rez.JsonData.hostname);

        Communications.registerForOAuthMessages(method(:oAuthReceived));
    }

    function request() {
        Communications.makeOAuthRequest(
            _hostname + "authorize/" + _clientId,
            {},
            "https://localhost",
            Communications.OAUTH_RESULT_TYPE_URL,
            { "code"=>"code" });
    }

    function getAccessToken(code) {
        Communications.makeWebRequest(
            _hostname + "rest/oauth/access_token",
            {
                "code"=>code,
                "client_id"=>_clientId,
                "client_secret"=>_clientSecret,
                "grant_type"=>"authorization_code",
                "redirect_uri"=>"https://localhost"
            },
            {
                :method => Communications.HTTP_REQUEST_METHOD_POST,
                :headers => {
                    "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
                }
            },
            method(:tokenReceived)
        );
    }

	function oAuthReceived(data) {
	    var code = data.data["code"];
	    getAccessToken(code);
	}

	function tokenReceived(responseCode, data) {
		if (responseCode == 200) {
			var repo = new TokenRepository();

            var token = data["access_token"];
            repo.save(token);

            Log.Debug.logMessage("OAuthResource", "authenticated token = " + repo.get());

            _onSuccess.invoke();
		} else {
            Log.Debug.logMessage("OAuthResource", "authentication failed = " + responseCode + "; " + data);
		}

	}

}
