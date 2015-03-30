import QtQuick 2.0
import QtFeedback 5.0
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
		Api.makeRequest("users.get", access_token_pty, { user_id: user_id, fields: 'photo_100' },
		function(data) {
			console.log("data[0].first_name: " + data[0].first_name);
			console.log("data[0].last_name: " + data[0].last_name);
			console.log("data[0].photo_100: " + data[0].photo_100);
			nameLabel.text = data[0].first_name + " " + data[0].last_name;
			avatarImage.source = data[0].photo_100;
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
			MenuItem {
				text: "Settings"
				onClicked: pageStack.push(Qt.resolvedUrl("Settings.qml"))
			}
		}

		ViewPlaceholder {
			enabled: !signedIn
			text: "Not Signed In"
			hintText: "Flick down to access pulley menu"
		}

		Item {
			anchors.fill: parent
			visible: signedIn

			Label {
				id: signedInAsTextLabel
				text: "Signed in as:"
				anchors {
					top: parent.top
					topMargin: Theme.paddingLarge
					horizontalCenter: parent.horizontalCenter
				}
				color: Theme.secondaryHighlightColor
			}

			Item {
				id: signedInAsContainer
				width: parent.width
				height: avatarImage.height + Theme.paddingMedium*2
				anchors {
					top: signedInAsTextLabel.bottom
					topMargin: Theme.paddingMedium
				}

				Rectangle {
					anchors.fill: parent
					color: Theme.highlightColor
					opacity: 0.3
					z: -1
				}

				Image {
					id: avatarImage
					anchors {
						left: parent.left
						leftMargin: Theme.paddingMedium
						verticalCenter: parent.verticalCenter
					}
					source: "image://theme/nemomobile-busyindicator"
					fillMode: Image.PreserveAspectFit
					width: 100
					height: 100
				}

				Label {
					id: nameLabel
					anchors {
						left: avatarImage.right
						leftMargin: Theme.paddingMedium
						verticalCenter: parent.verticalCenter
					}
					text: "Loading..."
					font.pixelSize: Theme.fontSizeLarge
					color: Theme.highlightColor
				}
			}

			Row {
				id: unreadLabelsRow
				width: numberOfUnreadLabel.width + unreadLabel.width
				anchors {
					top: signedInAsContainer.bottom
					topMargin: Theme.paddingLarge
					horizontalCenter: parent.horizontalCenter
				}

				Label {
					id: numberOfUnreadLabel
					text: ""
					font.pixelSize: Theme.fontSizeLarge
					color: Theme.highlightColor
				}
				Label {
					id: weirdUnreadSpacer
					text: ""
					font.pixelSize: Theme.fontSizeLarge
				}
				Label {
					id: unreadLabel
					text: "No information about unread messages"
					font.pixelSize: Theme.fontSizeLarge
				}
			}

			Button {
				text: "Manually check for unread messages"
				anchors {
					top: unreadLabelsRow.bottom
					topMargin: Theme.paddingLarge
					horizontalCenter: parent.horizontalCenter
				}
				onReleased: pollForUnreadMessages()
			}

			Timer {
				interval: 3 * 60 * 1000
				repeat: true
				running: true
				triggeredOnStart: true
				onTriggered: pollForUnreadMessages()
			}
		}
	}

	function pollForUnreadMessages()
	{
		unreadLabel.text = "Loading unread messages...";
		console.log("Getting unread messages...");
		Api.makeRequest("messages.getDialogs", access_token_pty, { count: 0, unread: 1 },
		function(data) {
			var unread = data.count;
			console.log("data.count: " + unread);

			if (unread === 0) {
				numberOfUnreadLabel.text = "";
				weirdUnreadSpacer.text = "";
				unreadLabel.text = "No new messages"
			} else if (unread === 1) {
				numberOfUnreadLabel.text = unread;
				weirdUnreadSpacer.text = " ";
				unreadLabel.text = "unread message"
			} else {
				numberOfUnreadLabel.text = unread;
				weirdUnreadSpacer.text = " ";
				unreadLabel.text = "unread messages"
			}
		});
	}
}

