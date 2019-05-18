class OAuthResource {
    hidden var onSuccess;
    hidden var clientId;
    hidden var clientSecret;
    hidden var hostname;

    function initialize(clientId, clientSecret, hostname) {
        self.clientId = clientId;
        self.clientSecret = clientSecret;
        self.hostname = hostname;

        Communications.registerForOAuthMessages(method(:callback));
    }

    function request(onSuccess) {
        self.onSuccess = onSuccess;

        Communications.makeOAuthRequest(
            hostname + "authorize/" + clientId,
            {},
            "https://localhost",
            Communications.OAUTH_RESULT_TYPE_URL,
            { "code"=>"code" });
    }

    function getAccessToken(code) {
        Communications.makeWebRequest(
            hostname + "rest/oauth/access_token",
            {
                "code" => code,
                "client_id" => clientId,
                "client_secret" => clientSecret,
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

	function callback(data) {
	    var code = data.data["code"];
	    getAccessToken(code);
	}

	function tokenReceived(responseCode, data) {
		if (responseCode != 200) {
            Logger.log("OAuthResource", "authentication failed = " + responseCode);
	        onSuccess = null;
            return;
        }

        var token = data["access_token"];

		var repo = new TokenRepository();
        repo.save(token);

        Logger.log("OAuthResource", "authenticated token = " + repo.get());

        onSuccess.invoke();
        onSuccess = null;
	}
}
