import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import "../controls"

Item {
	//############ INI : Main Rectangle page ###########################
	Rectangle {
		id: rectangle
		color: "#2c313c"
		anchors.fill: parent

	//############ INI : Rectangle Container for PWM ###################
	Rectangle
	{
		id: rectPwm
		width: 450
		height: 320
		anchors.left: parent.left
		anchors.leftMargin: 40
		anchors.top: parent.top
		anchors.topMargin: 30
		color: "transparent"
		border.color: "gray"
		border.width: 2
		radius: 10

		//######## Space Title PWM  ####################################
		Text
		{
		   text: qsTr("PWM")
		   anchors.horizontalCenter: parent.horizontalCenter
		   anchors.top: parent.top
		   anchors.topMargin: 10
		   color: "#00a5ff"
		   font.pointSize: 16
		   font.bold : true
		}

		//######## Space PWM RED #######################################
		Text
		{
		   text: qsTr("P04")
		   anchors.right: sldRed.left
		   anchors.rightMargin: 15
		   anchors.verticalCenter: sldRed.verticalCenter
		   color: "red"
		   font.pointSize: 16
		   font.bold : true
		}

		CustomSlider
		{
		   id: sldRed
		   anchors.horizontalCenter: parent.horizontalCenter
		   anchors.top: parent.top
		   anchors.topMargin: 60
		   width: 300
		   minimum: 0
		   maximum: 255
		   value: 0
		   step: 1
		   backgroundEmpty: "#808080"
		   backgroundFull: "red"
		   pressCircle: "red"
		   onValueChanged:
		   {
			   backend.setPwm("P04", value);
		   }
		}
		Text
		{
		   text: sldRed.value
		   anchors.left: sldRed.right
		   anchors.leftMargin: 10
		   anchors.verticalCenter: sldRed.verticalCenter
		   color: "#d0d0d0"
		   font.pointSize: 16
		}

		//######## Space PWM GREEN #####################################
		Text
		{
		  text: qsTr("P05")
		  anchors.right: sldGreen.left
		  anchors.rightMargin: 15
		  anchors.verticalCenter: sldGreen.verticalCenter
		  color: "lightgreen"
		  font.pointSize: 16
		  font.bold : true
		  
		}

		CustomSlider
		{
		  id: sldGreen
		  anchors.horizontalCenter: parent.horizontalCenter
		  anchors.top: sldRed.bottom
		  anchors.topMargin: 60
		  width: 300
		  minimum: 0
		  maximum: 255
		  value: 0
		  step: 1
		  backgroundEmpty: "#808080"
		  onValueChanged:
		  {
			  backend.setPwm("P05", value);
		  }
		}

		Text
		{
		  text: sldGreen.value
		  anchors.left: sldGreen.right
		  anchors.leftMargin: 10
		  anchors.verticalCenter: sldGreen.verticalCenter
		  color: "#d0d0d0"
		  font.pointSize: 16
		}

		//######## Space PWM BLUE ######################################
		Text
		{
		  text: qsTr("P06")
		  anchors.right: sldBlue.left
		  anchors.rightMargin: 15
		  anchors.verticalCenter: sldBlue.verticalCenter
		  color: "#00A5FF"
		  font.pointSize: 16
		  font.bold : true
		}

		CustomSlider
		{
		  id: sldBlue
		  anchors.horizontalCenter: parent.horizontalCenter
		  anchors.top: sldGreen.bottom
		  anchors.topMargin: 60
		  width: 300
		  minimum: 0
		  maximum: 255
		  value: 0
		  step: 1
		  backgroundEmpty: "#808080"
		  backgroundFull: "#00A5FF"
		  pressCircle: "blue"
		  onValueChanged:
		  {
			  backend.setPwm("P06", value);
		  }
		}

		Text
		{
		  text: sldBlue.value
		  anchors.left: sldBlue.right
		  anchors.leftMargin: 10
		  anchors.verticalCenter: sldBlue.verticalCenter
		  color: "#d0d0d0"
		  font.pointSize: 16
		}

		//######## Space PWM ORANGE ####################################
		Text
		{
		  text: qsTr("P07")
		  anchors.right: sldOrange.left
		  anchors.rightMargin: 15
		  anchors.verticalCenter: sldOrange.verticalCenter
		  color: "#ffa500"
		  font.pointSize: 16
		  font.bold : true
		}

		CustomSlider
		{
		  id: sldOrange
		  anchors.horizontalCenter: parent.horizontalCenter
		  anchors.top: sldBlue.bottom
		  anchors.topMargin: 60
		  width: 300
		  minimum: 0
		  maximum: 255
		  value: 0
		  step: 1
		  backgroundEmpty: "#808080"
		  backgroundFull: "#ffa500"
		  pressCircle: "#ffa500"
		  onValueChanged:
		  {
			  backend.setPwm("P07", value);
		  }
		}

		Text
		{
		  text: sldOrange.value
		  anchors.left: sldOrange.right
		  anchors.leftMargin: 10
		  anchors.verticalCenter: sldOrange.verticalCenter
		  color: "#d0d0d0"
		  font.pointSize: 16
		}
	
	}
	//######## END : Rectangle Container for PWM ########################
	
	//==================================================================

	//############ INI : Rectangle Container for PWM VERTCAL ###########
	Rectangle{
		id: rectPwmV
		width: 350
		height: 320
		anchors.left: parent.left
		anchors.leftMargin: 500
		anchors.top: parent.top
		anchors.topMargin: 30
		color: "transparent"
		border.color: "gray"
		border.width: 2
		radius: 10

		//######## Space Title PWM VERTICAL ############################
		Text
		{
		   text: qsTr("PWM VERTICAL SLIDERS")
		   anchors.horizontalCenter: parent.horizontalCenter
		   anchors.top: parent.top
		   anchors.topMargin: 10
		   color: "#00a5ff"
		   font.pointSize: 16
		   font.bold : true
		}
		
		//######## Space PWM SLIDER 1  #################################
		Slider {
			id: slider1
			from:0
			to : 255
			value: 0
			rotation : -90

			anchors.left: parent.left
			anchors.leftMargin: -40
			anchors.top: parent.top
			anchors.topMargin: 160

			background: Rectangle {
				x: slider1.leftPadding
				y: slider1.topPadding + slider1.availableHeight / 2 - height / 2
				implicitWidth: 200
				implicitHeight: 4
				width: slider1.availableWidth
				height: implicitHeight
				radius: 2
				color: "#c0c0c0"

				Rectangle {
					width: slider1.visualPosition * parent.width
					height: parent.height
					color: "#21be2b"
					radius: 2
				}
			}

			handle: Rectangle {
				x: slider1.leftPadding + slider1.visualPosition * (slider1.availableWidth - width)
				y: slider1.topPadding + slider1.availableHeight / 2 - height / 2
				implicitWidth: 26
				implicitHeight: 26
				radius: 13
				color: slider1.pressed ? "#d0d0d0" : "#21be2b"
				border.color: "#21be2b"
			}
			onValueChanged:
				{
				backend.setPwm("P08", Math.round(value));
			}
			
		}
		Text{
			text: Math.round(slider1.value)
			x: slider1.x + slider1.width/2 -13/2
			y: slider1.y + slider1.width/2 +20
			anchors.horizontalCenter: slider1.horizontalCenter 
			color: "#d0d0d0"
			font.pointSize: 16
			}
		Text{
			text: qsTr("P08")
			font.pointSize: 16
			font.bold : true
			color: "#80ff80"
			x: slider1.x + slider1.width/2 -13/2
			y: slider1.y - slider1.width/2 - 20
			anchors.horizontalCenter: slider1.horizontalCenter 
			}
		
		//######## Space PWM SLIDER 2  #################################
		Slider {
			id: slider2
			from:0
			to : 255
			value: 0
			rotation : -90

			anchors.left: parent.left
			anchors.leftMargin: 40
			anchors.top: parent.top
			anchors.topMargin: 160

			background: Rectangle {
				x: slider2.leftPadding
				y: slider2.topPadding + slider2.availableHeight / 2 - height / 2
				implicitWidth: 200
				implicitHeight: 4
				width: slider2.availableWidth
				height: implicitHeight
				radius: 2
				color: "#c0c0c0"

				Rectangle {
					width: slider2.visualPosition * parent.width
					height: parent.height
					color: "red"
					radius: 2
				}
			}
			handle: Rectangle {
				x: slider2.leftPadding + slider2.visualPosition * (slider2.availableWidth - width)
				y: slider2.topPadding + slider2.availableHeight / 2 - height / 2
				implicitWidth: 26
				implicitHeight: 26
				radius: 13
				color: slider2.pressed ? "#d0d0d0" : "#ff0000"
				border.color: "#ff0000"
			}
			onValueChanged:
				{
				backend.setPwm("P09", Math.round(value));
			}
			
		}
		Text{
			text: Math.round(slider2.value)
			x: slider2.x + slider2.width/2 -13/2
			y: slider2.y + slider2.width/2 +20
			anchors.horizontalCenter: slider2.horizontalCenter 
			color: "#d0d0d0"
			font.pointSize: 16
			}
		Text{
			text: qsTr("P09")
			font.pointSize: 16
			font.bold : true
			color: "#ff0000"
			x: slider2.x + slider2.width/2 -13/2
			y: slider2.y - slider2.width/2 - 20
			anchors.horizontalCenter: slider2.horizontalCenter 
			}
		
		//######## Space PWM SLIDER 3  #################################
		Slider {
			id: slider3
			from:0
			to : 255
			value: 0
			rotation : -90

			anchors.left: parent.left
			anchors.leftMargin: 120
			anchors.top: parent.top
			anchors.topMargin: 160

			background: Rectangle {
				x: slider3.leftPadding
				y: slider3.topPadding + slider3.availableHeight / 2 - height / 2
				implicitWidth: 200
				implicitHeight: 4
				width: slider3.availableWidth
				height: implicitHeight
				radius: 2
				color: "#c0c0c0"

				Rectangle {
					width: slider3.visualPosition * parent.width
					height: parent.height
					color: "#00a5ff"
					radius: 2
				}
			}
			handle: Rectangle {
				x: slider3.leftPadding + slider3.visualPosition * (slider3.availableWidth - width)
				y: slider3.topPadding + slider3.availableHeight / 2 - height / 2
				implicitWidth: 26
				implicitHeight: 26
				radius: 13
				color: slider3.pressed ? "#d0d0d0" : "#00a5ff"
				border.color: "#00a5ff"
			}
			onValueChanged:
				{
				backend.setPwm("P10", Math.round(value));
			}
		}
		Text{
			text: Math.round(slider3.value)
			x: slider3.x + slider3.width/2 -13/2
			y: slider3.y + slider3.width/2 +20
			anchors.horizontalCenter: slider3.horizontalCenter 
			color: "#d0d0d0"
			font.pointSize: 16
		}
		Text{
			text: qsTr("P10")
			font.pointSize: 16
			font.bold : true
			color: "#00a5ff"
			x: slider3.x + slider3.width/2 -13/2
			y: slider3.y - slider3.width/2 - 20
			anchors.horizontalCenter: slider3.horizontalCenter 
		}
		
		//######## Space PWM SLIDER 4  #################################
		Slider {
			id: slider4
			from:0
			to : 255
			value: 0
			rotation : -90

			anchors.left: parent.left
			anchors.leftMargin: 200
			anchors.top: parent.top
			anchors.topMargin: 160

			background: Rectangle {
				x: slider4.leftPadding
				y: slider4.topPadding + slider4.availableHeight / 2 - height / 2
				implicitWidth: 200
				implicitHeight: 4
				width: slider4.availableWidth
				height: implicitHeight
				radius: 2
				color: "#c0c0c0"

				Rectangle {
					width: slider4.visualPosition * parent.width
					height: parent.height
					color: "#ffa500"
					radius: 2
				}
			}
			handle: Rectangle {
				x: slider4.leftPadding + slider4.visualPosition * (slider4.availableWidth - width)
				y: slider4.topPadding + slider4.availableHeight / 2 - height / 2
				implicitWidth: 26
				implicitHeight: 26
				radius: 13
				color: slider4.pressed ? "#d0d0d0" : "#ffa500"
				border.color: "#ffa500"
			}
			onValueChanged:
				{
				backend.setPwm("P11", Math.round(value));
			}
			
		}
		Text{
			text: Math.round(slider4.value)
			x: slider4.x + slider4.width/2 -13/2
			y: slider4.y + slider4.width/2 +20
			anchors.horizontalCenter: slider4.horizontalCenter 
			color: "#d0d0d0"
			font.pointSize: 16
		}
		Text{
			text: qsTr("P11")
			font.pointSize: 16
			font.bold : true
			color: "#ffa500"
			x: slider4.x + slider4.width/2 -13/2
			y: slider4.y - slider4.width/2 - 20
			anchors.horizontalCenter: slider4.horizontalCenter 
		}
	}
	//######## END : Rectangle Container for PWM  VERTICAL #############
	
	
	} //############ END : Main Rectangle page ###########################
	
	
	//######## INI Space for connections ###############################
	Connections{
        target: backend
	}
	//######## END : Space for connections##############################
}

