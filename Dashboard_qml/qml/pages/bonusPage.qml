import QtQuick 2.0
import QtCharts 2.1
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import "../controls"

Item {
	
	Rectangle {
		id: rectangle
		color: "#1c313c"
		anchors.fill: parent
		
		///###### INI RECTANGLE PANEL ##################################
		Rectangle {
			id: panel
			anchors.top: parent.top
			anchors.topMargin: 10
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.leftMargin: 10
			width: 160
			color: "#1c313c"
			
			ColumnLayout {
				anchors.left: parent.left
				anchors.leftMargin: 20
				spacing: 8
				
				Text {
					text: "Scope"
					font.pointSize: 18
					font.bold: true
					color: "#ff0000"
				}

				MultiButton {
					id: btnSerieType
					text: "Graph: "
					items: ["line", "scatter"]
					onSelectionChanged: {
						//console.debug("test serie "+ btnSerieType.items[currentSelection])
						cv2.changeSeriesType(btnSerieType.items[currentSelection])
					}
				}
				
				MultiButton {
					id: btnRefreshType
					text: "Refresh seg: "
					items: ["1", "2", "3"]
					onSelectionChanged: {
						//console.debug("test refresh "+ btnRefreshType.items[currentSelection] )
						cv2.changeRefreshRate(btnRefreshType.items[currentSelection])
					}
				}
				
				MultiButton {
					id: btnAntialias
					text: "Antialias: "
					items: ["OFF", "ON"]
					onSelectionChanged : {
						//console.debug("test antialias " + btnAntialias.items[currentSelection]);
						cv2.antialiaschange(btnAntialias.items[currentSelection])
					}
				}
				Rectangle {
					color: "#00000000"
					width: 150
					height: 150
					Text {
						color: "#e0e0e0"
						font.pointSize: 8
						text: "The data plotted here are randomly generated.  This is an example of how data is imported into a series. The source of the data can be from a CSV or a database."
						width: 150
						height: 100
						wrapMode: Text.WordWrap
					}
				}
			}
		}
		///###### END RECTANGLE PANEL ##################################

		///###### INIT SCOPE VIEW ######################################
		Rectangle {
			id: view
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: panel.right
			anchors.leftMargin: 10
			anchors.right: parent.right
			anchors.rightMargin: 10
			color: "#2C313C"

			ChartView{
				id:cv2
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				antialiasing: true
				//theme: ChartView.ChartThemeDark
				
				title: "Custom QtChart demo from data simulated"
				titleColor: "#00ff00"
				titleFont.pointSize:12
				titleFont.bold:true
				legend.visible: true
				legend.alignment: Qt.AlignBottom
				legend.labelColor : "#d0d0d0"
				legend.font.pixelSize:12
				
				backgroundColor : "#00000000"

				
				ValueAxis {
					id: axisY1
					min: -50
					max: 50
					titleText:"<font color='#ffa500'>Scale for IR Signal 1 and IR Signal 2</font>"
					color:"#00ff00"
					labelsColor: "#D68B00"
				}
				ValueAxis {
					id: axisY2
					min: -150
					max: 150
					titleText:"<font color='#00ff00'>Scale for  IR Signal 3 and IR Signal 4</font>"
					color:"#ffa500"
					labelsColor: "#00AD00"
				}

				ValueAxis {
					id: axisX
					min: 0
					max: 128
					titleText:"<font color='#a5ff00'>Number of samples</font>"
					color:"#0080ff"
					labelsColor: "#00F4FF"
				}

				LineSeries {
					name: "IR signal 1"
					id:lines1
					axisX: axisX
					axisY: axisY1
					width: 1
					color: "#00a5ff"
				}

				LineSeries {
					name: "IR signal 2"
					id:lines2
					axisX: axisX
					axisY: axisY1
					width: 1
					color: "#ffa500"
				}
				
				LineSeries {
					name: "IR signal 3"
					id:lines3
					axisX: axisX
					axisYRight: axisY2
					width: 1
					color: "#a5ff00"
				}
				
				LineSeries {
					name: "IR signal 4"
					id:lines4
					axisX: axisX
					axisYRight: axisY2
					width: 1
					color: "#ff0000"
				}
				
				Timer {
					id: refreshTimer
					interval: 750
					running: true
					repeat: true
					onTriggered: {
						backend.update0(cv2.series(0));
						backend.update1(cv2.series(1));
						backend.update2(cv2.series(2));
						backend.update3(cv2.series(3));
					}
				}
				
				function changeSeriesType(type) {
					cv2.removeAllSeries();
					// Create  new series of the correct type. Axis x is the same for all series,
					// but the series have their own y-axes to make it possible to control the y-offset
					// of the "signal sources".
						if (type == "line") {
							var series1 = cv2.createSeries(ChartView.SeriesTypeLine, "IR signal 1",axisX, axisY1);
										series1.width = 2;
										series1.color = "#ffa500";

							var series2 = cv2.createSeries(ChartView.SeriesTypeLine, "IR signal 2", axisX, axisY1);
										series2.width = 2;
										series2.color = "#a5ff00";
							
							var series3 = cv2.createSeries(ChartView.SeriesTypeLine, "IR signal 3", axisX, axisY1);
										series3.width = 2;
										series3.color = "#00a5ff";
							
							var series4 = cv2.createSeries(ChartView.SeriesTypeLine, "IR signal 4", axisX, axisY1);
										series4.width = 2;
										series4.color = "#ff0000";
						} 
						else {
							var series1 = cv2.createSeries(ChartView.SeriesTypeScatter, "IR signal 1",axisX, axisY1);
										series1.markerSize = 3;
										series1.color = "#ffa500";
										series1.borderColor = "transparent";

							var series2 = cv2.createSeries(ChartView.SeriesTypeScatter, "IR signal 2", axisX, axisY1);
										series2.markerSize = 3;
										series2.color = "#a5ff00";
										series2.borderColor = "transparent";
							
							var series3 = cv2.createSeries(ChartView.SeriesTypeScatter, "IR signal 3",axisX, axisY1);
										series3.markerSize = 3;
										series3.color = "#00a5ff";
										series3.borderColor = "transparent";

							var series4 = cv2.createSeries(ChartView.SeriesTypeScatter, "IR signal 4", axisX, axisY1);
										series4.markerSize = 3;
										series4.color = "#ff0000";
										series4.borderColor = "transparent";
						}
				}
					
				function changeRefreshRate(rate) {
					refreshTimer.interval = Number(rate) * 1000;
				}
				
				function antialiaschange(status) {
					if(status=="ON") {
						cv2.antialiasing = true
						}
						else {
						cv2.antialiasing = false
						}
				}
			}
		}
		///###### END SCOPE VIEW ####################
    }
}


