
import QtQuick 2.0

Item
{
    id: toggleswitch
    width: background.width;
    height: background.height

    signal released(bool value)
    signal switched(bool on)

    property bool on: false
    property bool toggleEnabled : true
    property color colorbg: "#39F724"

    property int backgroundWidth: 70
    property int backgroundHeight: 30

    function toggle()
    {
        if (toggleswitch.state == "on")
            toggleswitch.state = "off";
        else
            toggleswitch.state = "on";
        switched(toggleswitch.on);
    }

    function setStatus(value)
    {
        if (value === "on")
            toggleswitch.state = "on";
        else
            toggleswitch.state = "off";
    }

    function releaseSwitch()
    {
        if (knob.x == 1)
        {
            if (toggleswitch.state == "off")
            {
                toggleswitch.on = false;
                return;
            }
        }
        if (knob.x == 40)
        {
            if (toggleswitch.state == "on")
            {
                toggleswitch.on = true;
                return;
            }
        }
        toggle();
    }

    Rectangle
    {
        id: background
        width: backgroundWidth 
        height: backgroundHeight
        radius: height
        color: "#313E53"
        y : 5

        MouseArea
        {
            anchors.fill: parent;
            onClicked: toggle();
            enabled:toggleEnabled
        }
            Text {
			id: textox
			text: "ON"
			font.pointSize: 12
			font.bold: true
			anchors.left: parent.left
			anchors.leftMargin: 10
			anchors.verticalCenter: parent.verticalCenter
			}
			
			Text {
			id: textoy
			text: "OFF"
			color: "#e0e0e0"
			font.pointSize: 12
			font.bold: true
			anchors.right: parent.right
			anchors.rightMargin: 10
			anchors.verticalCenter: parent.verticalCenter
			}

    }

    Rectangle
    {
        id: knob
        width: backgroundHeight+10; 
        height: backgroundHeight+10
        radius: width
        gradient: Gradient
        {
            GradientStop { position: 0.0; color: "#a0a0a0" }
            GradientStop { position: 1.0; color: "#e0e0e0" }
        }

        MouseArea
        {
            anchors.fill: parent
            enabled:toggleEnabled
            drag.target: knob; 
            drag.axis: Drag.XAxis; 
            drag.minimumX: 1; 
            drag.maximumX: backgroundWidth-backgroundHeight //40 
            onClicked:
            {
                toggle();
            }
            onReleased:
            {
                releaseSwitch();
                toggleswitch.released(on);
            }
        }
    }

    Rectangle
    {
        id: backgroundDisabled
        width: 70; 
        height: 30
        radius: 30
        color: "#313E53"
        opacity: 0.8
        visible: !toggleEnabled
 
    }

    states:
    [
        State
        {
            name: "on"
            PropertyChanges { target: knob; x: backgroundWidth-backgroundHeight-10 }
            PropertyChanges { target: toggleswitch; on: true }
            PropertyChanges { target: background; color: toggleswitch.colorbg }

        },
        State
        {
            name: "off"
            PropertyChanges { target: knob; x: 1 }
            PropertyChanges { target: toggleswitch; on: false }
            PropertyChanges { target: background; color: "#313E53" }
        }
    ]

    transitions:
    Transition
    {
        NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 200 }
    }
}

