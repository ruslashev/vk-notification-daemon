function get(url, processingCallback)
{
	var req = new XMLHttpRequest();
	req.open("GET", url, true);
	req.onreadystatechange = function() {
		if (req.readyState === XMLHttpRequest.DONE) {
			processingCallback(JSON.parse(req.responseText).response);
		}
	}
	req.send();
}

function makeRequest(method, access_token, params, processingCallback)
{
	var url = "https://api.vk.com/method/" +
		method +
		"?access_token=" + access_token +
		"&v=5.28";
	for (var k in params) {
		url += "&" + k + "=" + params[k];
	}
	console.log("request url: " + url);

	get(url, processingCallback);
}

function getName(user_id)
{

}

