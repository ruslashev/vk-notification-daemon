import QtQuick 2.0
import QtWebKit 3.0
import Sailfish.Silica 1.0

Page {
	id: webViewPage

	allowedOrientations: Orientation.All

	property bool webViewLoadingSucceeded: false

	SilicaWebView {
		id: webView
		anchors.fill: parent
		anchors.rightMargin: webViewPage.isPortrait ? 0 : progressPanel.visibleSize
		anchors.bottomMargin: webViewPage.isPortrait ? progressPanel.visibleSize : 0

		url: "http://example.com"

		opacity: 0

		onLoadingChanged: {
			if (loadRequest.status === WebView.LoadSucceededStatus) {
				webViewLoadingSucceeded = true
				opacity = 1
			}
		}
	}

	SilicaFlickable {
		anchors.fill: parent
		visible: !webViewLoadingSucceeded
		ViewPlaceholder {
			id: loadingErrorPlaceholder
			text: "Error loading login page"
			hintText: "Check network connectivity and try again"
			enabled: true
			anchors.horizontalCenter: parent.horizontalCenter
		}
		Button {
			text: "Retry"
			onClicked: webView.reload()
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: loadingErrorPlaceholder.bottom
			anchors.topMargin: Theme.paddingLarge
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

