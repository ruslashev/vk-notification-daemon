import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

Page {
	id: webViewPage

	SilicaFlickable {
		id: menuFlickable
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.top

		PullDownMenu {
			id: pullDownMenu
			enabled: true
			MenuItem {
				text: "Reload"
				onClicked: webView.reload()
			}
		}
	}

	SilicaWebView {
		id: webView
		anchors.fill: parent
		opacity: 0

		url: "http://example.com"

		onLoadingChanged: {
			if (loadRequest.status == WebView.LoadSucceededStatus) {
				opacity = 1
				menuFlickable.anchors.top = parent.top
				menuFlickable.anchors.left = parent.left
				menuFlickable.anchors.right = parent.right
				menuFlickable.anchors.bottom = parent.top
				menuFlickable.pullDownMenu.enabled = false
				anchors.fill = parent
			} else {
				opacity = 0
				anchors.top = parent.top
				anchors.left = parent.left
				anchors.right = parent.right
				anchors.bottom = parent.top
				menuFlickable.pullDownMenu.enabled = true
				menuFlickable.anchors.fill = parent
			}
		}

		FadeAnimation on opacity {}
	}

	ViewPlaceholder {
		enabled: webView.opacity === 0 && !webView.loading
		text: "Error loading login page"
		hintText: "Check network connectivity and pull down to reload"
	}
}
