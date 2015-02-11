import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
	anchors.fill: parent
	Column {
		anchors.centerIn: parent
		Label {
			id: name
			text: qsTr("VK notification\ndaemon")
			color: Theme.secondaryHighlightColor
			anchors.horizontalCenter: parent.horizontalCenter
		}
		Label {
			id: status
			text: qsTr("Not logged in")
			color: Theme.primaryColor
			anchors.horizontalCenter: parent.horizontalCenter
		}
	}
}

