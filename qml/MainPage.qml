import QtQuick 2.0
import Sailfish.Silica 1.0

import "js/storage.js" as Storage
import "js/api.js" as Api

Page {
	id: mainPage

	allowedOrientations: Orientation.All

	property bool signedIn: false
	property string access_token_pty: ""

	function getNameAndAvatar()
	{
		var user_id = Storage.select("user_id");
		// pray for user_id
		Api.makeRequest("users.get", access_token_pty, { user_id: user_id },
		function(data) {
			console.log("data[0].first_name: " + data[0].first_name);
			console.log("data[0].last_name: " + data[0].last_name);
			nameLabel.text = data[0].first_name + " " + data[0].last_name;
		})
	}

	function checkIfSignedIn()
	{
		var access_token = Storage.select("access_token");
		console.log("Checking for access_token: " + access_token);
		if (access_token !== -1) {
			signedIn = true;
			access_token_pty = access_token;

			getNameAndAvatar();
		}
	}

	function resetLogin()
	{
		Storage.clearDB();
		Storage.constructDB();
		signedIn = false;
	}

	onStatusChanged: {
		if (status == PageStatus.Active) {
			Storage.constructDB();
			checkIfSignedIn();
		}
	}

	SilicaFlickable {
		anchors.fill: parent

		PullDownMenu {
			id: pullDownMenu
			MenuItem {
				text: "Sign In"
				visible: !signedIn
				onClicked: pageStack.push(Qt.resolvedUrl("SignIn.qml"))
			}
			MenuItem {
				text: "Log out"
				visible: signedIn
				onClicked: resetLogin();
			}
		}

		ViewPlaceholder {
			enabled: !signedIn
			text: "Not Signed In"
			hintText: "Flick down to access pulley menu"
		}

		Column {
			anchors.fill: parent

			y: Theme.paddingLarge

			Label {
				text: "Signed in as:"
				anchors.horizontalCenter: parent.horizontalCenter
				color: Theme.secondaryHighlightColor
			}
			Label {
				id: nameLabel
				anchors.horizontalCenter: parent.horizontalCenter
				font.pixelSize: Theme.fontSizeLarge
				color: Theme.highlightColor
			}
		}
	}
 }

