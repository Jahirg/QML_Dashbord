import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import "../controls"


import QtGraphicalEffects 1.15

Item {
	//property string bgcolor : "#21be2b"
	property int din0status: 0
	property int din1status: 0
	property int din2status: 0
	property int din3status: 0
	property int din4status: 0
	property int din5status: 0
	property int din6status: 0
	property int din7status: 0
	
	//############ INI : Main Rectangle page ###########################
	Rectangle {
		id: rectangle
		color: "#2c313c"
		anchors.fill: parent

	//############ INI : Rectangle Container for Inputs ###################
	Rectangle
	{
		id: rectInputs
		width: 700
		height: 480
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.top: parent.top
		anchors.topMargin: 10
		color: "transparent"
		border.color: "gray"
		border.width: 2
		radius: 10

		//######## Space Title INPUT PAGE  #############################
		Text
		{
		   text: qsTr("INPUT PAGE")
		   anchors.horizontalCenter: parent.horizontalCenter
		   anchors.top: parent.top
		   anchors.topMargin: 10
		   color: "#00a5ff"
		   font.pointSize: 16
		   font.bold : true
		}
		Text {
			color: "#ffa500"
			font.pointSize: 12
			text: "Change SVG image"
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 65
			width: 150
			height: 100
			
		}
		
		Rectangle {
			id : rectdin0
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 30
			width: 200
			height: 200
			color: "#00000000"
			
			Text {
				text: qsTr("DIN 0")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			AnimatedImage {
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				smooth  : true
				width: 50
				height:50
				//source: "../../images/png_images/circle_green_1.svg"
				source: din0status == 1 ? "../../images/png_images/circle_green_1.svg" : "../../images/png_images/circle_black.svg"
			}
			
		}
		
		Rectangle {
			id : rectdin1
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 100
			width: 200
			height: 200
			color: "#00000000"
			
			Text {
				text: qsTr("DIN 1")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			AnimatedImage {
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				smooth  : true
				width: 50
				height:50
				source: din1status == 1 ? "../../images/png_images/circle_red_1.svg" : "../../images/png_images/circle_black.svg"
				
			}
			
		}
		Text {
			color: "#ffa500"
			font.pointSize: 12
			text: "Repaint color SVG image"
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 260
			width: 150
			height: 100
			
		}
		Rectangle {
			id : rectdin2
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 220
			width: 200
			height: 200
			color: "#00000000"
			//property color activeMenuColorRight: "#55aaff"
			Text {
				text: qsTr("DIN 2")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Image {
				id: iconBtnDIN2
				source: "../../images/png_images/engine coolant.svg"
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				smooth  : true
				width: 50
				height:50
			}
			ColorOverlay{
				anchors.fill: iconBtnDIN2
				source: iconBtnDIN2
				color: din2status == 1 ? "#ffff00" : "#202020"
				anchors.verticalCenter: parent.verticalCenter
				antialiasing: true
				width: 50
				height: 50
			}
		}
		
		Rectangle {
			id : rectdin3
			anchors.left: parent.left
			anchors.leftMargin: 60
			anchors.top: parent.top
			anchors.topMargin: 280
			width: 200
			height: 200
			color: "#00000000"
			visible : true
			Text {
				text: qsTr("DIN 3")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Image {
				id: iconBtnDIN3
				source: "../../images/png_images/oil.svg"
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				smooth  : true
				width: 50
				height:50
			}
			ColorOverlay{
				anchors.fill: iconBtnDIN3
				source: iconBtnDIN3
				color: din3status == 1 ? "#ff0000" : "#202020"
				anchors.verticalCenter: parent.verticalCenter
				antialiasing: true
				width: 50
				height: 50
			}
		}
		
		Text {
			color: "#ffa500"
			font.pointSize: 12
			text: "Blinked icon & text"
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 65
			width: 150
			height: 100
			
		}
		Rectangle {
			id : rectdin4
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 30
			width: 200
			height: 200
			color: "#00000000"
			visible : true
			Text {
				text: qsTr("DIN 4")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Rectangle {
				id : rect
				anchors.fill: parent
				visible : din4status ==1 ? true : false
				color: "#00000000"
				Image {
					id: imagedin4
					anchors.verticalCenter : parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 80
					smooth  : true
					width: 50
					height:50
					source: "../../images/png_images/seat_belt.svg"
				}
				Timer {
					id: timerdin6
					running : true
					interval: 1000
					repeat: true
					onTriggered : imagedin4.visible = !imagedin4.visible
				}
			}
		}
		
		Rectangle {
			id : rectain6
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 100
			width: 200
			height: 200
			color: "#00000000"
			visible : true
			Text {
				text: qsTr("DIN 5")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Timer {
				id: timerain6
				running :din5status ==1 ? true : false
				interval: 1000
				repeat: true
				onTriggered : textain6.visible = !textain6.visible
			}
			Text {
				id: textain6
				text: qsTr("OVER SPEED")
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				color: din5status ==1 ? "#FF0000" : "#00000000"
				font.pointSize: 16
				font.bold : true
				
			}
			
		}
		Text {
			color: "#ffa500"
			font.pointSize: 12
			text: "Change  text & color"
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 260
			width: 150
			height: 100
			
		}
		Rectangle {
			id : rectain7
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 220
			width: 200
			height: 200
			color: "#00000000"
			visible : true
			Text {
				text: qsTr("DIN 6")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Text {
				id: textain7
				text: din6status ==1 ? "OPEN" : "CLOSE"
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				color: din6status ==1 ? "#E0E0E0" : "#91CF14"
				font.pointSize: 16
				font.bold : true
			}
			
		}
		
		Rectangle {
			id : rectain8
			anchors.left: parent.left
			anchors.leftMargin: 380
			anchors.top: parent.top
			anchors.topMargin: 290
			width: 200
			height: 200
			color: "#00000000"
			visible : true
			Text {
				text: qsTr("DIN 7")
				anchors.verticalCenter : parent.verticalCenter
				color: "#00a5ff"
				font.pointSize: 16
				font.bold : true
			}
			Text {
				id: textain8
				text: din7status ==1 ? "UP" : "DOWN"
				anchors.verticalCenter : parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 80
				color: din7status ==1 ? "#E0E0E0" : "#FFA500"
				font.pointSize: 16
				font.bold : true
			}
			
		}
	}
	//######## END : Rectangle Container for PWM ########################
	} 
	//############ END : Main Rectangle page ###########################
	//
	Timer{
		id:tmains
		interval: 250
		repeat: true
		running: true
		onTriggered: {
			din0status = backend.get_din0()
			din1status = backend.get_din1()
			din2status = backend.get_din2()
			din3status = backend.get_din3()
			din4status = backend.get_din4()
			din5status = backend.get_din5()
			din6status = backend.get_din6()
			din7status = backend.get_din7()
		}
	}

	//######## INI Space for connections ###############################
	Connections{
        target: backend
	}
	//######## END : Space for connections##############################
}

