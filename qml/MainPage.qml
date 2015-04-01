import QtQuick 2.0
import QtFeedback 5.0
import Sailfish.Silica 1.0
import harbour.vknotificationdaemon.notifications 1.0

import "js/storage.js" as Storage
import "js/api.js" as Api

Page {
	id: mainPage

	allowedOrientations: Orientation.All

	property bool signedIn: false
	property string access_token_pty: ""
	property bool userInfoGettingFinished: false

	function getNameAndAvatar()
	{
		var user_id = Storage.select("user_id");
		Api.makeRequest("users.get", access_token_pty, { user_id: user_id, fields: 'photo_100' },
		function(response) {
			nameLabel.text = response[0].first_name + " " + response[0].last_name;
			avatarImage.source = response[0].photo_100;
			userInfoGettingFinished = true;
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
			pollForUnreadMessages();
		}
	}

	function logOut()
	{
		Storage.clearDB();
		Storage.constructDB();
		signedIn = false;
	}

	function pollForUnreadMessages()
	{
		console.log("Getting unread messages...");
		numberOfUnreadLabel.text = "";
		weirdUnreadSpacer.text = "";
		unreadLabel.text = "Loading unread messages...";
		Api.makeRequest("messages.getDialogs", access_token_pty, { count: 0, unread: 1 },
		function(response) {
			var unread = response.count;
			if (unread === 0) {
				numberOfUnreadLabel.text = "";
				weirdUnreadSpacer.text = "";
				unreadLabel.text = "No new messages"
			} else {
				notification.itemCount = Number(unread);
				weirdUnreadSpacer.text = " ";
				if (unread === 1) {
					numberOfUnreadLabel.text = 1;
					unreadLabel.text = "unread message"

					notification.previewBody = "1 unread message";
					notification.summary = "1 unread message";
					notification.body = "From Todo McTodoish";
				} else {
					numberOfUnreadLabel.text = unread;
					unreadLabel.text = "unread messages"

					notification.previewBody = unread + " unread messages";
					notification.summary = unread + " unread messages";
					notification.body = "From Todo McTodoish, Todoisa Todoisovna";
				}
				notification.publish();
			}
		});
	}

	onStatusChanged: {
		if (status === PageStatus.Active) {
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
				onClicked: logOut();
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
				id: signedInAsLabel
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
					top: signedInAsLabel.bottom
					topMargin: Theme.paddingMedium
				}

				Rectangle {
					anchors.fill: parent
					color: Theme.highlightColor
					opacity: 0.2
					z: -1
				}

				Image {
					id: avatarImage
					width: 100
					height: 100
					anchors {
						left: parent.left
						leftMargin: Theme.paddingMedium
						verticalCenter: parent.verticalCenter
					}
					source: ""
					visible: userInfoGettingFinished
				}

				BusyIndicator {
					width: 100
					height: 100
					anchors {
						left: parent.left
						leftMargin: Theme.paddingMedium
						verticalCenter: parent.verticalCenter
					}
					visible: !userInfoGettingFinished
					running: true
					size: BusyIndicatorSize.Large
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
				width: numberOfUnreadLabel.width +
					weirdUnreadSpacer.width + unreadLabel.width
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
				id: manualCheckButton
				text: "Manually check for unread messages"
				anchors {
					top: unreadLabelsRow.bottom
					topMargin: Theme.paddingLarge
					horizontalCenter: parent.horizontalCenter
				}
				onReleased: pollForUnreadMessages()
			}

			Notification {
				id: notification
				category: "x-vk-notification-daemon.newmessage"
				appName: "vk notification daemon"
				appIcon: "image://theme/icon-s-sms"
				summary: "New messages"
				body: ""
				previewSummary: "vk notification daemon"
				previewBody: ""
				itemCount: 1
				timestamp: "2013-02-20 18:21:00"
			}

			Timer {
				interval: 1 * 1000 * 60
				repeat: true
				running: true
				onTriggered: pollForUnreadMessages()
			}
		}
	}
}

