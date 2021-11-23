import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
	id: btnToggle
	hoverEnabled: true
	
	// CUSTOM PROPERTIES
	property url btnIconSource: "../../images/svg_images/menu_icon.svg"
	property color btnColorDefault: "#1c1d20"
	property color btnColorMouseOver: "#23272E"
	property color btnColorClicked: "#0080b0"

	QtObject{
		id: internal
		// MOUSE OVER AND CLICK CHANGE COLOR
		property var dynamicColor: if(btnToggle.down){
			btnToggle.down ? btnColorClicked : btnColorDefault
		} else {
		   btnToggle.hovered ? btnColorMouseOver : btnColorDefault
		}
	}

	implicitWidth: 60
	implicitHeight: 60

	background: Rectangle{
		id: bgBtn
		color: internal.dynamicColor
		radius: 10
		Image {
			id: iconBtn
			source: btnIconSource
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
			height: 25
			width: 25
			fillMode: Image.PreserveAspectFit
			visible: false
		}
		ColorOverlay{
			anchors.fill: iconBtn
			source: iconBtn
			color: "#e0e0e0"
			antialiasing: false
		}
	}
}
