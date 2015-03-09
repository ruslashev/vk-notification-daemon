import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

Page {
	id: webViewPage

	SilicaWebView {
		id: webView
		anchors.fill: parent

		opacity: 0

		url: "http://example.com"

		onLoadingChanged: {
			if (loadRequest.status === WebView.LoadSucceededStatus) {
				opacity = 1
			} else {
				opacity = 0
			}
		}

		FadeAnimation on opacity {}
	}

	ViewPlaceholder {
		enabled: webView.opacity === 0 && !webView.loading
		text: "Error loading login page"
		hintText: "Check network connectivity and tap to reload"
	}

	MouseArea {
		anchors.fill: webView
		enabled: webView.opacity === 0
		onClicked: webView.reload()
	}
}

