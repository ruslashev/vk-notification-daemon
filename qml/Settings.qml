import QtQuick 2.0
import QtFeedback 5.0
import Sailfish.Silica 1.0

Page {
	id: settingsPage

	allowedOrientations: Orientation.All

	SilicaFlickable {
		anchors.fill: parent

		PageHeader {
			title: "Settings"
		}

		ComboBox {
			id: vibrationCombo
			label: "Vibration:"
			currentIndex: 1
			menu: ContextMenu {
				MenuItem {
					text: "Off"
					intensity: 0
					duration: 0
				}
				MenuItem {
					text: "Short"
					intensity: 4
					duration: 400
				}
				MenuItem {
					text: "Long"
					intensity: 6
					duration: 1000
				}
				MenuItem {
					text: "Custom"
					intensity: intensitySlider.value
					duration: durationSlider.value
				}
			}
			onCurrentIndexChanged: customVibrationColumn.visible = (currentIndex === 3)
		}

		Column {
			id: customVibrationColumn
			visible: false
			width: parent.width
			spacing: Theme.paddingSmall
			Slider {
				id: intensitySlider
				width: mainPage.width
				value: 5
				valueText: value
				minimumValue: 0.5
				maximumValue: 10
				label: "Intensity"
			}
			Slider {
				id: durationSlider
				width: mainPage.width
				value: 400
				valueText: Math.round(value)
				minimumValue: 100
				maximumValue: 1000
				label: "Duration"
			}
		}

		Button {
			text: "Test notification"
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.topMargin: Theme.paddingLarge
			onReleased: notification()
		}
	}

	HapticsEffect {
		id: vibrationEffect
		intensity: vibrationCombo.currentItem.intensity / 10
		duration: vibrationCombo.currentItem.duration
	}

	function notification()
	{
		vibrationEffect.start();
	}
}

