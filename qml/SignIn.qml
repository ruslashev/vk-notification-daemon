import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

import "js/login.js" as Login

Component {
	id: webViewPage
	Dialog {
		canAccept: true
		acceptDestination: mainPage
		acceptDestinationAction: PageStackAction.Pop
		allowedOrientations: Orientation.All

		property bool webViewLoadingSucceeded: false
		property bool webViewLoadingStarted: false

		SilicaFlickable {
			width: parent.width
			height: parent.height
			SilicaWebView {
				id: webView

				anchors {
					fill: parent
					rightMargin: webViewPage.isPortrait ? 0 : progressPanel.visibleSize
					bottomMargin: webViewPage.isPortrait ? progressPanel.visibleSize : 0
				}

				url: Login.getLoginURL()

				opacity: 0

				onLoadingChanged: {
					if (loadRequest.status === WebView.LoadSucceededStatus) {
						webViewLoadingSucceeded = true
						opacity = 1
						var res = Login.webViewLoadingFinished(url)
						if (res === true) {
							pageStack.pop(undefined, PageStackAction.Animated)
						}
					}
				}
			}
		}

		SilicaFlickable {
			anchors.fill: parent
			visible: !webViewLoadingSucceeded && !webView.loading && !webViewLoadingStarted
			ViewPlaceholder {
				id: loadingErrorPlaceholder
				text: "Error loading login page"
				hintText: "Plese check network connectivity and try again"
				enabled: true
				anchors.horizontalCenter: parent.horizontalCenter
			}
			Button {
				text: "Retry"
				onClicked: webView.reload()
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: loadingErrorPlaceholder.bottom
					topMargin: Theme.paddingLarge
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
}

