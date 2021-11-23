import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.14
import QtQuick.Shapes 1.14
import QtGraphicalEffects 1.0

import "../controls"

Item {

	Rectangle {
		id: rectangle
		color: "#2c313c"
		anchors.fill: parent
		
	////////////////////////////////////////////////////////////////////
	// ############## INI GAUGE 1 ######################################
	Rectangle {
		id:rect1
		width: 220
        height: 220
        anchors.top : parent.top
        anchors.topMargin: 30
        anchors.left : parent.left
        anchors.leftMargin: 40
        visible: true
        color: "#00000000"
		
		//###### Shader effect to provide gradient-based gauge #########
		ShaderEffect {
			id: gaugeA
			anchors.fill: parent
			opacity: 0.85  
			property real angleBase: -pi*0.80
			property real angle: ((1.6*pi*(gauge1.value)/80)+pi*(0.8-(1.6*100/80)))
			// ANGLE= [1.6*PI*(MEASURE)/(MAX-MIN)]+PI*(0.8-(1.6*MAX/(MAX-MIN)))
			readonly property real pi: 3.1415926535897932384626433832795
			vertexShader: "
			uniform highp mat4 qt_Matrix;
			attribute highp vec4 qt_Vertex;
			attribute highp vec2 qt_MultiTexCoord0;
			varying highp vec2 coord;
			
			void main() {
				coord = qt_MultiTexCoord0;
				gl_Position = qt_Matrix * qt_Vertex;
				}"

			fragmentShader: "
			uniform lowp float qt_Opacity;
			uniform highp float angleBase;
			uniform highp float angle;
			varying highp vec2 coord;
			void main() {
				gl_FragColor = vec4(0.0,0.0,0.0,0.0); 
				highp vec2 d=2.0*coord-vec2(1.0,1.0);
				highp float r=length(d);
				if (0.3<=r && r<=0.9) {
					highp float a=atan(d.x,-d.y);
					if (angleBase<=a && a<=angle) {
						highp float p=(a-angleBase)/(angle-angleBase);
						gl_FragColor = vec4(0,0.0,0.4+0.6*p,p) * qt_Opacity;
						}
					}
				}"
			}
		//##### END Shader effect  #####################################
		CircularGauge {
			
			Behavior on value {
				NumberAnimation {
					duration: 900
				}
			}
			id: gauge1
			width: 0.9*rect1.width
			height: 0.9*rect1.width
			maximumValue: 100
			minimumValue: 20
			value: 100
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style
				labelInset: outerRadius * 0.45
				labelStepSize: 10
				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
				
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.1;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						ctx.beginPath();
						ctx.strokeStyle = "#ffff00";
						ctx.lineWidth = outerRadius * 0.05;
						ctx.arc(outerRadius, outerRadius, 0.75*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						ctx.beginPath();
						ctx.strokeStyle = "#ff00ff";
						ctx.lineWidth = outerRadius * 0.03;
						ctx.arc(outerRadius, outerRadius, 0.85*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(90) - 90));
						ctx.stroke();
						///
						///
						
					}
				}

				tickmark: Rectangle {
					visible: styleData.value < 20 || styleData.value % 10 == 0  // styleData.value < 3 || 
					implicitWidth: outerRadius * 0.03
					antialiasing: true
					implicitHeight: outerRadius * 0.35
					color: styleData.value <= 50 ? "#ff8000" : "#e5e5e5"
				}

				minorTickmark: Rectangle {
					visible: styleData.value > 20  //|| styleData.value % 20 == 0
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.25
					color: styleData.value <= 40 ? "#ff8000" : "#e5e5e5"
				}

				tickmarkLabel:  Text {
					visible: styleData.value < 110
					font.pixelSize: Math.max(6, outerRadius * 0.15)
					text: styleData.value
					color: styleData.value <= 40 ? "#e34c22" : "#e5e5e5"
					antialiasing: true
				}
				/*
				//#################
				needle: Canvas {
					property real needleBaseWidth: 6
					property real needleLength: outerRadius 
					property real needleTipWidth: 1
					implicitWidth: needleBaseWidth
					implicitHeight: needleLength

					property real xCenter: width / 2
					property real yCenter: height / 2

					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();

						ctx.beginPath();
						ctx.moveTo(xCenter, height-30);
						ctx.lineTo(xCenter - needleBaseWidth / 2, (height-30) - needleBaseWidth / 2);
						ctx.lineTo(xCenter - needleTipWidth / 2, 0);
						//ctx.lineTo(xCenter, yCenter - needleLength-30);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.rgba(0, 0.9, 0, 0.9);
						ctx.fill();

						
						ctx.beginPath();
						ctx.moveTo(xCenter, height-30)
						ctx.lineTo(width, height-30 - needleBaseWidth / 2);
						ctx.lineTo(xCenter + needleTipWidth / 2, 0);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.lighter(Qt.rgba(0, 0.7, 0, 0.9));
						ctx.fill();
						
					}
				}
				//##################
				*/
				needle: Rectangle {
					y: outerRadius * -0.3
					implicitWidth: outerRadius * 0.05
					implicitHeight: outerRadius * 0.7
					antialiasing: true
					color: "#00ff00"
				}
				
				foreground: Item {
					Rectangle {
					}
				}

			}
			Rectangle {
				id:rectsg1
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge1.width
				height: 0.13*gauge1.width
				color: "#00000000"
				Text {
					id:textgauge1
					anchors.horizontalCenter: parent.horizontalCenter
					y: 0.3*gauge1.width
					text: Math.floor(gauge1.value)
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color: gauge1.value <= 50 ? "#ffff00" : "#e5e5e5"
				}
			}
			//
			Rectangle {
				id:rectsg1a
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge1.width
				height: 0.13*gauge1.width
				color: "#00000000"
				Text {
					id:textgauge1a
					anchors.horizontalCenter: parent.horizontalCenter
					y: -10
					text: "kw"
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color: "#e5e5e5"
				}
			}

			Label {
                text: "AI 0"
                color: "#00A5FF"
                font.pointSize: 16
                anchors.bottom: gauge1.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
		}
	
	}
	// ############## FIN GAUGE 1  #####################################
	
	////////////////////////////////////////////////////////////////////
	
	// ############## INI GAUGE 2  #####################################
	Rectangle {
		id:rect2
		width: 220
        height: 220
        anchors.top : parent.top
        anchors.topMargin: 30
        anchors.left : parent.left
        anchors.leftMargin: 300
        visible: true
        color: "#00000000"
		
		//###### Shader effect to provide gradient-based gauge #########
		ShaderEffect {
			id: shader2
			anchors.fill: parent
			opacity: 0.85  
			property real angleBase: -pi*0.80
			property real angle: ((1.6*pi*(gauge2.value)/(gauge2.maximumValue-gauge2.minimumValue))+pi*(0.8-(1.6*gauge2.maximumValue/(gauge2.maximumValue-gauge2.minimumValue))))
			// ANGLE= [1.6*PI*(MEASURE)/(MAX-MIN)]+PI*(0.8-(1.6*MAX/(MAX-MIN)))
			readonly property real pi: 3.1415926535897932384626433832795
			vertexShader: "
			uniform highp mat4 qt_Matrix;
			attribute highp vec4 qt_Vertex;
			attribute highp vec2 qt_MultiTexCoord0;
			varying highp vec2 coord;
			
			void main() {
				coord = qt_MultiTexCoord0;
				gl_Position = qt_Matrix * qt_Vertex;
				}"

			fragmentShader: "
			uniform lowp float qt_Opacity;
			uniform highp float angleBase;
			uniform highp float angle;
			varying highp vec2 coord;
			void main() {
				gl_FragColor = vec4(0.0,0.0,0.0,0.0); 
				highp vec2 d=2.0*coord-vec2(1.0,1.0);
				highp float r=length(d);
				if (0.6<=r && r<=0.9) {
					highp float a=atan(d.x,-d.y);
					if (angleBase<=a && a<=angle) {
						highp float p=(a-angleBase)/(angle-angleBase);
						gl_FragColor = vec4(0,0.0,0.4+0.6*p,p) * qt_Opacity;
						}
					}
				}"
			}
		//##### END Shader effect  #####################################
		CircularGauge {
			
			Behavior on value {
				NumberAnimation {
					duration: 900
				}
			}
			id: gauge2
			width: 0.9*rect2.width
			height: 0.9*rect2.width
			maximumValue: 200
			minimumValue: 0
			value: 100
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style2
				labelInset: outerRadius * 0.22
				labelStepSize: 20
				minorTickmarkInset :45
				tickmarkInset : 6
				minorTickmarkCount : 5
				tickmarkStepSize : 20
				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
				
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						/*
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.1;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						ctx.beginPath();
						ctx.strokeStyle = "#ffff00";
						ctx.lineWidth = outerRadius * 0.05;
						ctx.arc(outerRadius, outerRadius, 0.75*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						*/
						ctx.beginPath();
						ctx.strokeStyle = "#f0f0f0";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, 1*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(gauge2.maximumValue) - 90));
						ctx.stroke();
						
						ctx.beginPath();
						ctx.strokeStyle = "#f0f0f0";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, 0.67*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(gauge2.maximumValue) - 90));
						ctx.stroke();
						
					}
				}

				
				tickmark: Rectangle {
					visible: styleData.value > 0  //|| styleData.value % 20 == 0  // styleData.value < 3 || 
					implicitWidth: outerRadius * 0.03
					antialiasing: true
					implicitHeight: outerRadius * 0.05
					color: styleData.value <= 50 ? "#ffff00" : "#ffff00"
				}
				

				minorTickmark: Rectangle {
					visible: styleData.value > 0 //styleData.value < 20  //|| styleData.value % 1 == 0
					implicitWidth: outerRadius * 0.05
					antialiasing: true
					implicitHeight: outerRadius * 0.07
					color: styleData.value < gauge2.value ? "#00ff00" : "#404040"
					
				}

				tickmarkLabel:  Text {
					visible: styleData.value > 0
					font.pixelSize: Math.max(6, outerRadius * 0.12)
					text: styleData.value
					color: styleData.value <= 40 ? "#e0e0e0" : "#e0e0e0"
					antialiasing: true
				}
				//#################
				needle: Canvas {
					property real needleBaseWidth: 10
					property real needleLength: outerRadius
					property real needleTipWidth: 1
					property real needleShort: outerRadius*0.6
					implicitWidth: needleBaseWidth
					implicitHeight: needleLength

					property real xCenter: width / 2
					property real yCenter: height / 2

					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();

						ctx.beginPath();
						ctx.moveTo(xCenter, height-needleShort);
						ctx.lineTo(xCenter - needleBaseWidth / 2, (height-needleShort) - needleBaseWidth / 2);
						ctx.lineTo(xCenter - needleTipWidth / 2, 0);
						//ctx.lineTo(xCenter, yCenter - needleLength-needleShort);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.rgba(0, 0.9, 0, 0.9);
						ctx.fill();

						
						ctx.beginPath();
						ctx.moveTo(xCenter, height-needleShort)
						ctx.lineTo(width, height-needleShort - needleBaseWidth / 2);
						ctx.lineTo(xCenter + needleTipWidth / 2, 0);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.lighter(Qt.rgba(0, 0.7, 0, 0.9));
						ctx.fill();
						
					}
				}
				//##################
				foreground: Item {
					Rectangle {
					}
				}

			}
			Rectangle {
				id:rectsg2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge2.width
				height: 0.13*gauge2.width
				color: "#00000000"
				Text {
					id:textgauge2
					anchors.horizontalCenter: parent.horizontalCenter
					y: 70
					text: Math.floor(gauge2.value)
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color:"#e5e5e5"
				}
			}
			//
			Rectangle {
				id:rectsg2a
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge2.width
				height: 0.13*gauge2.width
				color: "#00000000"
				Text {
					id:textgauge2a
					anchors.horizontalCenter: parent.horizontalCenter
					y: -10
					text: "Km/h"
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color: "#e5e5e5"
				}
			}
			Label {
                text: "AI 1"
                color: "#00A5FF"
                font.pointSize: 16
                anchors.bottom: gauge2.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
		}
	
	}
	// ############## FIN GAUGE  2  ####################################
	
	////////////////////////////////////////////////////////////////////
	
		// ############## INI GAUGE 3  #####################################
	Rectangle {
		id:rect3
		width: 220
        height: 220
        anchors.top : parent.top
        anchors.topMargin: 30
        anchors.left : parent.left
        anchors.leftMargin: 550
        visible: true
        color: "#00000000"
		//###### Shader effect to provide gradient-based gauge #########
		ShaderEffect {
			id: shader3
			antialiasing: true
			anchors.fill: parent
			opacity: 0.95  
			property real angleBase: -pi*0.80
			property real angle: ((1.6*pi*(gauge3.value)/(gauge3.maximumValue-gauge3.minimumValue))+pi*(0.8-(1.6*gauge3.maximumValue/(gauge3.maximumValue-gauge3.minimumValue))))
			// ANGLE= [1.6*PI*(MEASURE)/(MAX-MIN)]+PI*(0.8-(1.6*MAX/(MAX-MIN)))
			readonly property real pi: 3.1415926535897932384626433832795
			vertexShader: "
			uniform highp mat4 qt_Matrix;
			attribute highp vec4 qt_Vertex;
			attribute highp vec2 qt_MultiTexCoord0;
			varying highp vec2 coord;
			
			void main() {
				coord = qt_MultiTexCoord0;
				gl_Position = qt_Matrix * qt_Vertex;
				}"

			fragmentShader: "
			uniform lowp float qt_Opacity;
			uniform highp float angleBase;
			uniform highp float angle;
			varying highp vec2 coord;
			void main() {
				gl_FragColor = vec4(0.0,0.0,0.0,0.0); 
				highp vec2 d=2.0*coord-vec2(1.0,1.0);
				highp float r=length(d);
				if (0.45<=r && r<=0.55) {
					highp float a=atan(d.x,-d.y);
					if (angleBase<=a && a<=angle) {
						highp float p=(a-angleBase)/(angle-angleBase);
						gl_FragColor = vec4(0.4+0.6*p,0,0,p) * qt_Opacity;
						}
					}
				}"
			}
		//##### END Shader effect  #####################################
		CircularGauge {
			
			Behavior on value {
				NumberAnimation {
					duration: 900
				}
			}
			id: gauge3
			width: 0.9*rect3.width
			height: 0.9*rect3.width
			maximumValue: 200
			minimumValue: 0
			value: 100
			anchors.centerIn: parent
			style: CircularGaugeStyle {
				id: style3
				labelInset: outerRadius * 0.01
				labelStepSize: 20
				minorTickmarkInset :25
				tickmarkInset : 14
				minorTickmarkCount : 5
				tickmarkStepSize : 20
				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}

				background: Canvas {
				
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						/*
						ctx.beginPath();
						ctx.strokeStyle = "#ff8000";
						ctx.lineWidth = outerRadius * 0.1;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						ctx.beginPath();
						ctx.strokeStyle = "#ffff00";
						ctx.lineWidth = outerRadius * 0.05;
						ctx.arc(outerRadius, outerRadius, 0.75*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(20) - 90), degreesToRadians(valueToAngle(50) - 90));
						ctx.stroke();
						
						ctx.beginPath();
						ctx.strokeStyle = "#f0f0f0";
						ctx.lineWidth = outerRadius * 0.03;
						ctx.arc(outerRadius, outerRadius, 1*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(gauge3.maximumValue) - 90));
						ctx.stroke();
						
						ctx.beginPath();
						ctx.strokeStyle = "#f0f0f0";
						ctx.lineWidth = outerRadius * 0.03;
						ctx.arc(outerRadius, outerRadius, 0.67*outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(gauge3.maximumValue) - 90));
						ctx.stroke();
						*/
						
					}
				}

				
				tickmark: Rectangle {
					visible: styleData.value >= 0  //|| styleData.value % 20 == 0  // styleData.value < 3 || 
					implicitWidth: outerRadius * 0.03
					antialiasing: true
					implicitHeight: outerRadius * 0.2
					color: styleData.value <= 50 ? "#ffff00" : "#ffff00"
				}
				

				minorTickmark: Rectangle {
					visible: styleData.value > 0 //styleData.value < 20  //|| styleData.value % 1 == 0
					implicitWidth: outerRadius * 0.01
					antialiasing: true
					implicitHeight: outerRadius * 0.1
					color: styleData.value <= 40 ? "#00ff00" : "#00ff00"
				}

				tickmarkLabel:  Text {
					visible: styleData.value >= 0
					font.pixelSize: Math.max(6, outerRadius * 0.15)
					text: styleData.value
					color: styleData.value <= 40 ? "#e0e0e0" : "#e0e0e0"
					antialiasing: true
				}
				//#################
				needle: Canvas {
					property real needleBaseWidth: 10
					property real needleLength: outerRadius*0.7
					property real needleTipWidth: 1
					property real needleShort: outerRadius*0.01
					implicitWidth: needleBaseWidth
					implicitHeight: needleLength

					property real xCenter: width / 2
					property real yCenter: height / 2

					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();

						ctx.beginPath();
						ctx.moveTo(xCenter, height-needleShort);
						ctx.lineTo(xCenter - needleBaseWidth / 2, (height-needleShort) - needleBaseWidth / 2);
						ctx.lineTo(xCenter - needleTipWidth / 2, 0);
						//ctx.lineTo(xCenter, yCenter - needleLength-needleShort);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.rgba(0, 0.9, 0, 0.9);
						ctx.fill();

						
						ctx.beginPath();
						ctx.moveTo(xCenter, height-needleShort)
						ctx.lineTo(width, height-needleShort - needleBaseWidth / 2);
						ctx.lineTo(xCenter + needleTipWidth / 2, 0);
						ctx.lineTo(xCenter, 0);
						ctx.closePath();
						ctx.fillStyle = Qt.lighter(Qt.rgba(0, 0.7, 0, 0.9));
						ctx.fill();
						
					}
				}
				//##################
				/*
				needle: Rectangle {
					y: outerRadius * -0.3
					implicitWidth: outerRadius * 0.05
					implicitHeight: outerRadius * 0.7
					antialiasing: true
					color: "#00ff00"
				}
				*/
				foreground: Item {
					Rectangle {
					}
				}

			}
			Rectangle {
				id:rectsg3
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge3.width
				height: 0.13*gauge3.width
				color: "#00000000"
				Text {
					id:textgauge3
					anchors.horizontalCenter: parent.horizontalCenter
					y: 70
					text: Math.floor(gauge3.value)
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color: "#e5e5e5"
				}
			}
			//
			Rectangle {
				id:rectsg3a
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*gauge3.width
				height: 0.13*gauge3.width
				color: "#00000000"
				Text {
					id:textgauge3a
					anchors.horizontalCenter: parent.horizontalCenter
					y: -10
					text: "IA"
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.4)
					color: "#e5e5e5"
				}
			}
			Label {
                text: "AI 3"
                color: "#00A5FF"
                font.pointSize: 16
                anchors.bottom: gauge3.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
		}
	
	}
	// ############## FIN GAUGE  3  ####################################
	////////////////
	Rectangle {
        width: 200
        height: 200
        anchors.top : parent.top
        anchors.topMargin: 300
        anchors.left : parent.left
        anchors.leftMargin: 50
        visible: true
        color: "#00000000"
		
		CircularSlider {
            id: slider

            handleVerticalOffset: -30
            trackWidth: 5
            trackColor: "#FEFEFE"
            width: parent.width
            height: parent.height
            minValue: 0
            maxValue: 12
            //value: customSlider.value*12
            snap: true
            stepSize: 1
            hideProgress: true
            hideTrack: true
            interactive: false
            Behavior on value {
				NumberAnimation {
					duration: 900
				}
			}

            /// Custom Handle
            handle: Item {
                id: item

                width: 24
                height: 24

                Shape {
                    anchors.fill: parent
                    rotation: 180

                    ShapePath {
                        strokeWidth: 1
                        strokeColor: "#FF5555"
                        fillColor: "#FF5555"
                        startX: item.width / 2
                        startY: 0

                        PathLine { x: 0; y: item.height }
                        PathLine { x: item.width; y: item.height }
                        PathLine { x: item.width/2; y: 0 }
                    }
                }

                transform: Translate {
                    x: (slider.handleWidth - width) / 2
                    y: (slider.handleHeight - height) / 2
                }
            }

/*
            Repeater {
                model: 6

                delegate: Rectangle {
                    anchors.centerIn: parent
                    height: slider.height
                    width: 1
                    color: "#191919"
                    transform: Rotation {
                        origin.x: 1
                        origin.y: slider.height / 2
                        angle: 30 * index
                    }
                }
            }
*/
            /// Inner Trinagle
            Shape {
                id: triangle
                width: 20
                height: parent.height / 2
                x: (parent.width - width ) / 2
                y: 0
                transform: Rotation {
                    origin.x: triangle.width / 2
                    origin.y: triangle.height
                    angle: slider.angle
                }

                ShapePath {
                    strokeWidth: 1
                    strokeColor: "#50FA7B"
                    fillColor: "#50FA7B"
                    startX: triangle.width / 2
                    startY: 0

                    PathLine { x: 0; y: triangle.height }
                    PathLine { x: triangle.width; y: triangle.height }
                    PathLine { x: triangle.width/2; y: 0 }
                }
            }

            /// Inner Circle
            Rectangle {
                color: "#232323"
                width: 120
                height: width
                radius: width / 2
                anchors.centerIn: parent

                Label {
                    anchors.centerIn: parent
                    font.pointSize: 20
                    color: "#FEFEFE"
                    text: slider.value === 0 ? Number(12) : Number((slider.value).toFixed(1)).toString().padStart(1, '0')
                }
            }

            /// Outer Dial
            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: "#fefefe"
                border.width: 4
                radius: width / 2
            }

            /// Numbers
            Label {
                text: "12"
                color: "#fefefe"
                font.pointSize: 16
                anchors.bottom: slider.top
                anchors.bottomMargin: 1
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "3"
                color: "#fefefe"
                font.pointSize: 16
                anchors.left: slider.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: "6"
                color: "#fefefe"
                font.pointSize: 16
                anchors.top: slider.bottom
                anchors.topMargin: 1
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: "9"
                color: "#fefefe"
                font.pointSize: 16
                anchors.right: slider.left
                anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter 
			//y: 220
			width: 0.26*parent.width
			height: 0.13*parent.width
			color: "#00000000"
			Text {
				anchors.horizontalCenter: parent.horizontalCenter
				y: 0.6*parent.width
				text: "MKS"
				font.family: "Helvetica"
				font.pointSize: Math.max(6, parent.width * 0.2)
				color: "#e5e5e5"
			}
		}
		Label {
			text: "AI 4"
			color: "#00A5FF"
			font.pointSize: 16
			anchors.bottom: slider.top
			anchors.bottomMargin: 30
			anchors.horizontalCenter: parent.horizontalCenter
		}
    }    
	////////////////
	Rectangle {
        width: 200
        height: 200
        anchors.top : parent.top
        anchors.topMargin: 300
        anchors.left : parent.left
        anchors.leftMargin: 310
        visible: true
        color: "#00000000"
        CircularSlider {
                id: progressIndicator
                hideProgress: true
                hideTrack: true
                width: parent.width
                height: parent.height

                interactive: false
                minValue: 0
                maxValue: 100
                value: 0.5//inputSlider.value
                startAngle: 0
                endAngle: 270
                rotation: 225

                Repeater {
                    model: 72

                    Rectangle {
                        id: indicator
                        width: 5
                        height: 20
                        radius: width / 2
                        //color: indicator.angle > progressIndicator.angle ? "#16171C" : "#7CFF6E"
                        color: indicator.angle > progressIndicator.endAngle ? "#00000000" : (indicator.angle > progressIndicator.angle ? "#282A36" : "#7CFF6E")
                        readonly property real angle: index * 5
                        transform: [
                            Translate {
                                x: progressIndicator.width / 2 - width / 2
                            },
                            Rotation {
                                origin.x: progressIndicator.width / 2
                                origin.y: progressIndicator.height / 2
                                angle: indicator.angle
                            }
                        ]
                    }
                }
                
            }
            Label {
				anchors.centerIn: parent
				font.pointSize: 20
				color: "#FEFEFE"
				text: Number((progressIndicator.value).toFixed(1)).toString().padStart(1, '0')
				//text : indicator.angle
           }
           Rectangle {
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter 
				//y: 220
				width: 0.26*parent.width
				height: 0.13*parent.width
				color: "#00000000"
				Text {
					anchors.horizontalCenter: parent.horizontalCenter
					y: 0.45*parent.width
					text: "RPMS"
					font.family: "Helvetica"
					font.pointSize: Math.max(6, parent.width * 0.3)
					color: "#e5e5e5"
				}
			}
			Label {
				text: "AI 5"
				color: "#00A5FF"
				font.pointSize: 16
				anchors.bottom: progressIndicator.top
				anchors.bottomMargin: 10
				anchors.horizontalCenter: parent.horizontalCenter
				}
        }
	/////////////////
	Rectangle {
        width: 200
        height: 200
        anchors.top : parent.top
        anchors.topMargin: 300
        anchors.left : parent.left
        anchors.leftMargin: 560
        visible: true
        color: "#00000000"
        CircularSlider {
            id: customSlider
            hideProgress: true
            hideTrack: true
            width: parent.width
            height: parent.height

            handleColor: "#6272A4"
            handleWidth: 32
            handleHeight: 32
            minValue: 0
            maxValue: 1000
            interactive: false
            
            Behavior on value {
				NumberAnimation {
					duration: 900
				}
			}

            // Custom progress Indicator
            Item {
                anchors.fill: parent
                anchors.margins: 5
                Rectangle{
                    id: mask
                    anchors.fill: parent
                    radius: width / 2
                    color: "#282A36"
                    border.width: 5
                    border.color: "#44475A"
                }

                Item {
                    anchors.fill: mask
                    anchors.margins: 5
                    layer.enabled: true
                    rotation: customSlider.value / 10 - 50
                    layer.effect: OpacityMask {
                        maskSource: mask
                    }
                    Rectangle {
                        height: parent.height  //customSlider.value / customSlider.maxValue
                        width: parent.width
                        color:"#5B99A6"
                    }
                    Image {
                        id: icon1
                        anchors.fill: parent
                        source: "../../images/svg_images/avion.png"
                        }
                }

                Label {
                    //anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 0.1*parent.width
                    font.pointSize: 20
                    color: "#404040"
                    //text: Number(customSlider.value).toFixed()
                    text: Number(Math.abs(customSlider.value/10-50)).toFixed()
                }
                Rectangle {
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter 
					//y: 220
					width: 0.26*parent.width
					height: 0.13*parent.width
					color: "#00000000"
					Text {
						anchors.horizontalCenter: parent.horizontalCenter
						y: parent.width
						text: "Degrees"
						font.family: "Helvetica"
						font.pointSize: Math.max(6, parent.width * 0.2)
						color: "#404040"
					}
				}
            }
            Label {
                text: "AI 6"
                color: "#00A5FF"
                font.pointSize: 16
                anchors.bottom: customSlider.top
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
	/////////
	}
	//
	Timer{
		id:tmgauge
		interval: 250
		repeat: true
		running: true
		onTriggered: {
			gauge1.value = backend.get_adc1()/10
			gauge2.value = backend.get_adc2()/5
			gauge3.value = backend.get_adc3()/5
			slider.value = backend.get_adc4()/85
			progressIndicator.value = backend.get_adc5()/10
			customSlider.value = backend.get_adc6()
		}
	}
	//
	
	
	Connections{
		target: backend
		//function onValueGauge(value){
        //   slider.value = value/10
        //   progressIndicator.value = value
        //   customSlider.value = value
        //}
	}
}

