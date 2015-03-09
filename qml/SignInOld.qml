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
				title: "Sign in"
			}

			TextField {
				id: loginTextField
				width: parent.width

				inputMethodHints: Qt.ImhEmailCharactersOnly
				focus: true
				placeholderText: "E-mail or Login"
				label: placeholderText
				EnterKey.onClicked: passwordTextField.focus = true
				EnterKey.iconSource: "image://theme/icon-m-enter-next"
			}
			TextField {
				id: passwordTextField
				width: parent.width

				echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password

				placeholderText: "Password"
				label: placeholderText
				EnterKey.onClicked: legacyLogin(loginTextField.text, passwordTextField.text)
				EnterKey.iconSource: "image://theme/icon-m-enter-accept"
			}

			TextSwitch {
				id: showPassword
				text: "Show password"
				checked: false
			}

			BusyIndicator {
				id: busyIndicator
				running: false
				size: BusyIndicatorSize.Large
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}

	function legacyLogin(login, password) {
		busyIndicator.running = true;
		console.debug("Login: " + login)
		console.debug("Password: " + password)
	}
}

