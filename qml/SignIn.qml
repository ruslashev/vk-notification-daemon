import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: signInPage

	onStatusChanged: {
		if (status == PageStatus.Active) {
			pageStack.pushAttached(signInLoading)
		}
	}

	SilicaFlickable {
		anchors.fill: parent

		Column {
			id: textInputsColumn
			width: parent.width

			PageHeader {
				title: "Sign in"
			}

			TextField {
				id: login
				width: parent.width

				inputMethodHints: Qt.ImhEmailCharactersOnly
				focus: true
				placeholderText: "E-mail or Login"
				label: placeholderText
				EnterKey.onClicked: password.focus = true
				EnterKey.iconSource: "image://theme/icon-m-enter-accept"
			}
			TextField {
				id: password
				width: parent.width

				echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password

				placeholderText: "Password"
				label: placeholderText
				EnterKey.onClicked: pageStack.navigateForward(PageStackAction.Animated)
				EnterKey.iconSource: "image://theme/icon-m-enter-next"
			}

			TextSwitch {
				id: showPassword
				text: "Show password"
			}
		}
	}

	Page {
		id: signInLoading

		backNavigation: false

		Column {
			width: parent.width
			anchors.centerIn: parent
			spacing: Theme.paddingSmall

			BusyIndicator {
				running: true
				size: BusyIndicatorSize.Large
				anchors.horizontalCenter: parent.horizontalCenter
			}
			InfoLabel {
				text: "Loading..."
			}
		}
	}
}

