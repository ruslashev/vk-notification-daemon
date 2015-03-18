.import "super-secret-key.js" as SSK

function getLoginURL()
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

	console.log("request url: " + url)

	return url
}

function pageLoadingFinished(url)
{
	console.log("URL loaded: " + url)

	var str = url.toString()

	var access_token_start = str.indexOf("access_token")
	var expires_in_start   = str.indexOf("&expires_in")
	var user_id_start      = str.indexOf("&user_id")

	var access_token = str.substring(access_token_start + 13, expires_in_start)
	var expires_in = str.substring(expires_in_start + 12, user_id_start)
	var user_id = str.substring(user_id_start + 9)

	console.log("Access token: " + access_token)
	console.log("Expires in: " + expires_in)
	console.log("User id: " + user_id)
}

