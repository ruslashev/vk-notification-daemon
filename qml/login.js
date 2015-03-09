.import "super-secret-key.js" as SSK

function directToPage()
{
	var AppId       = SSK.getSuperSecretKey()
	var Permissions = 'notify'
	var Redirect    = 'https://oauth.vk.com/blank.html'
	var Display     = 'mobile'
	var ApiVersion  = '5.28'
	var url = 'https://oauth.vk.com/authorize?' +
		'client_id=' + AppId + '&' +
		'scope=' + Permissions + '&' +
		'redirect_uri=' + Redirect + '&' +
		'display=' + Display + '&' +
		'v=' + ApiVersion + '&' +
		'response_type=token'

	console.debug("request url: " + url)

	webView.url = url
	webView.reload()
}

function pageLoadingFinished(url)
{
	console.debug("URL loaded: " + url)
}

