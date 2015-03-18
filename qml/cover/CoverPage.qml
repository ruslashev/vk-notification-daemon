import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	id: background
	anchors.fill: parent
	anchors.margins: Theme.paddingLarge
	Column {
		anchors.centerIn: parent
		Label {
			id: appName
			width: background.width
			wrapMode: TextEdit.WordWrap
			anchors.horizontalCenter: parent.horizontalCenter
			color: Theme.secondaryHighlightColor

			font.pixelSize: Theme.fontSizeSmall
			text: "VK notification daemon"
		}
		Label {
			id: signInStatus
			width: background.width
			wrapMode: TextEdit.WordWrap
			anchors.horizontalCenter: parent.horizontalCenter
			color: Theme.primaryColor

			text: "Not signed in blalb lba lab lab abl "
		}
	}
}

