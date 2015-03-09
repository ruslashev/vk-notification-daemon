function directToPage()
{
	var Permissions = 'notify'
	var Redirect    = 'https://oauth.vk.com/blank.html'
	var Display     = 'mobile'
	var ApiVersion  = '5.28'
	var url = 'https://oauth.vk.com/authorize?' +
		// client_id=APP_ID&
		'scope=' + Permissions + '&' +
		'redirect_uri=' + Redirect + '&' +
		'display=' + Display + '&' +
		'v=' + ApiVersion + '&' +
		'response_type=token'

	console.debug("request url: " + url)

	webView.url = "http://example.com"
	webView.reload()
}

function pageLoadingFinished(url)
{
	console.debug("URL loaded: " + url)
}

