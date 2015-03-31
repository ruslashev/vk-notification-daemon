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
			anchors.horizontalCenter: parent.horizontalCenter
			horizontalAlignment: Text.AlignHCenter
			color: Theme.primaryColor

			font.pixelSize: Theme.fontSizeSmall
			wrapMode: TextEdit.WordWrap
			text: "VK notification daemon"
		}
		Label {
			id: signInStatus
			width: background.width
			anchors.horizontalCenter: parent.horizontalCenter
			horizontalAlignment: Text.AlignHCenter
			color: Theme.secondaryHighlightColor

			wrapMode: TextEdit.WordWrap
			text: "if only I knew how to get who's logged in now, ye"
		}
	}
}

