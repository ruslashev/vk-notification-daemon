import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

import "js/sign-in.js" as SignInJS

Page {
	id: webViewPage

	// backNavigation: false
	// showNavigationIndicator: false

	allowedOrientations: Orientation.All

	property bool webViewLoadingSucceeded: false
	property bool webViewLoadingStarted: false

	SilicaWebView {
		id: webView

		anchors {
			fill: parent
			rightMargin: webViewPage.isPortrait ? 0 : progressPanel.visibleSize
			bottomMargin: webViewPage.isPortrait ? progressPanel.visibleSize : 0
		}

		url: SignInJS.getLoginURL()

		opacity: 0

		onLoadingChanged: {
			webViewLoadingStarted = true
			if (loadRequest.status === WebView.LoadSucceededStatus) {
				webViewLoadingSucceeded = true
				opacity = 1
				var res = SignInJS.webViewLoadingFinished(url)
				if (res === true) {
					pageStack.pop(undefined, PageStackAction.Animated)
				}
			}
		}
	}

	SilicaFlickable {
		anchors.fill: parent
		visible: !webViewLoadingSucceeded && !webView.loading && webViewLoadingStarted
		ViewPlaceholder {
			id: loadingErrorPlaceholder
			text: "Error loading login page"
			hintText: "Plese check network connectivity and try again"
			enabled: true // what
			anchors.horizontalCenter: parent.horizontalCenter
		}
		Button {
			text: "webView.reload() doesn't work\nand I don't know why. \nwhy would you even try to login\nwithout internet connection, dude?"
			onClicked: webView.reload()
			anchors {
				horizontalCenter: parent.horizontalCenter
				top: loadingErrorPlaceholder.bottom
				topMargin: Theme.paddingLarge + 25
			}
		}
	}

	DockedPanel {
		id: progressPanel

		open: webView.loading

		width: webViewPage.isPortrait ? parent.width : Theme.itemSizeExtraLarge + Theme.paddingLarge
		height: webViewPage.isPortrait ? Theme.itemSizeExtraLarge + Theme.paddingLarge : parent.height

		dock: webViewPage.isPortrait ? Dock.Bottom : Dock.Right

		ProgressCircle {
			anchors.centerIn: parent

			NumberAnimation on value {
				from: 0
				to: 1
				duration: 1000
				running: progressPanel.expanded
				loops: Animation.Infinite
			}
		}
	}
}

