import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
	id: page
	anchors.fill: parent

	// TODO: about page

	Column {
		id: column
		width: page.width
		spacing: Theme.paddingLarge
		PageHeader {
			title: qsTr("VK notification daemon")
		}
		Label {
			x: Theme.paddingLarge
			text: qsTr("Login to VK")
			color: Theme.secondaryHighlightColor
			font.pixelSize: Theme.fontSizeExtraLarge
		}
	}
}

