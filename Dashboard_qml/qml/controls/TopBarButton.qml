import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
	id: btnTopBar
	// CUSTOM PROPERTIES
	property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
	property color btnColorDefault: "#1c1d20"
	property color btnColorMouseOver: "#23f72E"
	property color btnColorClicked: "#00a1f1"

	QtObject{
		id: internal
		// MOUSE OVER AND CLICK CHANGE COLOR
		property var dynamicColor: 
		if(btnTopBar.down){
			   btnTopBar.down ? btnColorClicked : btnColorDefault
		   } else {
			   btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
		   }
	}

	width: 35
	height: 35

	background: Rectangle{
		id: bgBtn
		color: internal.dynamicColor
		radius: 5
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.bottom: parent.bottom

		anchors.leftMargin: 4
		anchors.rightMargin: 4
		anchors.topMargin: 4
		anchors.bottomMargin: 4


		Image {
			id: iconBtn
			source: btnIconSource
			anchors.verticalCenter: parent.verticalCenter
			anchors.horizontalCenter: parent.horizontalCenter
			height: 24
			width: 24
			visible: false
			fillMode: Image.PreserveAspectFit
			antialiasing: false
		}

		ColorOverlay{
			anchors.fill: iconBtn
			source: iconBtn
			color: "#000000"
			antialiasing: false
		}
	}
}


