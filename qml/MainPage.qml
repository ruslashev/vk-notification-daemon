import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: mainPage

	onStatusChanged: {
		if (status == PageStatus.Active) {
			pageStack.pushAttached(Qt.resolvedUrl("SignIn.qml"))
		}
	}

	SilicaFlickable {
		anchors.fill: parent

		PageHeader {
			title: "Sign In"
		}

		ViewPlaceholder {
			enabled: true
			text: "Not Signed In"
			hintText: "Flick left to access the sign in page"
		}
	}
}

