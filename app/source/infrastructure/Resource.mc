
class Resource {
	hidden var onSuccess;
	hidden var onFail;

	function send(url, method, parameters, onSuccess, onFail) {
		self.onSuccess = onSuccess;
		self.onFail = onFail;

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

        Logger.log("Resource", "resource url = " +  url);

        Communications.makeWebRequest(url, parameters, options, method(:callback));
    }

    function callback(responseCode, data) {
        if (responseCode != 200 && onFail != null) {
            Logger.log("Resource", "ERROR [" + responseCode + "] " + data);
            onFail.invoke(responseCode, data);
        } else {
            onSuccess.invoke(responseCode, data);
        }
    }

    function getHeaders() {
        return {
            "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
            "Authorization" => "Bearer " + new TokenRepository().get()
        };
    }
}
