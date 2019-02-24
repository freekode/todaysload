class OAuthResource {
    hidden var _complete;
    hidden var _onSuccess;

    function initialize(onSuccess) {
        _complete = false;
        _onSuccess = onSuccess;

        Communications.registerForOAuthMessages(method(:oAuthReceived));
    }

    function send() {
        Communications.makeOAuthRequest(
            $.HOST + "authorize/" + $.CLIENT_ID,
            {},
            "https://localhost",
            Communications.OAUTH_RESULT_TYPE_URL,
            { "code"=>"code" });
    }

    function getAccessToken(code) {
        // Make HTTPS POST request to request the access token
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
		var repo = new TokenRepository();

        var token = data["access_token"];
        repo.save(token);

        System.println("authenticated token = " + repo.get());

        _onSuccess.invoke();
	}

}
