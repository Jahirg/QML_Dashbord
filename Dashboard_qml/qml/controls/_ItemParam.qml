import QtQuick 2.2

Item
{
    width: 200
    height: width

    property string title: "  "
    property string unit: "  "
    property real paramValue: 0
    property real minValue: 0
    property real maxValue: 100
    property real regMinValue: 1
    property real regMaxValue: 50

    FontLoader
    {
        id: fontHelveticaSemibold
        source:"images/helvetica.ttf"
    }

    Rectangle
    {
        anchors.centerIn: parent
        width: parent.width
        height: width
        radius: width * 0.5
        color: "black"
        opacity: 0.4
    }

    Rectangle
    {
        id:ctrlVolume
        color: "transparent"
        width: parent.width
        height: width
        radius: width * 0.5
        anchors.centerIn: parent

        Text    // Titolo del parametro
        {
            id:paramName
            text: title
            color: "#CCFFFF"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 25
            font.pointSize: 15
            font.family: fontHelvetica.name
        }



        Text    // Valore del parametro
        {
            id: textValue
            text: paramValue
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 30
            font.family: fontHelveticaSemibold.name
        }

        Text    // Unità di misura del parametro
        {
            text: unit
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 18
            anchors.bottom: parent.bottom
            font.pointSize: 16
            font.family: fontHelveticaSemibold.name
        }

        Canvas
        {
            id: canvas
            anchors.centerIn: parent
            width: parent.width - 10
            height: width
            antialiasing: true
            smooth: true
            visible: true

            signal bar_event()
            property color primaryColor: "lightgrey"//"#778899"   // Sfondo
            property color secondaryColor: "red" //"#FFA500"//"#00ff00" // Riempimento

            property real centerWidth: (width / 2)
            property real centerHeight: (height / 2)
            property real radius: (width - 15) / 2

            property real minimumValue: minValue
            property real maximumValue: maxValue
            property real currentValueR: paramValue
            property real angle: (currentValueR - minimumValue) / (maximumValue - minimumValue) * (endAngle - startAngle)
            property real startAngle: Math.PI - 1
            property real endAngle: Math.PI * 2 + 1
            property string text: "Più"
            property string text2: "Meno"

            signal clicked()
            onPrimaryColorChanged: requestPaint()
            onSecondaryColorChanged: requestPaint()
            onMinimumValueChanged: requestPaint()
            onMaximumValueChanged: requestPaint()
            onCurrentValueRChanged: requestPaint()

            onPaint:
            {
                var ctx = getContext("2d");
                ctx.save();
                /*
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.beginPath();
                ctx.lineWidth = 10;
                ctx.arc(currentValueR);
                ctx.fill(canvas.text);
                */
                ctx.beginPath();
                ctx.lineWidth = 12;
                ctx.lineCap = "round"
                ctx.strokeStyle = primaryColor;
                ctx.arc(canvas.centerWidth,
                        canvas.centerHeight,
                        canvas.radius,
                        startAngle,
                        endAngle);
                ctx.stroke();

                ctx.beginPath();
                ctx.lineWidth = 12;
                ctx.lineCap = "round"
                ctx.strokeStyle = canvas.secondaryColor;

                ctx.arc(canvas.centerWidth,
                        canvas.centerHeight,
                        canvas.radius,
                        canvas.startAngle,
                        canvas.startAngle + canvas.angle);
                    ctx.stroke();
                    ctx.restore();
            }
        }
    }
}
