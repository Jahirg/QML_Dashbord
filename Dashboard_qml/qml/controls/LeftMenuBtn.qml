import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
	id: btnLeftMenu
	text: qsTr("Left Menu Text")

	// CUSTOM PROPERTIES
	property url btnIconSource: "../../images/svg_images/home_icon.svg"
	property color btnColorDefault: "#1c1d20"
	property color btnColorMouseOver: "#005280"
	property color btnColorClicked: "#00a1f1"
	property int iconWidth: 32
	property int iconHeight: 32
	property color activeMenuColor: "#1c1d20"
	property color activeMenuColorRight: "#55aaff"
	property bool isActiveMenu: false
	
	property color imgColorActived: "#23272E"
	property color imgColorDefault: "#00a1f1"
	implicitWidth: 250
	implicitHeight: 60
//////////////////
//	QtObject{
//		id: internalImg
//		// ICON COLOR ACTIVE
//		property var dynamicColorImg: 
//		if(btnLeftMenu.down){
//				btnLeftMenu.down ? btnColorClicked : btnColorDefault   
//			} else {
//				btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
//			}
//		}
/////////////////////

	QtObject{
		id: internal
		// MOUSE OVER AND CLICK CHANGE COLOR
		property var dynamicColor: 
		if(btnLeftMenu.down){
				btnLeftMenu.down ? btnColorClicked : btnColorDefault   
			} else {
				btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
			}
		}


	background: Rectangle{
		id: bgBtn
		color: internal.dynamicColor
		Rectangle{
			anchors{
				top: parent.top
				left: parent.left
				bottom: parent.bottom
			}
			color: activeMenuColor
			width: 5
			visible: isActiveMenu
		}

		Rectangle{
			anchors{
				top: parent.top
				right: parent.right
				bottom: parent.bottom
			}
			color: activeMenuColorRight
			width: 5
			visible: isActiveMenu
		}

	}

	contentItem: Item{
		anchors.fill: parent
		id: content
		Image {
			id: iconBtn
			source: btnIconSource
			anchors.leftMargin: 15
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			sourceSize.width: iconWidth
			sourceSize.height: iconHeight
			width: iconWidth
			height: iconHeight
			fillMode: Image.PreserveAspectFit
			visible: false
			antialiasing: true
		}

		ColorOverlay{
			anchors.fill: iconBtn
			source: iconBtn
			color: if(isActiveMenu){activeMenuColorRight } else {"#909090"}
			anchors.verticalCenter: parent.verticalCenter
			antialiasing: true
			width: iconWidth
			height: iconHeight
		}

		Text{
			color: "#ffffff"
			text: btnLeftMenu.text
			font: btnLeftMenu.font
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 75
		}
	}
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:250}
}
##^##*/
