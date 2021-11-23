import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import "../controls"


Item {
    Rectangle {
        id: rectangle
        color: "#2c313c"
        anchors.fill: parent

	//##################################################################

	Label {
		id: labelLs1
		color: "#d0d0d0"
        text: qsTr("PIN 22")
		anchors.left: parent.left
		anchors.leftMargin: 50
		anchors.top: parent.top
        anchors.topMargin: 65
		height: 30
		width: 50
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
		font.pointSize: 14
		}
	
	CustomSwitch{
		id: ledSwitch1
		anchors.left: parent.left
		anchors.leftMargin: 120
		anchors.top: parent.top
        anchors.topMargin: 60
		backgroundHeight: 30
		backgroundWidth: 100
		onSwitched:{
			if(on == true)
				backend.setPinoutput(22,'H');
			else
				backend.setPinoutput(22,'L');
			}
		}
	
	Label {
		id: labelLs2
		color: "#d0d0d0"
		text: qsTr(" PIN 23")
		anchors.left: parent.left
		anchors.leftMargin: 50
		anchors.top: parent.top
        anchors.topMargin: 135
		height: 30
		width: 50
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
		font.pointSize: 14
		}
	CustomSwitch{
		id: ledSwitch2
		anchors.left: parent.left
		anchors.leftMargin: 120
		anchors.top: parent.top
        anchors.topMargin: 130
		backgroundHeight: 30
		backgroundWidth: 100
		colorbg: "#F7A424" // "#39F724"
		onSwitched:{
			if(on == true)
				backend.setPinoutput(23,'H');
			else
				backend.setPinoutput(23,'L');
			}
		}
	
	Label {
		id: labelLs3
		color: "#d0d0d0"
		text: qsTr(" PIN 24")
		anchors.left: parent.left
		anchors.leftMargin: 50
		anchors.top: parent.top
        anchors.topMargin: 205
		height: 30
		width: 50
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
		font.pointSize: 14
		}
	CustomSwitch{
		id: ledSwitch3
		anchors.left: parent.left
		anchors.leftMargin: 120
		anchors.top: parent.top
        anchors.topMargin: 200
		backgroundHeight: 30
		backgroundWidth: 100
		colorbg: "#f73924" 
		onSwitched:{
			if(on == true)
				backend.setPinoutput(24,'H');
			else
				backend.setPinoutput(24,'L');
			}
		}
	
	Label {
		id: labelLs4
		color: "#d0d0d0"
		text: qsTr(" PIN 25")
		anchors.left: parent.left
		anchors.leftMargin: 50
		anchors.top: parent.top
        anchors.topMargin: 275
		height: 30
		width: 50
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
		font.pointSize: 14
		}
	CustomSwitch{
		id: ledSwitch4
		anchors.left: parent.left
		anchors.leftMargin: 120
		anchors.top: parent.top
        anchors.topMargin: 270
		backgroundHeight: 30
		backgroundWidth: 100
		colorbg: "#00A5FF" // "#39F724"
		onSwitched:{
			if(on == true)
				backend.setPinoutput(25,'H');
			else
				backend.setPinoutput(25,'L');
			}
		}
		
	//##################################################################

	SwitchDelegate {
		id: ledSwitch5
		text: qsTr("PIN 26")
		anchors.left: parent.left
		checked: false
		font.pointSize: 14
		height: 25
		anchors.top: parent.top
		anchors.leftMargin: 330
        anchors.topMargin: 67
		onCheckedChanged:{
			if (checked){
				backend.setPinoutput(26,'H');
			}else {
				backend.setPinoutput(26,'L');
			}
		}
		contentItem: Text {
			rightPadding: ledSwitch5.indicator.width + ledSwitch5.spacing
			text: ledSwitch5.text
			font: ledSwitch5.font
			opacity: enabled ? 1.0 : 0.3
			color: ledSwitch5.down ? "#39F724" : "#d0d0d0"
			elide: Text.ElideRight
			verticalAlignment: Text.AlignVCenter
		}

		indicator: Rectangle {
			implicitWidth: 58
			implicitHeight: 26
			x: ledSwitch5.width - width - ledSwitch5.rightPadding
			y: parent.height / 2 - height / 2
			radius: 13
			color: ledSwitch5.checked ? "#39F724" : "transparent"
			border.color: ledSwitch5.checked ? "#39F724" : "#cccccc"

			Rectangle {
				x: ledSwitch5.checked ? parent.width - width : 0
				width: 26
				height: 26
				radius: 13
				color: ledSwitch5.down ? "#c0c0c0" : "#f0f0f0"
			}
		}
		background: Rectangle {
			implicitWidth: 80
			implicitHeight: 40
			visible: ledSwitch5.down || ledSwitch5.highlighted
			color: "#00000000"
		}
	}

	SwitchDelegate {
		id: ledSwitch6
		text: qsTr("PIN 27")
		anchors.left: parent.left
		checked: false
		font.pointSize: 14
		height: 25
		anchors.top: parent.top
		anchors.leftMargin: 330
        anchors.topMargin: 137
		onCheckedChanged:{
			if (checked){
				backend.setPinoutput(27,'H');
			}else {
				backend.setPinoutput(27,'L');
			}
		}
		contentItem: Text {
			rightPadding: ledSwitch6.indicator.width + ledSwitch6.spacing
			text: ledSwitch6.text
			font: ledSwitch6.font
			opacity: enabled ? 1.0 : 0.3
			color: ledSwitch6.down ? "#F7A424" : "#d0d0d0"
			elide: Text.ElideRight
			verticalAlignment: Text.AlignVCenter
		}

		indicator: Rectangle {
			implicitWidth: 58
			implicitHeight: 26
			x: ledSwitch6.width - width - ledSwitch6.rightPadding
			y: parent.height / 2 - height / 2
			radius: 13
			color: ledSwitch6.checked ? "#F7A424" : "transparent"
			border.color: ledSwitch6.checked ? "#F7A424" : "#cccccc"

			Rectangle {
				x: ledSwitch6.checked ? parent.width - width : 0
				width: 26
				height: 26
				radius: 13
				color: ledSwitch6.down ? "#c0c0c0" : "#f0f0f0"
			}
		}
		background: Rectangle {
			implicitWidth: 80
			implicitHeight: 40
			visible: ledSwitch6.down || ledSwitch6.highlighted
			color: "#00000000"
		}
	}
	
	SwitchDelegate {
		id: ledSwitch7
        text: qsTr("")
		anchors.left: parent.left
		checked: false
		font.pointSize: 14
		height: 25
        rotation: -90
		anchors.top: parent.top
		anchors.leftMargin: 330
        anchors.topMargin: 257
		onCheckedChanged:{
			if (checked){
				backend.setPinoutput(28,'H');
			}else {
				backend.setPinoutput(28,'L');
			}
		}
		contentItem: Text {
			rightPadding: ledSwitch7.indicator.width + ledSwitch7.spacing
			text: ledSwitch7.text
			font: ledSwitch7.font
			opacity: enabled ? 1.0 : 0.3
			color: ledSwitch7.down ? "#f73924" : "#d0d0d0"
			elide: Text.ElideRight
			verticalAlignment: Text.AlignVCenter
		}

		indicator: Rectangle {
			implicitWidth: 58
			implicitHeight: 26
			x: ledSwitch7.width - width - ledSwitch7.rightPadding
			y: parent.height / 2 - height / 2
			radius: 13
			color: ledSwitch7.checked ? "#f73924" : "transparent"
			border.color: ledSwitch7.checked ? "#f73924" : "#cccccc"

			Rectangle {
				x: ledSwitch7.checked ? parent.width - width : 0
				width: 26
				height: 26
				radius: 13
				color: ledSwitch7.down ? "#c0c0c0" : "#f0f0f0"
			}
		}
		background: Rectangle {
			implicitWidth: 80
			implicitHeight: 40
			visible: ledSwitch7.down || ledSwitch7.highlighted
			color: "#00000000"
		}
	}
    Label {
        id: labelLs7
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 350
        anchors.topMargin: 200
        width: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 14
        text: qsTr("PIN 28")
        color:"#C0C0C0"
    }

	SwitchDelegate {
		id: ledSwitch8
        text: qsTr("")
		anchors.left: parent.left
		checked: false
		font.pointSize: 14
		height: 25
        rotation : -90
		anchors.top: parent.top
        anchors.leftMargin: 400
        anchors.topMargin: 257
		onCheckedChanged:{
			if (checked){
				backend.setPinoutput(29,'H');
			}else {
				backend.setPinoutput(29,'L');
			}
		}
		contentItem: Text {
			rightPadding: ledSwitch8.indicator.width + ledSwitch8.spacing
			text: ledSwitch8.text
			font: ledSwitch8.font
            rotation : 90
			opacity: enabled ? 1.0 : 0.3
			color: ledSwitch8.down ? "#00aeff" : "#d0d0d0"
			elide: Text.ElideRight
			verticalAlignment: Text.AlignVCenter
		}

		indicator: Rectangle {
			implicitWidth: 58
			implicitHeight: 26
			x: ledSwitch8.width - width - ledSwitch8.rightPadding
			y: parent.height / 2 - height / 2
			radius: 13
			color: ledSwitch8.checked ? "#00aeff" : "transparent"
			border.color: ledSwitch8.checked ? "#00aeff" : "#cccccc"

			Rectangle {
				x: ledSwitch8.checked ? parent.width - width : 0
				width: 26
				height: 26
				radius: 13
				color: ledSwitch8.down ? "#c0c0c0" : "#f0f0f0"
			}
		}
		background: Rectangle {
			implicitWidth: 80
			implicitHeight: 40
			visible: ledSwitch8.down || ledSwitch8.highlighted
            color: "#00000000"
        }
    }
    Label {
        id: labelLs8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 420
        anchors.topMargin: 200
        width: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 14
        text: qsTr("PIN 29")
        color:"#C0C0C0"
    }

 Label {
     id: label1
     anchors.left: parent.left
     anchors.top: parent.top
     anchors.leftMargin: 30
     anchors.topMargin: 20
     width: 200
     verticalAlignment: Text.AlignVCenter
     horizontalAlignment: Text.AlignHCenter
     font.pointSize: 14
     text: qsTr("Animated SW")
     color:"#00a5ff"
 }
 Label {
     id: label2
     anchors.left: parent.left
     anchors.top: parent.top
     anchors.leftMargin: 300
     anchors.topMargin: 20
     width: 200
     verticalAlignment: Text.AlignVCenter
     horizontalAlignment: Text.AlignHCenter
     font.pointSize: 14
     text: qsTr("Delegate SW")
     color:"#00a5ff"
 }

	
	//##################################################################

    }
	Connections{
        target: backend 
	}
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
