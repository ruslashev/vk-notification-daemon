import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: signInPage

	SilicaFlickable {
		anchors.fill: parent

		Column {
			id: textInputsColumn
			width: parent.width

			PageHeader {
				title: qsTr("Sign in")
			}

			TextField {
				id: login
				width: parent.width

				inputMethodHints: Qt.ImhEmailCharactersOnly
				focus: true
				placeholderText: "E-mail or Login"
				label: placeholderText
				EnterKey.onClicked: {
					password.focus = true;
				}
			}
			TextField {
				id: password
				width: parent.width

				echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password
				placeholderText: "Password"
				label: placeholderText

				// onStatusChanged: {
				// 	if (status == PageStatus.Active) {
				// 		pageStack.pushAttached(attachedPage)
				// 	}
				// }
				EnterKey.onClicked: {
					parent.focus = true;
				}
			}

			TextSwitch {
				id: showPassword
				checked: false
				text: qsTr("Show password")
			}
		}
	}
}

