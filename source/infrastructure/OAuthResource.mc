using LogMonkey as Log;

class OAuthResource {
    hidden var _complete;
    hidden var _onSuccess;

    function initialize(onSuccess) {
        _complete = false;
        _onSuccess = onSuccess;

        Communications.registerForOAuthMessages(method(:oAuthReceived));
    }

    function request() {
        Communications.makeOAuthRequest(
            $.HOST + "authorize/" + $.CLIENT_ID,
            {},
            "https://localhost",
            Communications.OAUTH_RESULT_TYPE_URL,
            { "code"=>"code" });
    }

    function getAccessToken(code) {
        Communications.makeWebRequest(
            $.HOST + "rest/oauth/access_token",
            {
                "code"=>code,
                "client_id"=>$.CLIENT_ID,
                "client_secret"=>$.CLIENT_SECRET,
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
