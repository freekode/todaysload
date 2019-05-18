(:background)
class AbstractResource {
	function send(url, method, parameters) {
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
        if (responseCode != 200) {
            Logger.log("Resource", "ERROR [" + responseCode + "] " + data);
            fail(responseCode, data);
        } else {
            success(responseCode, data);
        }
    }

    function success(responseCode, data) {
    }

    function fail(responseCode, data) {
    }

    function getHeaders() {
        return {
            "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
            "Authorization" => "Bearer " + new TokenRepository().get()
        };
    }
}
