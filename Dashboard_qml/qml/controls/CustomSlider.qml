import QtQuick 2.2

Item {
    id:slider
    height: heightSlider

    signal released(int value)
    signal pressed()

    property real value: 1
    onValueChanged: updatePos();
    property real minimum: 1
    property real maximum: 1
    property real step: 1
    property int xMax: width - handle.width
    onXMaxChanged: updatePos();
    onMinimumChanged: updatePos();

    property color backgroundEmpty: "lightgrey";
    property color backgroundFull: "#39F724";
    property real  backgroundopacity: 1;
    property real  backgroundopacityFull: 1;
    property color pressCircle: "#39F724"
    property color handleGrad1: "lightgray"
    property color handleGrad2: "gray"
    property real  heightSlider: 10
    property real  fullCircle: 30
    property real  circleWidth: 70
    property real  circleHeight: 70

    function updatePos()
    {
        if (maximum > minimum)
        {
            var pos = (value - minimum) * slider.xMax / (maximum - minimum);
            pos = Math.min(pos, width - handle.width / 2);
            pos = Math.max(pos, 0);
            handle.x = pos;
        } else
        {
            handle.x = 0;
        }
    }


    Rectangle
    {
        id:background
        x: 15
        height: heightSlider
        width: slider.width - 30
        border.color: "white"; border.width: 0; radius: heightSlider *2
        color: backgroundEmpty
        opacity: backgroundopacity
    }

    Rectangle
    {
        id:sliderFilled
        width: handle.x + (handle.width / 2)
        height: heightSlider
        border.color: "white"; border.width: 0; radius: heightSlider * 2
        color: backgroundFull
        opacity: backgroundopacityFull
    }


    Rectangle
    {
        id: handle; smooth: true
        width: fullCircle; height: fullCircle; radius: fullCircle/2
        anchors.verticalCenter: parent.verticalCenter
        gradient: Gradient
        {
            GradientStop { position: 0.0; color: handleGrad1 }
            GradientStop { position: 1.0; color: handleGrad1 }
        }

        Rectangle
        {
            id:circle; smooth: true
            visible:false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width:circleWidth
            height: circleHeight; radius: circleWidth/2
            color:"transparent"
            border.width: 4
            border.color: pressCircle
        }

        MouseArea
        {
            id: mouse
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width:70
            height: 70
            drag.target: parent
            drag.axis: Drag.XAxis; drag.minimumX: 0; drag.maximumX: slider.xMax

            onPositionChanged:
            {
                var stepPixel = ((slider.width - 30) * slider.step) / (maximum - minimum);
                var numSteps = Math.round(handle.x / stepPixel);
                handle.x = numSteps * stepPixel;
                value = Math.round(numSteps * slider.step) + minimum;
            }

            onPressed:
            {
                circle.visible = true;
                slider.pressed();
            }

            onReleased:
            {
                circle.visible = false;
                var stepPixel = ((slider.width - 30) * slider.step) / (maximum - minimum);
                var numSteps = Math.round(handle.x / stepPixel);
                handle.x = numSteps * stepPixel;
                value = Math.round(numSteps * slider.step) + minimum;
                slider.released(value);
            }
        }
    }
}
