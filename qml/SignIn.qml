import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: signInPage

	SilicaFlickable {
		anchors.fill: parent

		PullDownMenu {
			MenuItem {
				text: qsTr("Show password")
				onClicked:
					password.echoMode =
						password.echoMode == TextInput.Password ?
							TextInput.Normal :
							TextInput.Password
			}
		}

		// todo : column
		PageHeader {
			id: header
			title: qsTr("Sign in")
		}

		TextField {
			id: login

			width: parent.width
			anchors.top: header.bottom

			inputMethodHints: Qt.ImhEmailCharactersOnly

			placeholderText: "E-mail or login"
			label: placeholderText
		}
		TextField {
			id: password

			width: parent.width
			anchors.top: login.bottom

			echoMode: TextInput.Password

			placeholderText: "Password"
			label: placeholderText
		}
	}
}

