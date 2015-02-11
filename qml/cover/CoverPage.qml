import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	anchors.fill: parent
	Column {
		anchors.centerIn: parent
		Label {
			id: appName
			text: qsTr("VK daemon")
			color: Theme.secondaryHighlightColor
			anchors.horizontalCenter: parent.horizontalCenter
		}
		Label {
			id: signInStatus
			text: qsTr("Not signed in")
			color: Theme.primaryColor
			anchors.horizontalCenter: parent.horizontalCenter
		}
	}
}

