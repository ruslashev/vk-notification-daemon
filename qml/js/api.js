function get(url, processingCallback)
{
	var req = new XMLHttpRequest();
	req.open("GET", url, true);
	req.onreadystatechange = function() {
		if (req.readyState === XMLHttpRequest.DONE) {
			var returnedJson = JSON.parse(req.responseText);
			console.log("Api returned for " + url);
			console.log(JSON.stringify(returnedJson));
			if (returnedJson.hasOwnProperty("error")) {

			} else {
				processingCallback(returnedJson.response);
			}
		}
	}
	req.send();
}

function makeRequest(method, access_token, params, processingCallback)
{
	var url = "https://api.vk.com/method/" +
		method +
		"?access_token=" + access_token +
		"&v=5.29";
	for (var k in params) {
		url += "&" + k + "=" + params[k];
	}
	console.log("request url: " + url);

	get(url, processingCallback);
}

