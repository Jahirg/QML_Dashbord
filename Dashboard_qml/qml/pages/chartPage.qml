import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


//import QtQuick 2.0
import QtCharts 2.1
import "../controls"


Item {

	Text {
		id: title
		text: qsTr("Analog Measure - Volatile chart")
		anchors.top:  parent.top
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.topMargin: 5
		font.pointSize :18
		color: "#a0a0a0"
	}
	//########## INI CHART VIEW ##############################
	
	ChartView{
        id:cv
        anchors{
            top:title.bottom
            topMargin:10
            left:parent.left
            right:parent.right
            bottom:parent.bottom
            bottomMargin:10
            leftMargin:10
            rightMargin:10
        }
        antialiasing: true
        theme: ChartView.ChartThemeDark

        property int  timcnt: 0
        property double  valueCH1: 0
        property double  valueCH2: 0
        property double  valueCH3: 0
        property double  valueCH4: 0
        //property double  valueTM1: 0        
        property double  periodGRAPH: 30 // Seconds
		property double  startTIME: 0
		property double  intervalTM: 200 // miliseconds

        ValueAxis{
            id:yAxis
            min: 0
            max: 1000
            tickCount: 1
            labelFormat: "%d"
        }

        LineSeries {
			name: "AIN 0"
			id:lines1
			//axisX: xAxis
			axisY: yAxis
			width: 2
			color: "#1267D4"
			axisX: 	DateTimeAxis {
					id: eje
					//format: "yyyy MMM"
					format:"HH:mm:ss.z"
					//format:"mm:ss.z"
				}
		}
        
        LineSeries {
            name: "AIN 1"
            id:lines2
            axisX: eje
            axisY: yAxis
            width: 2
            color: "#ffa500"
        }

        LineSeries {
            name: "AIN 2"
            id:lines3
            axisX: eje
            axisY: yAxis
            width: 2
            color: "#a5ff00"
        }

        LineSeries {
            name: "AIN 3"
            id:lines4
            axisX: eje
            axisY: yAxis
            width: 2
            color: "#ff0000"
        }

        ///
        Timer{
			id:tm
			interval: cv.intervalTM
			repeat: true
			running: true
			onTriggered: {
				cv.timcnt = cv.timcnt + 1
				//cv.valueTM1 = backend.get_tiempo()*1000
				cv.valueCH1 = backend.get_adc1()
				cv.valueCH2 = backend.get_adc2()
				cv.valueCH3 = backend.get_adc3()
				cv.valueCH4 = backend.get_adc4()
				
				if (lines1.count>cv.periodGRAPH*1000/cv.intervalTM){
					lines1.remove(0)
					lines2.remove(0)
					lines3.remove(0)
					lines4.remove(0)
					}
				
				lines1.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH1)
				lines2.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH2)
				lines3.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH3)
				lines4.append(cv.startTIME+cv.timcnt*cv.intervalTM ,cv.valueCH4)
				
				//lines1.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH1)
				//lines2.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH2)
				//lines3.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH3)
				//lines4.append(cv.valueTM1+cv.timcnt*500 ,cv.valueCH4)
				
				//lines1.axisX.min = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME) : new Date(cv.startTIME  - cv.periodGRAPH*1000 + cv.timcnt*1000)
				//lines1.axisX.max = cv.timcnt < cv.periodGRAPH ? new Date(cv.startTIME  + cv.periodGRAPH*1000) : new Date(cv.startTIME   + cv.timcnt*1000)
				
				//lines1.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*500)
				//lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*500)
				
				lines1.axisX.min = new Date(cv.startTIME-cv.periodGRAPH*1000 + cv.timcnt*cv.intervalTM)
				lines1.axisX.max = new Date(cv.startTIME + cv.timcnt*cv.intervalTM)
			}
		}

    }
    Component.onCompleted: {
		cv.startTIME = backend.get_tiempo()*1000
	}
    

	//########## END CHART VIEW ##############################
	
	Connections{
        target: backend
        
	}
}

