class Resource {
	var _onSuccess;
	var _onFail;

	function send(url, method, parameters, onSuccess, onFail) {
		_onSuccess = onSuccess;
		_onFail = onFail;

        var requestMethod;
        if (method.equals("post")) {
            requestMethod = Communications.HTTP_REQUEST_METHOD_POST;
        } else {
            requestMethod = Communications.HTTP_REQUEST_METHOD_GET;
        }

        var options = {
            :method => requestMethod,
            :headers => getHeaders()
        };

        System.println("resource url = " +  url);

		var responseCallback = method(:callback);

        Communications.makeWebRequest(url, parameters, options, responseCallback);
    }

    function callback(responseCode, data) {
        if (responseCode != 200 && _onFail != null) {
            System.println("ERROR [" + responseCode + "] " + data);
            _onFail.invoke(responseCode, data);
        } else {
            _onSuccess.invoke(responseCode, data);
        }
    }

    function getHeaders() {
        return {
            "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
            "Authorization" => "Bearer " + TokenRepository.get()
        };
    }
}
