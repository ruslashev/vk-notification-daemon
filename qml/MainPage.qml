import QtQuick 2.0
import Sailfish.Silica 1.0

import "js/storage.js" as Storage

Page {
	id: mainPage

	allowedOrientations: Orientation.All

	property bool signedIn: false

	function checkIfSignedIn()
	{
		Storage.constructDB();

		var access_token = Storage.select("access_token");

		console.log("Checking for access_token: " + access_token);

		if (access_token === -1) {
			pageStack.push(Qt.resolvedUrl("SignIn.qml"))
		} else {
			signedIn = true;
		}
	}

	onStatusChanged: {
		if (status == PageStatus.Activating) {
			Storage.clearDB();
		}
		if (status == PageStatus.Active) {
			checkIfSignedIn();
		}
	}

	SilicaFlickable {
		anchors.fill: parent

		PageHeader {
			title: "vk notification daemon"
		}
	}
}

